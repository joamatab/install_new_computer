#!/usr/bin/env python3
"""Example of a decorator that memoizes based on a function's arguments.
This version uses "pickle", along with both args and kwargs, for a more
robust solution than memoize.py.

From Reuven Lerner's "Practical Decorators" talk at PyCon 2019.
Reuven's courses, books, and newsletter are at https://lerner.co.il/
"""

import pickle


def memoize(func):
    cache = {}

    def wrapper(*args, **kwargs):
        t = (pickle.dumps(args),
             pickle.dumps(kwargs))

        if t not in cache:
            print(f"Caching NEW value for {func.__name__}{args}")
            cache[t] = func(*args, **kwargs)
        else:
            print(f"Using OLD value for {func.__name__}{args}")

        return cache[t]
    return wrapper


if __name__ == '__main__':
    @memoize
    def add(a, b):
        print("Running add!")
        return a + b

    @memoize
    def mul(a, b):
        print("Running mul!")
        return a * b

    @memoize
    def mysum(numbers, **kwargs):
        print(f"Running mysum, message = '{kwargs.get('message')}'")
        total = 0
        for one_number in numbers:
            total += one_number
        return total

    print(add(3, 7))
    print(mul(3, 7))
    print(add(3, 7))
    print(mul(3, 7))
    print(mysum([1, 2, 3, 4, 5], message='hello'))
    print(mysum([1, 2, 3, 4, 5], message='hello'))
    print(mysum([1, 2, 3, 4, 5], message='goodbye'))
