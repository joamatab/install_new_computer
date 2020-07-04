#!/usr/bin/env python3
"""Example of a decorator that writes function-execution timing to a file.

From Reuven Lerner's "Practical Decorators" talk at PyCon 2019.
Reuven's courses, books, and newsletter are at https://lerner.co.il/
"""

import time


def logtime(func):
    def wrapper(*args, **kwargs):
        start_time = time.time()
        result = func(*args, **kwargs)
        total_time = time.time() - start_time

        with open("timelog.txt", "a") as outfile:
            outfile.write(f"{time.time()}\t{func.__name__}\t{total_time}\n")
        return result

    return wrapper


if __name__ == "__main__":

    @logtime
    def slow_add(a, b):
        time.sleep(2)
        return a + b

    @logtime
    def slow_mul(a, b):
        time.sleep(3)
        return a * b

    for i in range(5):
        for j in range(5):
            print(slow_add(i, j))
            print(slow_mul(i, j))
