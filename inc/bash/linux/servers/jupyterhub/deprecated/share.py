import os
import shutil

src_path = "/home/jupyter-ubuntu/engineer/"
src_files = ["shared_data", "shared_data_read_only", "welcome.ipynb"]

src_files2permissions = {
    "shared_data": 0o0777,
    "welcome.ipynb": 0o0777,
    "shared_data_read_only": 0o0444,
}


os.chdir("/home/")
for name_home_folder in os.listdir():
    if name_home_folder.startswith("jup") and not name_home_folder.startswith(
        "jupyter-ubuntu"
    ):
        for name_file in src_files:
            src = os.path.join(src_path, name_file)
            dest = os.path.join("/home", name_home_folder, name_file)
            if not os.path.exists(dest):
                shutil.copy(src, dest, follow_symlinks=False)
                os.chmod(dest, 0o0777)
