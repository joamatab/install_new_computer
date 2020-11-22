""" https://docs.python.org/3/library/enum.html

"""

from enum import Enum


class Color(Enum):
    RED = 1
    GREEN = 2
    BLUE = 3


if __name__ == "__main__":
    color_names = [c.name for c in Color]
    color_values = [c.value for c in Color]
    print(color_names)
    print(color_values)
    print(Color["RED"])
    print(Color.RED)
