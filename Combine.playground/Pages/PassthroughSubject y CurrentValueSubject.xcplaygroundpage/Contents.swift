//: [Previous](@previous)

import Foundation
import Combine


/**PassthroughSubject**/
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

/**PassthroughSubject**/

/**CurrentValueSubject**/

struct BotApp {
    var onBoardingPublisher = CurrentValueSubject<String, Error>("Bienvenido al tutorial")
    
    func startOnboarding() {
        onBoardingPublisher.send("Crea una nueva conversacion")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2 ) {
            onBoardingPublisher.send("Envia un sticker")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 4 ) {
            onBoardingPublisher.send("Activa las notificaciones")
            onBoardingPublisher.send(completion: .finished)
        }
    }
}

let botApp = BotApp()
let cancellable = botApp.onBoardingPublisher
//para hacer debug al Publisher, en este caso, por que no muestra los eventos del DispatchQueue
//se llego a la conclusion que se cancela la subscripcion por lo cual se guardara una referencia en el tipo AnyCancellable
    .handleEvents(receiveSubscription: { subscription in
        print("1. Subscription Receives \(subscription)")
    }, receiveOutput: { value in
        print("2. Value Received \(value)")
    }, receiveCompletion: { completion in
        print("3. Compeletion Received \(completion)")
    }, receiveCancel: {
        print("4. Cancel Received")
    }, receiveRequest: { request in
        print("5. Request Received")
    })
    .sink { completion in
        switch completion {
        case .finished:
            print("Finished")
        case .failure(let error):
            print("Error: \(error.localizedDescription)")
        }
    } receiveValue: { value in
        print("Value: \(value)")
    }

botApp.startOnboarding()


/**CurrentValueSubject**/

//: [Next](@next)
