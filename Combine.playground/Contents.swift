import UIKit
import Combine

let myArray = ["1","2","3","4"]
//Sirven para publicar los eventos.
//Tiene dos tipos de respuesta, siempre que se crea un Publisher se define un output y failed:
//El Output es el tipo que envía el Publisher, es el tipo de valor que se publicará en el Publisher; es decir; los valores que viajarán a través de él.
//El failed es el tipo de error que envía el Publisher.
let myPublisher = myArray.publisher


/**Creando Publisher de otra forma**/
//Utilizando Just
let just = Just(["1","2","3","4"])

//También se puede crear Publisher usando: 'CurrentValueSubject' y 'PassthroughSubject'.

//Subscribers: Después publicar el Publisher, debemos de suscribirnos para recibir todos los valores que se van publicando
//uno de los métodos para subscribirnos es 'Sink'
//Usando Sink se puede agregar lógica al suscribirnos
myPublisher.sink { isFinished in
//    se llama una sola vez cuando termina de enviarse todos los eventos
    print("isFinished: \(isFinished)")
} receiveValue: { value in
//    se llama tantas veces como la cantidad de valores que haya en el array
    print("Value received: \(value)")
}

//Subscribers usando Assign
//Si se quiere asignar un unico valor a algun elemento  de la UI o class, se puede usar 'Assign[to:,on:]', no se puede realizar una lógica
class YoutubeChannel {
    var numbreOfSuscribers: Int = 0
}
let justInteger = Just(2222) //Crear Publisher
let swift = YoutubeChannel() //Instanciar Class
//Asignar el publisher a una instancia de la propiedad de la clase
justInteger.assign(to: \YoutubeChannel.numbreOfSuscribers, on: swift)
print(justInteger)


//AnyCancellable: se utiliza para cancelar un Subscriber antes de que haya publicado todos sus valores
let cancelable = myPublisher.sink { isFinished in
    //    se llama una sola vez cuando termina de enviarse todos los eventos
        print("isFinished: \(isFinished)")
    } receiveValue: { value in
    //    se llama tantas veces como la cantidad de valores que haya en el array
        print("Value received: \(value)")
    }

/**
 RESUMEN:
 Un Publisher puede cancelar su publicación por 3 motivos: se ha completado, ha habido un error o se ha cancelado la suscripción.
 Los Subscriber reciben una notificación por cada valor recibido y cuando el Publisher a completado de enviar todos sus valores o ha recibido un error.
 **/
