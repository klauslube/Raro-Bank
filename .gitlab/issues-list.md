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
- [ ] [Implementar regras de negócio da uma transação](#implementar-regras-de-negócio-da-uma-transação)
- [ ] [Implementar token de validação de transações](#implementar-token-de-validação-de-transações)
- [ ] [Implementar envio de email para usuários recebem transações](#implementar-envio-de-email-para-usuários-recebem-transações)
- [ ] [Implementar campo de filtragem para listas de investimentos](#implementar-campo-de-filtragem-para-listas-de-investimentos)
- [ ] [Implementar integração com API de investimentos do Banco Central](#implementar-integração-com-api-de-investimentos-do-banco-central)
- [ ] [Implementar regras de negócio da um investimento](#implementar-regras-de-negócio-da-um-investimento)
- [ ] [Implementar jobs para gerir e atualizar investimentos em vigência](#implementar-job-para-gerir-e-atualizar-investimentos-em-vigência)
- [ ] [Gerar seeds que alimentam o banco de dados](#gerar-seeds-que-alimentam-o-banco-de-dados)
- [ ] [Detalhar view no Figma](#detalhar-view-no-figma)
- [ ] Implementar estilo no layout Application - Estrutura, navbar e etc
- [ ] Implementar estilo no layout Admin - Estrutura, navbar e etc
- [ ] Aplicar estilo de tela de User não logado: Login
- [ ] Aplicar estilo de tela de User não logado: Cadastro
- [ ] Aplicar estilo de tela de User não logado: Recuperar Senha
- [ ] Aplicar estilo de tela de User logado: Home
- [ ] Aplicar estilo de tela de User logado: Investment
- [ ] Aplicar estilo de tela de User logado: Transactions
- [ ] Aplicar estilo de tela de User logado: Edição de Perfil
- [ ] Aplicar estilo de tela de Admin: Home, Edição de Perfil
- [ ] Aplicar estilo de tela de Admin: CRUD de Users
- [ ] Aplicar estilo de tela de Admin: CRUD de Classrooms
- [ ] Aplicar estilo de tela de Admin: CRUD de Investment
- [ ] Aplicar estilo de tela de Admin: Cadastro de saldo para User/Users/Classroom
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

### Implementar envio de email para usuários recebem transações

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

Além disse deve ser implementado um job que atualiza a taxa SELIC diariamente no nosso banco de dados. Para isso, deverá ser utilizado a gem [Sidekiq](https://github.com/sidekiq/sidekiq) ou [Whenever](https://github.com/javan/whenever).

A nível de modelagem, deverá ser criado um model para armazenar a taxa SELIC, que deve ser atualizado diariamente.

**Trecho do enunciado:**

> O sistema deve permitir a um público de usuários administradores o cadastro de produtos de investimentos, que aceitam aplicações em _Pauloedas_. Estes produtos deverão ser indexados por indicadores reais, como SELIC, CDI, IPCA… Você precisará consultar a API para buscar os valores de cada indicador, a fim de calcular para o seu cliente os valores a serem recebidos nos investimentos. Este recurso deverá estar presente no valor parcial do investimento e no momento do saque dos valores. Estes indicadores deverão ser buscados através de um job, responsável por capturar na API os valores dos indicadores diários e armazená-los no banco."

### Implementar regras de negócio da um investimento

Implementar as regras de negócio da um investimento, como por exemplo, o usuário:

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

Detalhar view no Figma, com o objetivo de facilitar a implementação das views. Deve visar a melhor experiência do usuário, com foco na usabilidade.

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
- _Usuários_:
  - Listagem de usuários;
  - Detalhes de um usuário;
  - Formulário de cadastro de usuário;
    - Deve ser possível adicionar um usuário a uma turma;
    - Deve ser possível conceder privilégios de `admin`;
  - Formulário de edição de usuário com possibilidade de exclusão de usuário;
    - Devem ser possíveis adicionar e remover um usuário de uma turma;
    - Deve ser possível conceder/remover privilégios de `admin`, a não ser que seja o último usuário `admin` do sistema;

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
