# Documentação das Principais Classes do Projeto

## Classe `Todo`
Representa uma tarefa no aplicativo.

### Propriedades:
- `id`: Identificador único da tarefa.
- `title`: Título da tarefa.
- `savings`: Economia em kWh/mês associada à tarefa.
- `done`: Indica se a tarefa foi concluída.

### Métodos:
- `fromJson(Map<String, dynamic> json)`: Cria uma instância de `Todo` a partir de um mapa JSON.
- `toJson()`: Converte a instância de `Todo` em um mapa JSON.

## Classe `TodoList`
Um widget que exibe uma lista de tarefas.

### Propriedades:
- `tasks`: Lista de tarefas a serem exibidas.
- `updateTasks`: Função para atualizar a lista de tarefas.
- `updateTaskDone`: Função para atualizar o status de conclusão de uma tarefa.

### Métodos:
- `build(BuildContext context)`: Constrói a interface do widget.

## Classe `Game`
Um widget que exibe o jogo principal, incluindo a lista de tarefas e a economia total.

### Propriedades:
- `tasks`: Lista de tarefas a serem exibidas.
- `updateTasks`: Função para atualizar a lista de tarefas.
- `updateTaskDone`: Função para atualizar o status de conclusão de uma tarefa.

### Métodos:
- `_calculateTotalSavings()`: Calcula a economia total com base nas tarefas concluídas.
- `build(BuildContext context)`: Constrói a interface do widget.

## Classe `CreateTodoScreen`
Um widget que permite ao usuário criar e editar tarefas.

### Propriedades:
- `database`: Instância do banco de dados.
- `updateTasks`: Função para atualizar a lista de tarefas.

### Métodos:
- `_fetchTodos()`: Busca as tarefas do banco de dados.
- `_addTodo()`: Adiciona uma nova tarefa ao banco de dados.
- `_deleteTodo()`: Remove uma tarefa do banco de dados.
- `_editTodoDialog(BuildContext context, int index)`: Exibe um diálogo para editar uma tarefa.
- `build(BuildContext context)`: Constrói a interface do widget.

## Classe `MyApp`
Classe principal do aplicativo que configura o tema e a tela inicial.

### Métodos:
- `build(BuildContext context)`: Constrói a interface do aplicativo.

## Classe `MyHomePage`
Tela inicial do aplicativo que exibe o jogo e permite a navegação para a tela de criação de tarefas.

### Propriedades:
- `title`: Título da tela.
- `_database`: Instância do banco de dados.
- `_tasks`: Lista de tarefas.

### Métodos:
- `_initDatabase()`: Inicializa o banco de dados.
- `_fetchTasks()`: Busca as tarefas do banco de dados.
- `_updateTasks()`: Atualiza a lista de tarefas.
- `_updateTaskDone(int id, bool done)`: Atualiza o status de conclusão de uma tarefa.
- `build(BuildContext context)`: Constrói a interface da tela.
