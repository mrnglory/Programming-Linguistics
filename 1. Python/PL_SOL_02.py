def quick_sort(array):
    def sort(low, high):
        if high <= low:
            return
        center = partition(low, high)
        sort(low, center - 1)
        sort(center, high)

    def partition(low, high):
        pivot = array[(low + high) // 2]
        while low <= high:
            while array[low] < pivot:
                low += 1
            while array[high] > pivot:
                high -= 1
            if low <= high:
                array[low], array[high] = array[high], array[low]
                low, high = low + 1, high - 1
        print(array)
        return low

    return sort(0, len(array) - 1)

array = [26, 5, 37, 1, 61, 11, 59, 15, 48, 19]
quick_sort(array)