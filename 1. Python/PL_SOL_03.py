def merge_sort(array):
    if len(array) > 1:
        center = len(array) // 2
        left_half = array[:center]
        right_half = array[center:]

        merge_sort(left_half)
        merge_sort(right_half)

        i, j, k = 0, 0, 0
        while i < len(left_half) and j < len(right_half):
            if left_half[i] >= right_half[j]:
                array[k] = right_half[j]
                j += 1
            else:
                array[k] = left_half[i]
                i += 1
            k += 1

        while i < len(left_half):
            array[k] = left_half[i]
            i += 1
            k += 1

        while j < len(right_half):
            array[k] = right_half[j]
            j += 1
            k += 1
    return array

array = [100, 23, 31, 123, 435, 642, 1]
print(array)
merge_sort(array)
print(array)