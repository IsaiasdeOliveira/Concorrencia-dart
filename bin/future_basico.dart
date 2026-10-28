Future<int> calcular() async {
  await Future.delayed(
    const Duration(seconds: 1),
  );

  return 40 + 2;
}

Future<void> main() async {
  print('Início do programa');

  final resultado = await calcular();

  print('Resultado: $resultado');
  print('Fim do programa');
}