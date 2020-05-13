#!/usr/bin/env python3
"""Example of a decorator that adds a _created_at attribute to
every instance created by the decorated class.

From Reuven Lerner's "Practical Decorators" talk at PyCon 2019.
Reuven's courses, books, and newsletter are at https://lerner.co.il/
"""

import time


def object_birthday(c):
    def wrapper(*args, **kwargs):
        o = c(*args, **kwargs)
        o._created_at = time.time()
        return o
    return wrapper


@object_birthday
class Foo():
    def __init__(self, x, y):
        self.x = x
        self.y = y


f = Foo(10, [10, 20, 30])
print(f)
print(f._created_at)
