#!/usr/bin/env python3
"""Example of a decorator that both modifies __repr__ on a class, and
sets the _created_at attribute on all new objects created by that class.

From Reuven Lerner's "Practical Decorators" talk at PyCon 2019.
Reuven's courses, books, and newsletter are at https://lerner.co.il/
"""

import time


def fancy_repr(self):
    return f"I'm a {type(self).__name__}, with vars {vars(self)}"


def repr_and_birthday(c):
    c.__repr__ = fancy_repr

    def wrapper(*args, **kwargs):
        o = c(*args, **kwargs)
        o._created_at = time.time()
        return o

    return wrapper


if __name__ == "__main__":

    @repr_and_birthday
    class Foo:
        def __init__(self, x, y):
            self.x = x
            self.y = y

    f = Foo(10, [10, 20, 30])
    print(f)
    print(f._created_at)
