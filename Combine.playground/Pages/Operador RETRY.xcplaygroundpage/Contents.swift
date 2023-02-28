//: [Previous](@previous)

import Foundation
import Combine

enum SwiftError: Error {
    case errorStringToIn
}

//Función para transformar el tipo de valor
func mapStringToInt(with stringValue: String) throws -> Int {
    guard let result = Int(stringValue) else { throw SwiftError.errorStringToIn
    }
    return result
}

let stringPublisher = PassthroughSubject<String, SwiftError>()

stringPublisher
    .tryMap { value in
//        si al transformar hay un error, finaliza el subscriber
        try mapStringToInt(with: value)
    }
//para seguir enviando valores a pesar de obtener un error, se pone el numero de errores permitidos
    .retry(1)
    .sink { finished in
    print("Completed \(finished)")
} receiveValue: { value in
    print("Value \(value)")
}
stringPublisher.send("34")
stringPublisher.send("swift")
stringPublisher.send("32")

//: [Next](@next)
