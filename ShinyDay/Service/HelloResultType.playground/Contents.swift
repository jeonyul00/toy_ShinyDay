import UIKit


enum NumberError:Error {
    case negativeNumber
    case evenNumber
}

enum AnotherNumberError:Error {
    case tooLarge
}

func process(oddNumber:Int) throws -> Int {
    guard oddNumber >= 0 else { throw NumberError.negativeNumber }
    guard !oddNumber.isMultiple(of: 2) else { throw NumberError.evenNumber }
    return oddNumber * 2
}

try? process(oddNumber: 2)

// wooo~~~~ bad


let result = Result {try? process(oddNumber: 1)}

switch result {
case .success(let data):
    print(data!)
case .failure(let error):
    print(error)
    
}

//

func processResult(oddNumber: Int)-> Result<Int,NumberError>{
    guard oddNumber >= 0 else {
        return .failure(NumberError.negativeNumber)
    }
    return .success(1)
}

let test = processResult(oddNumber: 22)
switch test {
case .success(let data):
    print(data)
case .failure(let error):
    print(error)
}

