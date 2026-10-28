import 'dart:isolate';

Future<void> main() async {
  print('Iniciando cálculo');

  final resultado = await Isolate.run(() {
    var soma = 0;

    for (var numero = 1;
        numero <= 1000000;
        numero++) {
      soma += numero;
    }

    return soma;
  });

  print('Resultado: $resultado');
}