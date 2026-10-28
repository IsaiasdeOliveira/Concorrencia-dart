Stream<int> contar() async* {
  for (var numero = 1; numero <= 3; numero++) {
    await Future.delayed(
      const Duration(milliseconds: 300),
    );

    yield numero;
  }
}

Future<void> main() async {
  print('Iniciando contagem');

  await for (final numero in contar()) {
    print('Valor recebido: $numero');
  }

  print('Contagem finalizada');
}