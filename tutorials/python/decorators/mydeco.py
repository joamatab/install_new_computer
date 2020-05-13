#!/usr/bin/env python3
"""Example of a decorator that takes any function, puts its output into
a string, and then adds exclamation points.  Very exciting!!!

From Reuven Lerner's "Practical Decorators" talk at PyCon 2019.
Reuven's courses, books, and newsletter are at https://lerner.co.il/
"""


def mydeco(func):
    def wrapper(*args, **kwargs):
        return f'{func(*args, **kwargs)}!!!'
    return wrapper


if __name__ == '__main__':
    @mydeco
    def add(a, b):
        return a + b

    print(add(2, 2))
    print(add(3, 3))
