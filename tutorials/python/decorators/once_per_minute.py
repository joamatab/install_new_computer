#!/usr/bin/env python3
"""Example of a decorator that ensures a function cannot be run
more than once every 60 seconds.  If such run is attempted, the function
raises a CalledTooOftenError exception.

From Reuven Lerner's "Practical Decorators" talk at PyCon 2019.
Reuven's courses, books, and newsletter are at https://lerner.co.il/
"""

import time


class CalledTooOftenError(Exception):
    pass


def once_per_minute(func):
    last_invoked = 0

    def wrapper(*args, **kwargs):
        nonlocal last_invoked

        elapsed_time = time.time() - last_invoked
        if elapsed_time < 60:
            raise CalledTooOftenError(f"Only {elapsed_time} has passed")

        last_invoked = time.time()

        return func(*args, **kwargs)

    return wrapper


if __name__ == '__main__':
    @once_per_minute
    def add(a, b):
        return a + b

    print(add(2, 2))
    print(add(3, 3))
