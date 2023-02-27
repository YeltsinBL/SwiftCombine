//: [Previous](@previous)

import Foundation
import Combine

struct Weather {
//    Creamos la constante que tiene como Output un entero y el Failed un error
    let weatherPublisher = PassthroughSubject<Int, Error>()
//    cuando se llama el evento, se publicarán los valores en el Publisher
    func getWeatherInfo() {
        weatherPublisher.send(35)
//        indicar que el publisher a enviado todos los eventos y ya no enviará  los demás que haya
//        weatherPublisher.send(completion: .finished)
//        enviamos un error, si muestra un error, los demás eventos ya no se enviarán
        weatherPublisher.send(completion: .failure(URLError(.badURL)))
        weatherPublisher.send(32)
    }
}

//suscribiendonos al publisher
let weather = Weather() //instanciamos la Struct
//nos subscribimos a la propiedad Publisher
weather.weatherPublisher.sink { completado in
//   se puede diferenciar si se recibió Finish o Error
    switch completado {
    case .failure(let error):
        print("Error: \(error.localizedDescription)")
    case .finished:
        print("Completado \(completado)")
    }
} receiveValue: { value in
    print("Value \(value)")
}

weather.getWeatherInfo()

//: [Next](@next)
