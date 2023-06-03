# Lista de Issues

## Issues de desenvolvimento

- [x] Realizar protótipo de view no Figma
- [x] Iniciar projeto do ruby on rails com postgres, tailwind e etc
- [x] Elaborar as issues necessárias
- [x] Elaborar diagrama entidade relacionamento
- [x] Elaborar diagrama lógico relacional
- [x] Implementar model User
- [x] Implementar model Classroom
- [x] Implementar model Account
- [x] Implementar model Investment
- [x] Implementar model User Investment
- [x] Implementar model Transaction
- [x] Implementar Controller e View User
- [x] Implementar Controller e View User de Admin
- [x] Implementar Controller e View Classroom
- [x] Implementar Controller e View Account
- [x] Implementar Controller e View Investment
- [x] Implementar Controller e View User Investment
- [x] Implementar Controller e View Transaction
- [x] Configurar Dockerfile
- [x] [Implementar regras de negócio da uma transação](#implementar-regras-de-negócio-da-uma-transação)
- [x] [Implementar token de validação de transações](#implementar-token-de-validação-de-transações)
- [x] [Implementar envio de email para usuários recebem transações](#implementar-envio-de-email-para-usuários-participantes-de-transações)
- [x] [Implementar campo de filtragem para listas de investimentos](#implementar-campo-de-filtragem-para-listas-de-investimentos)
- [x] [Implementar integração com API de investimentos do Banco Central](#implementar-integração-com-api-de-investimentos-do-banco-central)
- [x] [Implementar regras de negócio de um investimento](#implementar-regras-de-negócio-de-um-investimento)
- [x] [Implementar jobs para gerir e atualizar investimentos em vigência](#implementar-job-para-gerir-e-atualizar-investimentos-em-vigência)
- [x] [Gerar seeds que alimentam o banco de dados](#gerar-seeds-que-alimentam-o-banco-de-dados)
- [x] [Detalhar view no Figma](#detalhar-view-no-figma)
- [x] [Implementar estilo no layout Application](#implementar-estilo-no-layout-application)
- [x] [Implementar estilo no layout Admin](#implementar-estilo-no-layout-admin)
- [x] Aplicar estilo de tela de User não logado: Login
- [x] Aplicar estilo de tela de User não logado: Cadastro
- [x] Aplicar estilo de tela de User não logado: Recuperar Senha
- [x] Aplicar estilo de tela de User logado: Home
- [x] Aplicar estilo de tela de User logado: Investment
- [x] Aplicar estilo de tela de User logado: Transactions
- [x] Aplicar estilo de tela de User logado: Edição de Perfil
- [x] Aplicar estilo de tela de Admin: Home, Edição de Perfil
- [x] Aplicar estilo de tela de Admin: Users
- [x] Aplicar estilo de tela de Admin: Classrooms
- [x] Aplicar estilo de tela de Admin: Investment
- [x] Aplicar estilo de tela de Admin: Cadastro de saldo
- [ ] Implementar estilo de notificações
- [ ] Implementar página de erros: 404/500

## Issues finais

- [ ] Criar documentação principal, revisar existentes e atualizar
- [ ] Revisar e atualizar ambiente Docker antes da entrega final

## Issues extras

- [ ] Implementar imagem de perfil dos usuários, utilizando o [Active Storage](https://guides.rubyonrails.org/active_storage_overview.html)
- [ ] Implementar mensagem em transações, utilizando o [Action Text](https://guides.rubyonrails.org/action_text_overview.html)
- [ ] Implementar locale - i18n

## Detalhes

### Implementar token de validação de transações

Utilizando JWT, implementar um token para validar uma transação por um token enviado por email. Todos os níveis necessários (MVC) devem ser implementados.

**Trecho do enunciado:**

> "Para que uma transferência seja efetuada, o usuário deverá receber um token com 6 caracteres numéricos por e-mail e digitá-lo para efetuar a transferência. Este token deve ter duração limitada de x minutos, parametrizado no sistema (parâmetros configurados por variável de ambiente)."

### Implementar regras de negócio da uma transação

Implementar as regras de negócio da uma transação, como por exemplo, o sistema deve ser capaz de:

- realizar transferências de uma conta para outra;
- transferir através de CPF;
- guardar histórico de transferências do usuário;
- usuário não pode transferir para ele mesmo;
- usuário não pode transferir para um CPF que não existe;
- deve gerir, validação e atualizar os saldos conforme as transferências, tanto de quem envia quanto de quem recebe;
- deve gerir e validar limites de horários e dias para transferências, sendo que o usuário não pode transferir em horários e dias não permitidos;
  - Segunda a Sexta das 08hs às 18hs;
  - Desconsiderar feriados;
- deve agendar para próximo horário possível;
- ao finalizar uma transferência, o contato deve ser salvo para futuras transferências;

OBS: Analisar o enunciado para verificar se há mais regras de negócio.

### Implementar envio de email para usuários participantes de transações

Implementar um mailer capaz de enviar um email para os usuários que enviam e recebem transações. Aplicação de envio de email deve ser feita em background e de forma automática. Estilo deverá ser aplicado.

**Trecho do enunciado:**

> "Notificação de transferência para os usuários que fazem e recebem as transferências. Será necessário enviar um e-mail para estes usuários para contemplar a notificação."

OBS: Analisar a adição de um link que o envia para essa transferência.

### Implementar campo de filtragem para listas de investimentos

Onde houver listagem de investimento, utilizando a gem [Ransack](https://github.com/activerecord-hackery/ransack), deverá ser implementado um campo de filtragem para listas de investimentos. O campo deve ser capaz de filtrar por:

- nome;
- indexador SELIC;
- produtos free/premium, se houver acesso a produtos premium;
- valor mínimo;
- data de vencimento;

**Trecho do enunciado:**

> "Os produtos do catálogo podem ser filtrados por indexador, valor mínimo, data de vencimento e produtos premium, se o usuário tiver acesso a estes."

OBS: Analisar/Revisar/Sugerir novos campos de filtragem.

### Implementar integração com API de investimentos do Banco Central

Utilizando a gem [Faraday](https://github.com/lostisland/faraday) ou [rest-client](https://github.com/rest-client/rest-client) e a API [Dados Abertos do Banco Central](https://dadosabertos.bcb.gov.br/dataset/11-taxa-de-juros---selic/resource/b73edc07-bbac-430c-a2cb-b1639e605fa8), implementar uma integração com a API de investimentos do Banco Central. A integração deve ser capaz de buscar a taxa SELIC atual;

Além disso, deve ser implementado um job que atualiza os indicadores diariamente no nosso banco de dados. Para isso, deverá ser utilizado a gem [Sidekiq](https://github.com/sidekiq/sidekiq) ou [Whenever](https://github.com/javan/whenever).

A nível de modelagem, deverá ser criado um model para armazenar a taxa SELIC, que deve ser atualizado diariamente.

**Trecho do enunciado:**

> O sistema deve permitir a um público de usuários administradores o cadastro de produtos de investimentos, que aceitam aplicações em `_rarocoins`\_. Estes produtos deverão ser indexados por indicadores reais, como SELIC, CDI, IPCA… Você precisará consultar a API para buscar os valores de cada indicador, a fim de calcular para o seu cliente os valores a serem recebidos nos investimentos. Este recurso deverá estar presente no valor parcial do investimento e no momento do saque dos valores. Estes indicadores deverão ser buscados através de um job, responsável por capturar na API os valores dos indicadores diários e armazená-los no banco."

### Implementar regras de negócio de um investimento

Implementar e checar as regras de negócio de um investimento, para que no fim, o usuário:

- Deve realizar investimentos a partir de uma lista de investimentos disponíveis, de acordo com sua modalidade: `free` ou `premium`;
- Deve poder retirar, a qualquer momento, o valor investido, com os devidos rendimentos, de acordo com a modalidade do investimento. Não considerar a incidência de impostos ou taxas bancárias;
- Deve poder realizar investimentos em mais de um produto ao mesmo tempo;
- Deve ter seu investimento retornado com os devidos rendimentos, de acordo com a modalidade do investimento:
  - caso o cliente solicite o cancelamento do produto;
  - caso o cliente feche sua conta;
  - quando acabar o tempo de vigência do produto;
  - caso o produto seja removido do catálogo;

OBS: Analisar o enunciado para verificar se há mais regras de negócio.

### Implementar job para gerir e atualizar investimentos em vigência

Implementar job para gerir e atualizar investimentos em vigência. Os jobs devem ser capazes de:

- atualizar o valor de investimentos em vigência, todos os dias as 8:00 da manhã, de acordo com a taxa SELIC;

OBS: Analisar e perceber possíveis jobs necessários pra um bom funcionamento da aplicação.

### Gerar seeds que alimentam o banco de dados

Utilizando a gem [Faker](https://github.com/faker-ruby/faker), gerar seeds que alimentam o banco de dados com dados de teste. Os seeds devem ser gerar:

- usuários: `free` e `premium`;
- contas: `free` e `premium`;
- investimentos: `free` e `premium`;
- transferências;
- investimentos em vigência;
- o que mais for necessário para que seja possível testar a aplicação de forma completa;

### Detalhar view no Figma

Detalhar views no Figma, com o objetivo de facilitar a implementação a estilização e implementações das views. Deve visar a melhor experiência do usuário, com foco na usabilidade.

Foi separado dois ambientes na aplicação, um para o usuário comum (free ou premium) e outro para o usuário admin.

**Layout ADMIN**:

- _Investments_:
  - Listagem de investimentos;
  - Detalhes de um investimento;
  - Formulário de cadastro de investimento;
  - Formulário de edição de investimento com possibilidade de exclusão de investimento;
- _Classrooms_:
  - Listagem de turmas;
  - Detalhes de uma turma;
  - Formulário de cadastro de turma
    - Deve ser possível adicionar alunos a uma turma;
  - Formulário de edição de turma com possibilidade de exclusão de turma;
    - Devem ser possíveis adicionar e remover alunos de uma turma;
- _Users_:
  - Listagem de usuários;
  - Detalhes de um usuário;
  - Formulário de edição limitada de usuário com possibilidade de:
    - Deve ser possível adicionar/remover um usuário a uma turma;
    - Deve ser possível conceder/remover privilégios de `admin`, a não ser que seja o último usuário `admin` do sistema;
- _Deposit_:
  - Deve poder adicionar `rarocoins` na conta de um usuário específico;
  - Deve poder adicionar `rarocoins` na conta de todos os usuários de uma turma específica;

**Layout USUÁRIO**:

- _Investments_:
  - Listagem de investimentos/catálogo de investimentos;
  - Listagem de investimentos do usuário, separados por:\*
    - Investimentos em vigência;
    - Investimentos finalizados;
  - Detalhes de um investimento;
    - Rendimento
    - Detalhes do investimento
    - Botão para investir
    - Botão para resgatar
- _Transactions_:
  - Listagem de transferências;\*
  - Detalhes de uma transferência;
  - Formulário para uma nova transferência:
    - Listagem de contatos com quem já foi realizada uma transferência;
- Extrato: listagem de transações e investimentos, separados por:
  - Investimentos retirados da conta (investido);
  - Investimentos adicionados a conta (resgatado);
  - Transferências;

\*: Avaliar a necessidade de implementar.

#### Estruturar estilo no layout Admin

Implementar estrutura do espaço administrativo, seguindo o layout definido no [figma](https://www.figma.com/file/9Qh0FAv4BoUbGXp8jrJRqT/RaroBank?type=design&node-id=0-1&t=jmcZAzVcD5TiKnrf-0).

- Deve ser utilizado o [Tailwind UI](https://tailwindui.com/) para facilitar a implementação do layout;
- Nesse momento, estilizar areas como por exemplo: o menu, o cabeçalho, o rodapé, etc. Levar em conta todo o contexto que não envolva as páginas e formulários, e sim o layout geral da aplicação do administrador;
- Deve-se utilizar de _helpers_ para organização e futura manutenção do código CSS;
- Não é necessário implementar a lógica de funcionamento, apenas a estrutura visual;

#### Estruturar estilo no layout Application

Implementar estrutura do espaço de usuário, seguindo o layout definido no [figma](https://www.figma.com/file/9Qh0FAv4BoUbGXp8jrJRqT/RaroBank?type=design&node-id=0-1&t=jmcZAzVcD5TiKnrf-0).

- Deve ser utilizado o [Tailwind UI](https://tailwindui.com/) para facilitar a implementação do layout;
- Nesse momento, estilizar areas como por exemplo: o menu, o cabeçalho, o rodapé, etc. Levar em conta todo o contexto que não envolva as páginas e formulários, e sim o layout geral da aplicação do usuário `free` ou `premium`;
- Deve-se utilizar de _helpers_ para organização e futura manutenção do código CSS;
- Não é necessário implementar a lógica de funcionamento, apenas a estrutura visual;

#### Aplicar estilo de tela de User não logado: Login

- Implementar estilo da tela de login, seguindo o layout definido no [figma](https://www.figma.com/file/9Qh0FAv4BoUbGXp8jrJRqT/RaroBank?type=design&node-id=0-1&t=jmcZAzVcD5TiKnrf-0).
- Deve ser utilizado o [Tailwind UI](https://tailwindui.com/) para facilitar a implementação do layout;
- Deve-se utilizar de _helpers_ para organização e futura manutenção do código CSS;
- Não é necessário implementar a lógica de funcionamento, apenas a estrutura visual;
