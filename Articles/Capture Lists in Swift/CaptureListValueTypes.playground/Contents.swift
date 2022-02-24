import Foundation

// MARK: - Simple scenario
func testClosureWithCaptureList() {
    var dummyValue = 100
    
    let closure = { [dummyValue] in
        print(dummyValue)
    }
    
    dummyValue = 200
    closure()
    
    dummyValue = 300
    closure()
}

testClosureWithCaptureList()

// MARK: - More interesting case
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0

    return { //[runningTotal]
        runningTotal += amount
        return runningTotal
    }
}

let incBy8 = makeIncrementer(forIncrement: 8)

incBy8()
incBy8()
incBy8()

let incBy3 = makeIncrementer(forIncrement: 3)
incBy3()
incBy3()

let incBy7 = makeIncrementer(forIncrement: 7)

incBy7()
