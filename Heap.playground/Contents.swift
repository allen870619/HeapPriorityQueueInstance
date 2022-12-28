struct Heap<T> where T: Equatable {
    var list = [T]()
    var comparison: (T, T) -> Bool

    // find index
    private func leftChild(of index: Int) -> Int {
        return 2 * index + 1
    }

    private func rightChild(of index: Int) -> Int {
        return 2 * index + 2
    }

    private func parentIndex(of index: Int) -> Int {
        // actually, (index-1)/2 is for odd, (index-2)/2 is for even, but they are same result
        return (index - 1) / 2
    }

    // compare
    private func isHigherPriority(at firstIndex: Int, than secondIndex: Int) -> Bool {
        return comparison(list[firstIndex], list[secondIndex])
    }

    /// compare parent, left child and right child.
    ///
    /// If parent's priority is highest, if will return `nil`, otherwise return higher index
    private func childHigherPriority(parent index: Int) -> Int? {
        let left = leftChild(of: index)
        let right = rightChild(of: index)
        let total = list.count

        if left < total && right < total {
            if isHigherPriority(at: left, than: index) || isHigherPriority(at: right, than: index) {
                return isHigherPriority(at: left, than: right) ? left : right
            } else {
                return nil
            }
        } else if left < total {
            return isHigherPriority(at: left, than: index) ? left : nil
        } else if right < total {
            return isHigherPriority(at: right, than: index) ? right : nil
        }
        return nil
    }

    // sift: up(enqueue) and down(dequeue)
    // enqueue
    private mutating func siftUp(index: Int) {
        let parentIndex = parentIndex(of: index)
        if isHigherPriority(at: index, than: parentIndex) {
            list.swapAt(index, parentIndex)
            siftUp(index: parentIndex)
        }
    }

    // dequeue
    private mutating func siftDown(index: Int) {
        if let child = childHigherPriority(parent: index) {
            list.swapAt(child, index)
            siftDown(index: child)
        }
    }

    // get data
    mutating func enqueue(value: T) {
        list.append(value)
        siftUp(index: list.count - 1)
    }

    mutating func dequeue() -> T? {
        if list.isEmpty {
            return nil
        }

        let tmp = list[0]
        list.swapAt(list.count - 1, 0)
        list.removeLast()
        siftDown(index: 0)
        return tmp
    }

    func peek() -> T? {
        return list.first
    }
}

var heap = Heap<Int>(comparison: >)
print(heap.dequeue())
print(heap.list)
heap.enqueue(value: 2)
heap.enqueue(value: 4)
heap.enqueue(value: 9)
heap.enqueue(value: 6)
heap.enqueue(value: 3)
print(heap.list)

print(heap.dequeue())
print(heap.list)

heap.enqueue(value: 5)
print(heap.list)

heap.enqueue(value: 4)
print(heap.list)

print(heap.dequeue())
print(heap.list)
print(heap.dequeue())
print(heap.list)
print(heap.dequeue())
print(heap.list)
print(heap.dequeue())
print(heap.list)
