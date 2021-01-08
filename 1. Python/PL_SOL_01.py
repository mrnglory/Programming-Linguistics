def binary_search(array, target):
    head = 0
    tail = len(array) - 1
    while tail - head >= 0:
        center = (head + tail) // 2
        if array[center] == target:
            return center
        elif array[center] < target:
            head = center + 1
        elif array[center] > target:
            tail = center - 1
    return None

array = [1, 11, 15, 19, 37, 48, 59, 61]

num = int(input('Input Number : '))
print('Order : ' , binary_search(array, num))