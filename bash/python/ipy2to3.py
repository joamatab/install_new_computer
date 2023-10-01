#!/usr/local/bin/python
# Converts an IPython notebook written in python2 to python3.

import json
import os
import subprocess
import sys
import tempfile


def convert_ipy2to3(json_to_convert):
    if "worksheets" in json_to_convert:  # json notebook format v3
        errors = ""
        for worksheet in json_to_convert["worksheets"]:
            error = convert_a_worksheet_ipy2to3(worksheet, "v3")

            if error != "":
                if errors != "":
                    errors += "\r\n\r\n\r\n\r\n"
                errors += error

        return errors

    elif "cells" in json_to_convert:
        return convert_a_worksheet_ipy2to3(json_to_convert, "v4")

    return "notebook-format-error: no cells or worksheets found in the json of the file"


def is_python_code_cell_v3(cell):
    return cell["cell_type"] == "code" and cell["language"] == "python"


def is_python_code_cell_v4(cell):
    return cell["cell_type"] == "code"


def convert_a_worksheet_ipy2to3(worksheet, version):
    if version == "v4":
        code_cells = filter(is_python_code_cell_v4, worksheet["cells"])
    else:
        code_cells = filter(is_python_code_cell_v3, worksheet["cells"])

    errors = ""
    for cell in code_cells:
        error = convert_a_cell_ipy2to3(cell, version)
        if error != "":
            if errors != "":
                errors += "\r\n\r\n"
            errors += error
    return errors


def is_magic(line):
    line = line.strip()
    if len(line) == 0:
        return False
    return line[0] in ["%", "!", "?"] or line[-1] == "?"


# Empties magic lines and returns where they were and what they are
def replace_magic_lines(lines):
    magic_lines = []
    for i, line in enumerate(lines):
        if is_magic(line):
            magic_lines.append((i, lines[i]))
            lines[i] = "\n"
    return magic_lines


def convert_a_cell_ipy2to3(cell, version):
    magic = replace_magic_lines(cell["source" if version == "v4" else "input"])

    file_name = None

    # save cell to file, and have the filename:
    with tempfile.NamedTemporaryFile(mode="w", delete=False) as ostream:
        ostream.writelines(cell["source" if version == "v4" else "input"])
        file_name = ostream.name

    # convert python2 to python3 by executing 2to3:
    # cmd2to3 = ["C:/Anaconda3_64/Scripts/2to3.exe", "--nobackups", "--write", file_name]  # windows example
    try:
        cmd2to3 = ["2to3", "--nobackups", "--write", file_name]
        with open(os.devnull, "w") as nulls:
            subprocess.check_call(cmd2to3, stdout=nulls, stderr=nulls)

        # read converted file back to cell
        with open(file_name) as istream:
            cell["source" if version == "v4" else "input"] = istream.readlines()

        # remove the temporary file
        os.remove(file_name)
        for i, line in magic:
            cell["source" if version == "v4" else "input"][i] = line
        return ""
    except subprocess.CalledProcessError:
        return "error converting cell, cell left unconverted: \r\n" + "".join(
            cell["source" if version == "v4" else "input"]
        )


def main(argv):
    if len(argv) != 3:
        print(f"Usage: {argv[0]} fromfile.ipynb tofile.ipynb")
        return 1

    # maybe to use nbformat to read and write the file like:
    #  nb = nbformat.read('path/to/notebook.ipynb', as_version=4)

    ipy_json = None
    with open(argv[1]) as istream:
        ipy_json = json.load(istream)

    error = convert_ipy2to3(ipy_json)

    if error != "":
        print(error)
        if error.startswith("notebook-format-error"):
            return 1

    # took the following from saving a notebook with python3 (see file dummy-v4-py3.ipynb) :

    version3example = """
{
"metadata": {
  "kernelspec": {
   "display_name": "Python [default]",
   "language": "python",
   "name": "python3"
  },
  "language_info": {
   "codemirror_mode": {
    "name": "ipython",
    "version": 3
   },
   "file_extension": ".py",
   "mimetype": "text/x-python",
   "name": "python",
   "nbconvert_exporter": "python",
   "pygments_lexer": "ipython3",
   "version": "3.5.2"
  }
 }
}
    """

    # add version information
    if "metadata" in ipy_json:
        version3example_json = json.loads(version3example)
        this_version = (
            str(sys.version_info.major)
            + "."
            + str(sys.version_info.minor)
            + "."
            + str(sys.version_info.micro)
        )
        if "kernelspec" in ipy_json["metadata"]:
            ipy_json["metadata"]["kernelspec"] = version3example_json["metadata"][
                "kernelspec"
            ]
        if "language_info" in ipy_json["metadata"]:
            ipy_json["metadata"]["language_info"] = version3example_json["metadata"][
                "language_info"
            ]
            ipy_json["metadata"]["language_info"]["version"] = this_version

    with open(argv[2], mode="w") as ostream:
        json.dump(ipy_json, ostream, indent=" ")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
