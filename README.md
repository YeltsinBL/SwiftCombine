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

#### PassthroughSubject y CurrentValueSubject
- `PassthroughSubject`: Se crea una propiedad del tipo: PassthroughSubject<Int: Output, Error: Failed>().
- `CurrentValueSubject`: Al inicializarlo se asigna un valor: CurrentValueSubject<String Output, Error: Failed>("Valor del tipo del Output").
- En este caso se publica la propiedad con un solo valor, por eso se uso 'Send'.
- Dentro del 'Send' se puede asignar un valor, que se ha completado o un error.
-- Si se muestra el mensaje de error o completado, ya no se podrá publicar los demás eventos si existiera.
- Al suscribirnos con el 'Sink', dentro del 'receiveCompletion' se puede diferencia si el envío de eventos a terminado o hubo un error.
- HandleEvents: se utiliza para hacer Debug a los publisher.
- AnyCancellable: Para evitar que se libere podemos guardar una referencia de este tipo.

### Operadores
- `MAP`: Nos permite transformar la información que viaja a través del Publisher.
-- Cuando un Subscriber espera un tipo en concreto y si el Publisher no lo puede proporcionar, utilizando el Operador Map se puede transformar facilmente.
- `TRYMAP`: es igual que el 'MAP' normal, solo que aqui se puede lanzar errores dentro de su lógica.
-- El error viaja a través de todo el 'TRY' hasta llegar al Subscriber y finaliza la recepción de datos.
-- Se creó una función que transforma el valor y si no se puede, envía un error; esta función se utiliza dentro del 'TryMap'.
- `RETRY`: nos ayuda a recuperarnos al enviar un error; si hubo un error al enviar los valores y aún no se ha terminado de enviar, en vez de terminar la suscripción, sigue recibiendo valores.
-- Se debe de ingresar el número de errores que recibirá para que siga recibiendo valores.



Guía de referencia en el canal de [SwiftBeta](https://www.youtube.com/watch?v=dJW5OBUUicU&list=PLeTOFRUxkMcq-POY5dWtPT7SKsw3P6xAl&index=1)