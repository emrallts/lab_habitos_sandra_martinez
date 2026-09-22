# Panel de hábitos del día

Aplicación desarrollada en Flutter para llevar el control de cinco hábitos durante el día.

La aplicación permite marcar hábitos como cumplidos, visualizar el progreso, establecer una meta diaria, activar un modo enfoque, guardar una nota y reiniciar la información del día.

## Funcionalidades

- Lista de cinco hábitos con `CheckboxListTile`.
- Contador de hábitos cumplidos.
- Barra de progreso según los hábitos completados.
- Mensaje motivacional que cambia según el porcentaje.
- Meta diaria configurable mediante un `Slider`.
- Mensaje de `Meta alcanzada` cuando se cumple la meta.
- Modo enfoque para ocultar los hábitos ya completados.
- Campo para guardar una nota del día.
- Botón para reiniciar todos los datos.

## Variables de estado

La pantalla principal utiliza un `StatefulWidget`.

Las principales variables utilizadas son:

| Variable | Descripción |
| --- | --- |
| `_cumplidos` | Guarda si cada hábito está cumplido o no. |
| `_meta` | Guarda la cantidad de hábitos que se desean cumplir. |
| `_enfoque` | Indica si el modo enfoque está activado. |
| `_nota` | Guarda la nota del día. |
| `_notaCtrl` | Controla el texto ingresado en el campo de la nota. |

También se utilizan getters para calcular el total de hábitos cumplidos, el progreso, el mensaje motivacional y si la meta fue alcanzada.

Los cambios de estado se realizan utilizando `setState()`.

## Capturas

![Pantalla inicial](Capturas/inicio.png)

![Progreso del día](Capturas/progreso.png)

![Modo enfoque](Capturas/modo_enfoque.png)

![Meta completada](Capturas/completado.png)

## Reflexión

Un error común al manejar el estado en Flutter es actualizar una lista de valores sin hacer el cambio dentro de `setState()`, lo que provoca que la interfaz no refleje correctamente los datos y que el progreso o el modo enfoque queden desactualizados. Para evitarlo, se centralizó el cambio de cada variable en métodos específicos y se actualizó el estado de manera consistente, asegurando que la vista se reconstruyera con los valores correctos cada vez que el usuario interactuaba con la aplicación.

## Ejecución

Para ejecutar el proyecto:

```bash
flutter pub get
flutter run