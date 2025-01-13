import functools
import time

REGISTERED = {}


def register(func):
    REGISTERED[func.__name__] = func
    return func


def timer(func):
    """template for decorators"""

    @functools.wraps(func)
    def _timer(*args, **kwargs):
        t0 = time.perf_counter()
        value = func(*args, **kwargs)
        t1 = time.perf_counter()
        print(f"elapsed time: {t1 - t0} seconds")
        return value

    return _timer


def repeat_n(num_times=2):
    """repeat n times"""

    def decorator_repeat(func):
        @functools.wraps(func)
        def _wrapper(*args, **kwargs):
            for _ in range(num_times):
                value = func(*args, **kwargs)
            return value

        return _wrapper

    return decorator_repeat


def repeat(_func=None, *, num_times=2):
    def decorator_repeat(func):
        @functools.wraps(func)
        def wrapper_repeat(*args, **kwargs):
            for _ in range(num_times):
                value = func(*args, **kwargs)
            return value

        return wrapper_repeat

    if _func is None:
        return decorator_repeat
    else:
        return decorator_repeat(_func)


def trace(func):
    """trace"""

    @functools.wraps(func)
    def _wrapper(*args, **kwargs):
        args_repr = [repr(a) for a in args]
        kwargs_repr = [f"{k}={v!r}" for k, v in kwargs.items()]
        signature = ", ".join(args_repr + kwargs_repr)

        print(f"calling {func.__name__}({signature})")
        value = func(*args, **kwargs)
        print(f"{func.__name__!r}({signature}) returned {value!r}")
        return value

    return _wrapper


# def count_calls(func):
#     print('called')
#     if hasattr(func, 'num_calls'):
#         func.num_calls += 1
#     else:
#         func.num_calls = 1
#     return func


def count_calls(func):
    """count the number of calls to a function
    shows how to keep state in your decorator
    """

    @functools.wraps(func)
    def _count_calls(*args, **kwargs):
        _count_calls.num_calls += 1
        return func(*args, **kwargs)

    _count_calls.num_calls = 0
    return _count_calls


class Adder:
    def __init__(self, number):
        self.number = number

    def __call__(self, other):
        return other + self.number


class CountCalls:
    """count number of calls to a function"""

    def __init__(self, func):
        self.func = func
        self.num_calls = 0
        functools.update_wrapper(self, func)

    def __call__(self, *args, **kwargs):
        self.num_calls += 1
        return self.func(*args, **kwargs)


if __name__ == "__main__":
    add_3 = Adder(3)
    print(add_3(5))
