#!/usr/bin/env python3

"""Example of a decorator that memoizes based on a function's arguments.
Note that if the args aren't hashable, or if kwargs is set, this cache
doesn't really work well.  (See memoize2.py for how to handle that.)

From Reuven Lerner's "Practical Decorators" talk at PyCon 2019.
Reuven's courses, books, and newsletter are at https://lerner.co.il/
"""


def memoize(func):
    cache = {}

    def wrapper(*args, **kwargs):
        if args not in cache:
            print(f"Caching NEW value for {func.__name__}{args}")
            cache[args] = func(*args, **kwargs)
        else:
            print(f"Using OLD value for {func.__name__}{args}")

        return cache[args]

    return wrapper


if __name__ == "__main__":

    @memoize
    def add(a, b):
        print("Running add!")
        return a + b

    @memoize
    def mul(a, b):
        print("Running mul!")
        return a * b

    print(add(3, 7))
    print(mul(3, 7))
    print(add(3, 7))
    print(mul(3, 7))
