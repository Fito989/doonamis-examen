# doonamis_examen

En vez de Utilizar Riverpod utilizaré Bloc.

Lo haré de esta manera porque para una aplicación tan pequeña el sistema Cubit que proporciona Bloc es mucho más ligero i facil de utilizar.

Además de poder utilizarlo con Provider i el mismo modular (sistema que he utilizado para la navegación entre páginas).


## Cosas a mejorar

- El sistema de traducciones se podría haber hecho con el sistema de traducciones nativo de Flutter, pero he probado con 3 paquetes distintos y todos me han dado problemas con el modular, asi que por falta de tiempo he optado por traducir los textos locales de la manera en al que lo hago.
- El sistema offline funciona de manera extraña porque se van reescribiendo los mismos datos todo el rato y he tenido que hacer un apaño, además de que en último momento (version 2.0) he quitado el creador porque no me daba tiempo a hacer las relaciones con creador fk.

