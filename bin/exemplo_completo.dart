
import 'dart:async';
import 'dart:io';

// Representa um produto disponível na loja.
class Produto {
  final int id;
  final String nome;
  final double preco;
  final int estoque;

  Produto(this.id, this.nome, this.preco, this.estoque);
}

// Representa um item dentro do pedido.
class ItemPedido {
  final Produto produto;
  final int quantidade;

  ItemPedido({
    required this.produto,
    required this.quantidade,
  });

  double get subtotal => produto.preco * quantidade;
}

// Um pedido pode conter vários itens.
class Pedido {
  final int id;
  final List<ItemPedido> itens;
  String status;

  Pedido({
    required this.id,
    required this.itens,
    this.status = 'Recebido',
  });

  double get valorTotal {
    return itens.fold(
      0.0,
      (total, item) => total + item.subtotal,
    );
  }
}

// Catálogo fictício da loja.
final produtos = [
  Produto(1, 'Teclado', 120.00, 10),
  Produto(2, 'Mouse', 80.00, 15),
  Produto(3, 'Monitor', 900.00, 5),
  Produto(4, 'Headset', 150.00, 8),
];

// Histórico mantido durante a execução.
final List<Pedido> historico = [];

int proximoId = 1;

// Simula uma consulta assíncrona de preço.
Future<double> consultarPreco(Produto produto) async {
  await Future.delayed(
    const Duration(milliseconds: 300),
  );

  return produto.preco;
}

// Simula uma consulta assíncrona de estoque.
Future<int> consultarEstoque(Produto produto) async {
  await Future.delayed(
    const Duration(milliseconds: 300),
  );

  return produto.estoque;
}

// Emite atualizações do processamento.
Stream<String> acompanharPedido(Pedido pedido) async* {
  yield 'Pedido ${pedido.id}: recebido';

  await Future.delayed(
    const Duration(milliseconds: 300),
  );

  yield 'Pedido ${pedido.id}: processando';

  await Future.delayed(
    const Duration(milliseconds: 300),
  );

  pedido.status = 'Finalizado';

  yield 'Pedido ${pedido.id}: finalizado';
}

// Lê texto digitado pelo usuário.
String lerTexto(String mensagem) {
  stdout.write(mensagem);
  return stdin.readLineSync()?.trim() ?? '';
}

// Lê e valida um número inteiro.
int lerInteiro(String mensagem) {
  while (true) {
    final texto = lerTexto(mensagem);
    final numero = int.tryParse(texto);

    if (numero != null) {
      return numero;
    }

    print('Digite um número inteiro válido.');
  }
}

// Exibe o catálogo.
void exibirProdutos() {
  print('\n=== PRODUTOS DISPONÍVEIS ===');

  for (final produto in produtos) {
    print(
      '${produto.id} - ${produto.nome} | '
      'R\$ ${produto.preco.toStringAsFixed(2)} | '
      'Estoque: ${produto.estoque}',
    );
  }
}

// Mostra os itens selecionados até o momento.
void exibirCarrinho(List<ItemPedido> itens) {
  print('\n=== SEU PEDIDO ATUAL ===');

  for (final item in itens) {
    print(
      '${item.produto.nome} | '
      'Quantidade: ${item.quantidade} | '
      'Subtotal: R\$ ${item.subtotal.toStringAsFixed(2)}',
    );
  }

  final total = itens.fold<double>(
    0,
    (soma, item) => soma + item.subtotal,
  );

  print('Subtotal da compra: R\$ ${total.toStringAsFixed(2)}');
}

