from typing import Tuple
from dataclasses import dataclass


@dataclass
class InventoryItem:
    """Class for keeping track of an item in inventory."""

    name: str = "item"
    quantity_on_hand: int = 0
    layer: Tuple[int, int] = (1, 0)

    def __getitem__(self, i):
        return self.layer[i]

    def total_cost(self) -> float:
        return self.unit_price * self.quantity_on_hand


if __name__ == "__main__":
    i = InventoryItem()
