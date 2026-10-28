# Concorrência em Dart

Integrantes: Isaias Maia de Oliveira e Daniel Santos Baptista

Este repositório apresenta exemplos práticos de concorrência e assincronismo na linguagem Dart. O objetivo é demonstrar como executar operações assíncronas, organizar tarefas, trabalhar com fluxos de dados e utilizar isolates para processamento paralelo.

Os exemplos foram desenvolvidos para fins acadêmicos, com foco na compreensão dos conceitos e na aplicação prática dos recursos da linguagem.

## Objetivos

- Compreender a diferença entre concorrência e paralelismo.
- Conhecer o funcionamento de `Future` e `async/await`.
- Executar e aguardar múltiplas operações assíncronas com `Future.wait`.
- Entender o funcionamento básico do Event Loop.
- Trabalhar com fluxos de dados utilizando `Stream`.
- Conhecer o uso de isolates para processamento paralelo.
- Integrar diferentes recursos de assincronismo em um exemplo prático.

## Tecnologias utilizadas

- **Linguagem:** Dart
- **SDK:** Dart SDK 3.0 ou superior
- **Ferramentas:** terminal e editor de código, como Visual Studio Code

## Estrutura do projeto

```text
Concorrencia-dart/
├── bin/
│   ├── event_loop.dart
│   ├── exemplo_completo.dart
│   ├── future_basico.dart
│   ├── future_wait.dart
│   ├── isolate_run.dart
│   ├── isolate_spawn.dart
│   └── stream_basico.dart
├── .gitattributes
├── .gitignore
├── pubspec.lock
├── pubspec.yaml
└── README.md

```

## Como executar os exemplos

### 1. Instalar o Dart SDK

Antes de executar os programas, é necessário ter o Dart SDK instalado e configurado no sistema.

Documentação oficial: https://dart.dev/get-dart

Para verificar se a instalação está funcionando, execute:

```bash
dart --version
```

### 2. Clonar o repositório

```bash
git clone https://github.com/IsaiasdeOliveira/Concorrencia-dart.git
```

Entre na pasta do projeto:

```bash
cd Concorrencia-dart
```

### 3. Executar um exemplo

Os arquivos podem ser executados individualmente pelo terminal:

```bash
dart run bin/future_basico.dart
```

Para executar outro exemplo, basta substituir o nome do arquivo.

## Exemplos implementados

### 1. Future básico — `future_basico.dart`

Demonstra como representar o resultado de uma operação que será concluída no futuro.

O exemplo utiliza `Future.delayed` para simular uma tarefa assíncrona e `async/await` para aguardar sua conclusão.

**Conceitos demonstrados:**
- `Future`
- `async`
- `await`
- Operações assíncronas

### 2. Múltiplas operações — `future_wait.dart`

Demonstra como utilizar `Future.wait` para aguardar a conclusão de várias operações assíncronas.

Esse recurso é útil quando diferentes tarefas podem ser iniciadas sem depender do resultado umas das outras.

**Conceitos demonstrados:**
- Execução de operações assíncronas
- `Future.wait`
- Coordenação de resultados

### 3. Event Loop — `event_loop.dart`

Apresenta um exemplo simples da organização de tarefas no ambiente de execução do Dart.

O código utiliza `scheduleMicrotask` e `Future` para demonstrar que diferentes tipos de tarefas podem ser processados em momentos distintos.

**Conceitos demonstrados:**
- Event Loop
- Microtasks
- Eventos assíncronos
- Ordem de execução

### 4. Stream básico — `stream_basico.dart`

Demonstra como emitir e consumir uma sequência de valores ao longo do tempo.

Diferentemente de um `Future`, que representa um resultado assíncrono, um `Stream` permite trabalhar com vários eventos emitidos ao longo de sua execução.

**Conceitos demonstrados:**
- `Stream`
- `async*`
- `yield`
- Emissão e consumo de eventos

### 5. Isolate.run — `isolate_run.dart`

Apresenta um exemplo de processamento utilizando `Isolate.run`, executando um cálculo separado do fluxo principal do programa.

O exemplo soma os números de 1 até 1.000.000.

**Conceitos demonstrados:**
- Isolates
- Processamento paralelo
- Separação de trabalho computacional

### 6. Isolate.spawn — `isolate_spawn.dart`

Demonstra a criação de um isolate com `Isolate.spawn` e a comunicação entre isolates por meio de portas de mensagens.

**Conceitos demonstrados:**
- Criação de isolates
- `SendPort`
- `ReceivePort`
- Comunicação por mensagens

### 7. Exemplo integrado — `exemplo_completo.dart`

Este exemplo simula uma loja virtual simples, permitindo que o usuário interaja com o programa pelo terminal.

O sistema oferece as seguintes funcionalidades:

- Visualizar o catálogo de produtos.
- Escolher produtos e informar quantidades.
- Adicionar vários produtos a um mesmo pedido.
- Visualizar os itens selecionados e seus subtotais.
- Consultar o valor total da compra.
- Confirmar ou cancelar um pedido.
- Acompanhar as etapas de processamento do pedido.
- Consultar os detalhes de um pedido específico.
- Visualizar o histórico de pedidos realizados durante a execução.

O exemplo integra diferentes recursos da linguagem Dart em uma única aplicação.

**Conceitos demonstrados:**

- `Future` para simular consultas assíncronas de preço e estoque.
- `async/await` para aguardar operações assíncronas.
- `Future.wait` para aguardar conjuntamente
