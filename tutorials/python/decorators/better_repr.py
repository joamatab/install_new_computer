#!/usr/bin/env python3
"""Example of a decorator that adds a method to a class.

From Reuven Lerner's "Practical Decorators" talk at PyCon 2019.
Reuven's courses, books, and newsletter are at https://lerner.co.il/
"""


def fancy_repr(self):
    return f"I'm a {type(self).__name__}, with vars {vars(self)}"


def better_repr(c):
    c.__repr__ = fancy_repr

    return c


@better_repr
class Foo():
    def __init__(self, x, y):
        self.x = x
        self.y = y


f = Foo(10, [10, 20, 30])
print(f)
