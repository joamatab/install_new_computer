import random

from decorators import trace

GREETINGS = ["Heisann", "hi there", "Ni!"]


@trace
def greet(name, greeting="hello"):
    return f"{greeting} {name}"


@trace
def random_greet(name="emily"):
    greeting = random.choice(GREETINGS)
    return greet(name, greeting=greeting)


@trace
def greet_many(number):
    return [random_greet() for _ in range(number)]


# greet('alex')
# random_greet()
greet_many(3)
