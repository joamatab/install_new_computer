
from decorators import repeat


@repeat(num_times=2)
def greet(name):
    print(f"Hello {name}")

@repeat
def say_whee():
    print("Whee!")


greet('joaquin')
say_whee()