// Cria um pedido com vários produtos.
Future<void> fazerPedido() async {
  final itens = <ItemPedido>[];

  while (true) {
    exibirProdutos();

    final idProduto = lerInteiro(
      '\nEscolha o número do produto: ',
    );

    final encontrados = produtos.where(
      (produto) => produto.id == idProduto,
    );

    if (encontrados.isEmpty) {
      print('Produto não encontrado.');
      continue;
    }

    final produto = encontrados.first;
    final quantidade = lerInteiro(
      'Informe a quantidade desejada: ',
    );

    if (quantidade <= 0) {
      print('A quantidade deve ser maior que zero.');
      continue;
    }

    print('\nConsultando preço e estoque...');

    // As consultas assíncronas são aguardadas em conjunto.
    final resultados = await Future.wait<Object>([
      consultarPreco(produto),
      consultarEstoque(produto),
    ]);

    final preco = resultados[0] as double;
    final estoque = resultados[1] as int;

    // Considera também as unidades desse produto
    // que já foram adicionadas ao pedido atual.
    final quantidadeJaAdicionada = itens
        .where((item) => item.produto.id == produto.id)
        .fold<int>(0, (soma, item) => soma + item.quantidade);

    if (quantidade + quantidadeJaAdicionada > estoque) {
      print(
        'Estoque insuficiente. Disponível para adicionar: '
        '${estoque - quantidadeJaAdicionada}.',
      );
      continue;
    }

    // Usa o preço retornado pela consulta.
    itens.add(
      ItemPedido(
        produto: produto,
        quantidade: quantidade,
      ),
    );

    print(
      '\n${produto.nome} adicionado ao pedido '
      'por R\$ ${(preco * quantidade).toStringAsFixed(2)}.',
    );

    exibirCarrinho(itens);

    final resposta = lerTexto(
      '\nDeseja adicionar outro produto? (s/n): ',
    ).toLowerCase();

    if (resposta == 's') {
      continue;
    }

    if (resposta == 'n') {
      break;
    }

    print('Resposta inválida. Vamos continuar adicionando produtos.');
  }

  // Não registra pedidos vazios.
  if (itens.isEmpty) {
    print('Nenhum produto foi adicionado. Pedido não realizado.');
    return;
  }

  final pedido = Pedido(
    id: proximoId,
    itens: List<ItemPedido>.from(itens),
  );

  print('\n=== RESUMO FINAL DA COMPRA ===');
  print('Número do pedido: ${pedido.id}');

  for (final item in pedido.itens) {
    print(
      '${item.produto.nome} | '
      '${item.quantidade} unidade(s) | '
      'R\$ ${item.subtotal.toStringAsFixed(2)}',
    );
  }

  print(
    'VALOR TOTAL: R\$ ${pedido.valorTotal.toStringAsFixed(2)}',
  );

  final confirmacao = lerTexto(
    '\nDeseja confirmar a compra? (s/n): ',
  ).toLowerCase();

  if (confirmacao != 's') {
    print('Compra cancelada. Nenhum pedido foi registrado.');
    return;
  }

  historico.add(pedido);
  proximoId++;

  print('\n=== ACOMPANHAMENTO DO PEDIDO ===');

  await for (final mensagem in acompanharPedido(pedido)) {
    print(mensagem);
  }

  print('Pedido registrado com sucesso!');
}

// Consulta um pedido pelo número.
void exibirPedido() {
  if (historico.isEmpty) {
    print('\nNenhum pedido foi realizado.');
    return;
  }

  final id = lerInteiro('\nDigite o número do pedido: ');

  final encontrados = historico.where(
    (pedido) => pedido.id == id,
  );

  if (encontrados.isEmpty) {
    print('Pedido não encontrado.');
    return;
  }

  final pedido = encontrados.first;

  print('\n=== DETALHES DO PEDIDO ===');
  print('Número: ${pedido.id}');

  for (final item in pedido.itens) {
    print(
      '${item.produto.nome} | '
      'Quantidade: ${item.quantidade} | '
      'Subtotal: R\$ ${item.subtotal.toStringAsFixed(2)}',
    );
  }

  print(
    'Valor total: R\$ ${pedido.valorTotal.toStringAsFixed(2)}',
  );
  print('Status: ${pedido.status}');
}

// Exibe todos os pedidos realizados.
void exibirHistorico() {
  if (historico.isEmpty) {
    print('\nO histórico está vazio.');
    return;
  }

  print('\n=== HISTÓRICO DE PEDIDOS ===');

  double totalGeral = 0;

  for (final pedido in historico) {
    print('\nPedido ${pedido.id} | Status: ${pedido.status}');

    for (final item in pedido.itens) {
      print(
        '  ${item.produto.nome} | '
        'Quantidade: ${item.quantidade} | '
        'Subtotal: R\$ ${item.subtotal.toStringAsFixed(2)}',
      );
    }

    print(
      '  Total do pedido: R\$ ${pedido.valorTotal.toStringAsFixed(2)}',
    );

    totalGeral += pedido.valorTotal;
  }

  print(
    '\nSoma de todos os pedidos: '
    'R\$ ${totalGeral.toStringAsFixed(2)}',
  );
}

// Menu principal.
Future<void> main() async {
  var executando = true;

  print('================================');
  print('       LOJA VIRTUAL EM DART');
  print('================================');

  while (executando) {
    print('\n=== MENU PRINCIPAL ===');
    print('1 - Fazer pedido');
    print('2 - Exibir um pedido');
    print('3 - Ver histórico de pedidos');
    print('4 - Sair');

    final opcao = lerTexto('\nEscolha uma opção: ');

    switch (opcao) {
      case '1':
        await fazerPedido();
        break;

      case '2':
        exibirPedido();
        break;

      case '3':
        exibirHistorico();
        break;

      case '4':
        executando = false;
        print('\nObrigado por utilizar a loja!');
        break;

      default:
        print('Opção inválida. Tente novamente.');
    }
  }
}
