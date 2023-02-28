//: [Previous](@previous)

import Foundation
import Combine

let intPublisher = PassthroughSubject<Int, Never>()
intPublisher
    .map({ value in
//        Convirtiendo el valor de Int a String
        String(value)
    })
    .sink { value in
    print("Value \(value)")
}

intPublisher.send(35)
intPublisher.send(32)

//Otra forma de hacer un Publisher
[24,20].publisher
    .map({ value in
//        Convirtiendo el valor de Int a String
        String(value)
    })
    .sink { value in
    print("Value \(value)")
}


//: [Next](@next)
