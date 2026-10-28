Future<int> calcular(int valor) async {
  await Future.delayed(
    const Duration(milliseconds: 300),
  );

  return valor * 10;
}

Future<void> main() async {
  print('Iniciando operações');

  final resultados = await Future.wait([
    calcular(1),
    calcular(2),
    calcular(3),
  ]);

  print('Resultados: $resultados');
}