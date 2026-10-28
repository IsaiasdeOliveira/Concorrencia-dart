import 'dart:isolate';

void trabalhador(SendPort resposta) {
  resposta.send('Mensagem do isolate secundário');
}

Future<void> main() async {
  final porta = ReceivePort();

  await Isolate.spawn(
    trabalhador,
    porta.sendPort,
  );

  final mensagem = await porta.first;

  print('Recebido: $mensagem');

  porta.close();
}