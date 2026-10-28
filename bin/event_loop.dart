import 'dart:async';

void main() {
  print('A: execução síncrona');

  scheduleMicrotask(() {
    print('B: microtask');
  });

  Future(() {
    print('C: evento agendado');
  });

  print('D: execução síncrona');
}