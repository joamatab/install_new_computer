from decorators import CountCalls


# @count_calls
@CountCalls
def fibonacci(number):
    """calculate the fibonacci number"""
    if number < 2:
        return 1
    return fibonacci(number - 1) + fibonacci(number - 2)


print(fibonacci(5))
print(fibonacci.num_calls)
