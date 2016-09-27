def bubble_sort(arr)
  returned_arr = arr
  sorted = false
  while !sorted
    sorted = true
    for i in (0...(arr.length-1))
      if returned_arr[i] > returned_arr[i+1]
        returned_arr[i],returned_arr[i+1] = returned_arr[i+1],returned_arr[i]
        sorted = false
      end
    end
  end
  returned_arr
end

p bubble_sort([4,3,78,2,0,2])

def bubble_sort_by(arr)
  returned_arr = arr
  sorted = false
  while !sorted
    sorted = true
    for i in (0...(arr.length-1))
      if yield(returned_arr[i], returned_arr[i+1]) > 0
        returned_arr[i],returned_arr[i+1] = returned_arr[i+1],returned_arr[i]
        sorted = false
      end
    end
  end
  returned_arr
end

p bubble_sort_by(["hi","hello","hey"]) { |left, right| left.length - right.length }