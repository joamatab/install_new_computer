from decorators import timer


@timer
def waste_time(number):
    return sum(sum(range(num)) for num in range(number))
