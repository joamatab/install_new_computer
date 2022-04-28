from decorators import count_calls, trace, CountCalls



# @count_calls
@CountCalls
def fibonacci(number):
    """ calculate the fibonacci number
    """
    return 1 if number < 2 else fibonacci(number-1) + fibonacci(number-2)


print(fibonacci(5))
print(fibonacci.num_calls)
