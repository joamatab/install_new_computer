

from dataclasses import dataclass

@dataclass
class Layer:
    '''Class for keeping track of an item in inventory.'''
    name: str
    : float
    quantity_on_hand: int = 0

    def total_cost(self) -> float:
        return self.unit_price * self.quantity_on_hand



if __name__ == "__main__": 
    i = InventoryItem()
