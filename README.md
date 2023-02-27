# SwiftCombine
## _Ejercicios para hacer programación reactiva funcional utilizando Combine._

### Publisher
- Sirven para publicar los eventos.
- Tiene dos tipos de respuesta, siempre que se crea un Publisher se define un output y failed:
-- El Output es el tipo que envía el Publisher, es el tipo de valor que se publicará en el Publisher; es decir; los valores que viajarán a través de él.
-- El failed es el tipo de error que envía el Publisher.
- Se crear el Publisher usando el '.publisher'.
- También se puede crear usando 'Just', 'CurrentValueSubject' y 'PassthroughSubject'

### Subscribers
- Después publicar el Publisher, debemos de suscribirnos para recibir todos los valores que se van publicando
- Uno de los métodos para subscribirnos es 'Sink', que se puede agregar una lógica.
-- Se puede agregar lógica cuando se termina de enviar todos los eventos y/o cuando los recibimos.
- Otra forma de suscribirnos es usando 'Assign[to:,on:]', que no se puede agregar una lógica porque recibe y asigna un único valor
-- El 'to' es pasa especificar a la propiedad que se le asignara el valor y el 'on' es la ruta en donde se encuentra esa propiedad.
-- En este caso práctico, se asigna el Publisher a una instancia de la propiedad de la clase.

> Nota:  Un Publisher puede cancelar su publicación por 3 motivos: se ha completado, ha habido un error o se ha cancelado la suscripción. 
Los Subscriber reciben una notificación por cada valor recibido y cuando el Publisher a completado de enviar todos sus valores o ha recibido un error.

### Crear Publishers
Usando los 'CurrentValueSubject' y 'PassthroughSubject' se envían los datos a los Subscribers de forma imperativa y utilizamos el método ‘Send' que nos sirve para enviar valores en la BackLine. Se diferencian en:
- 'CurrentValueSubject': se da un valor por defecto, cuando lo inicializamos le damos un valor que cuando un Subscriber se suscriba lo recibirá automáticamente.
- 'PassthroughSubject': se inicializa sin ningún valor y después de suscribirnos debemos de enviar algún valor para que el Subscriber reciba valores.

#### PassthroughSubject
- Se crea una propiedad del tipo: PassthroughSubject<Int: Output, Error: Failed>()
- En este caso se publica la propiedad con un solo valor, por eso se uso 'Send'.
- Dentro del 'Send' se puede asignar un valor, que se ha completado o un error.
-- Si se muestra el mensaje de error o completado, ya no se podrá publicar los demás eventos si existiera.
- Al suscribirnos con el 'Sink', dentro del 'receiveCompletion' se puede diferencia si el envío de eventos a terminado o hubo un error.