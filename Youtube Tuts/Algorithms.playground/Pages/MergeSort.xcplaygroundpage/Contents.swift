//: [Previous](@previous)

import Foundation

func mergeSort(_ array: [Int]) -> [Int] {
    guard array.count > 1 else {
        return array
    }
    // Middle Index
    let middle = array.count/2
    //Create Left / Right
    let left = mergeSort(Array(array[0..<middle]))
    let right = mergeSort(Array(array[middle..<array.count]))
    
    // Left + Right Merge
    return merge(left, right)
}


func merge(_ left: [Int], _ right:  [Int]) -> [Int] {
    var leftIdx = 0
    var rightIdx = 0
    
    var result = [Int]()
    result.reserveCapacity(left.count + right.count)
    
    // Sorts the items while they have an equal count
    while leftIdx < left.count && rightIdx < right.count {
        if left[leftIdx] < right[rightIdx] {
            result.append(left[leftIdx])
            leftIdx += 1
        } else if left[leftIdx] > right[rightIdx] {
            result.append(right[rightIdx])
            rightIdx += 1
        } else {
            result.append(left[leftIdx])
            result.append(right[rightIdx])
            leftIdx += 1
            rightIdx += 1
        }
    }
    // Appends the remainder of left items
    while leftIdx < left.count {
        result.append(left[leftIdx])
        leftIdx += 1
    }
    // Appends the remainder of right items
    while rightIdx < right.count {
        result.append(right[rightIdx])
        rightIdx += 1
    }
    return result
}

//Running the code with test data
let testArray = [12, 23, 234, 344, 564, 3455, 4, 6456, 4534, 645, 55, 55, 56, 88, 87, 66, 1098]
let sorted = mergeSort(testArray)
print(sorted)



//: [Next](@next)
