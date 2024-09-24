# GitExplorer App

Este aplicativo iOS permite aos usuários navegar por perfis do GitHub, visualizar seus detalhes e repositórios associados. Ele utiliza a API pública do GitHub para buscar dados dos usuários e seus repositórios.

## Recursos

- Visualize uma lista de usuários do GitHub com seus nomes e avatares.
- Toque em um usuário para ver seus detalhes, incluindo a imagem de perfil e um botão para visualizar seus repositórios.
- Visualize os repositórios de um usuário, com informações sobre nome, descrição e linguagem de programação usada.

## Screenshots
![git-explorer-app](https://github.com/user-attachments/assets/48d9a92a-f919-48fe-bea8-49c98ce436c1)

## Tecnologias Utilizadas

O projeto utiliza a arquitetura **MVVM-C** (Model-View-ViewModel-Coordinator) para organizar o código de forma modular. Abaixo estão as principais tecnologias e classes utilizadas:

### Model
- `GitHubUserModel`: Representa um usuário do GitHub e contém informações como nome de login, avatar, URL do perfil e repositórios associados.

### View
- `UserListViewController`: Exibe uma lista de usuários do GitHub em uma `UITableView`. Utiliza uma célula personalizada para mostrar o nome e o avatar de cada usuário.
- `UserDetailViewController`: Exibe os detalhes de um usuário selecionado, incluindo o nome e a foto de perfil, além de um botão para visualizar os repositórios.
- `RepositoriesViewController`: Exibe uma lista de repositórios do usuário, incluindo informações como nome, descrição e linguagem de programação.
- `UserTableViewCell`: Célula personalizada para exibir as informações de um usuário na lista de usuários.
- `RepositoryTableViewCell`: Célula personalizada para exibir as informações de um repositório na lista de repositórios.

### ViewModel
- `GitHubViewModel`: Gerencia a lógica de negócios relacionada aos usuários e repositórios do GitHub. É responsável por interagir com o `GitHubService` para obter dados dos usuários e seus repositórios.

### Coordinator
- `GitHubCoordinator`: Gerencia a navegação entre as telas do aplicativo, facilitando a transição entre a lista de usuários, detalhes do usuário e lista de repositórios.

### Serviço de API
- `GitHubService`: Interage com a API pública do GitHub para recuperar informações sobre usuários e seus repositórios.

### Extensões e Utilitários
- `CustomError`: Enumeração que define possíveis erros de rede, API e parsing.

## Uso

1. Clone o repositório.
2. Abra o projeto no Xcode.
3. Rode e execute o aplicativo no simulador do iOS ou em um dispositivo físico.

## Arquitetura

Este aplicativo foi desenvolvido utilizando a arquitetura **MVVM-C** (Model-View-ViewModel-Coordinator) para manter a separação de responsabilidades e facilitar a manutenção do código. Abaixo estão alguns detalhes sobre como essa arquitetura foi implementada:

### Model
O `GitHubUserModel` representa um usuário do GitHub e seus repositórios. Ele utiliza o protocolo `Codable` para facilitar o parsing dos dados da API.

### ViewModel
O `GitHubViewModel` é responsável por buscar os dados dos usuários e repositórios do GitHub, interagindo com o `GitHubService` e retornando os dados processados para as views. Ele também notifica as views por meio de delegates sobre o sucesso ou falha nas operações de rede.

### Coordinator
O `GitHubCoordinator` lida com a navegação entre as telas, garantindo que o fluxo de navegação seja bem organizado e que cada tela esteja separada em sua própria função.

## API

O aplicativo utiliza a [API pública do GitHub](https://docs.github.com/en/rest), acessando os seguintes endpoints:

- `/users`: Busca uma lista de usuários do GitHub.
- `/users/{user}/repos`: Busca os repositórios de um usuário específico.

## Acessibilidade

Os principais elementos da interface foram rotulados adequadamente para garantir que o aplicativo seja acessível a todos os usuários, incluindo aqueles que utilizam leitores de tela.

## Próximos Passos

- Melhorar o layout visual. 
- Implementar paginação para carregar mais usuários e repositórios conforme o usuário realiza o scroll da lista.
- Adicionar uma barra de pesquisa para facilitar a busca de usuários específicos do GitHub.
- Adicionar mais informações na tela de detalhes do usuário. 
- Implementar alerta de erros.
- Criar uma ViewModel separada para cada tela, seguindo o princípio Single Responsibility do SOLID.

