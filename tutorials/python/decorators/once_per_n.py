#!/usr/bin/env python3
"""Example of a decorator that ensures a function cannot be run
more than once every n seconds, where n is passed to the decorator
as an argument.

From Reuven Lerner's "Practical Decorators" talk at PyCon 2019.
Reuven's courses, books, and newsletter are at https://lerner.co.il/
"""

import time


class CalledTooOftenError(Exception):
    pass


def once_per_n(n):
    def middle(func):
        last_invoked = 0

        def wrapper(*args, **kwargs):
            nonlocal last_invoked

            elapsed_time = time.time() - last_invoked
            if elapsed_time < 60:
                raise CalledTooOftenError(f"Only {elapsed_time} has passed")

            last_invoked = time.time()

            return func(*args, **kwargs)

        return wrapper

    return middle


if __name__ == "__main__":

    @once_per_n(5)
    def slow_add(a, b):
        time.sleep(3)
        return a + b

    print(slow_add(2, 2))
    print(slow_add(3, 3))
    print(slow_add(4, 4))
