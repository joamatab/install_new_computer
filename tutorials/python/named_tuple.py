from dataclasses import dataclass
from typing import NamedTuple


@dataclass
class Layer:
    """Class for keeping track of an item in inventory."""

    layer: int
    purpose: int
    description: str = ""
    color: str = "gray"
    alpha: float = 0


class Layers(NamedTuple):
    WG: Layer = (1, 0)
    SLAB: Layer = (2, 0)


class Layers2(NamedTuple):
    WG = Layer(1, 0, "nothing")
    SLAB = Layer(2, 0)


if __name__ == "__main__":
    c = Layers()
    d = Layers2()
