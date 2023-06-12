# Raro Academy Bank - Grupo 01 - Dev Funcionar

O Projeto final da turma de Ruby on Rails - Raro Academy trata-se de uma aplicação onde alunos podem ganhar bônus (_raracoins_) e gerenciá-las como quiser, seja transferindo para outros alunos ou aplicando nos investimentos disponibilizados.

Os usuários da aplicação podem ser de três tipos: _administrador_, usuário _free_ ou usuário _premium_. Como o administrador tem características diferentes dos demais usuários, foi definido todo um ambiente diferenciado para ele, com um design mais simples, porém com todas as funcionalidades necessárias onde ele pode gerenciar os usuários, os investimentos, as turmas, além distribuir _raracoins_. Já os usuários _free_ e _premium_ tem um ambiente mais voltado para o usuário final, com um design mais elaborado e intuitivo, onde ele pode gerenciar suas _raracoins_ aplicando em investimentos e realizando transferências.

## Objetivos

Na [proposta do projeto final](.gitlab/enunciado.md) foram definidos os seguintes objetivos:

- [x] Cadastrar usuários

  - deve ser solicitado a confirmação da conta através de link enviado por e-mail.
  - deve ser possível solicitar recuperação de senha, que deve ser enviada por e-mail e ficar valida por apenas 2 horas.

- [x] Cadastrar turmas

  - administradores podem cadastrar turmas.
  - administradores podem adicionar alunos a turmas.
  - alunos adicionados a uma turma automaticamente se torna usuário _premium_.

- [x] Cadastrar saldo

  - administradores podem adicionar saldo a um usuário individualmente ou através de uma turma.

- [x] Realizar transferências

  - usuários podem transferir saldo para outros usuários através do CPF.
  - um usuário poderá ter somente uma conta.
  - todo o histórico de transferências deve ser armazenado e associado apenas ao usuário que realizou a transferência.
  - um usuário não poderá ter acesso ao saldo ou extrato de outro usuário.

- [x] Cadastrar investimentos

  - administradores podem cadastrar diversos produtos que precisam ter um nome, data de inicio e fim de vigência, valor mínimo, indexador e podem ser disponibilizados apenas para usuários premium.
  - indexador pode ser qualquer índice coletável da API do Banco Central.
  - investimentos devem estar listados em um catálogo.

- [x] Realizar investimentos
  - usuários podem aplicar saldo em investimentos e retirá-los quando quiser.
  - o resgate deve ser calculado entre valor aplicado + rendimentos.
  - o rendimento deve ser diário e o saldo do investimento deverá ser atualizado todos os dias as 8 da manhã.
  - ao chegar a data de vencimento, o valor do investimento deve ser resgatado automaticamente.
  - os produtos do catálogo podem ser filtrados por indexador, valor mínimo, data de vencimento e produtos premium, se o usuário tiver acesso a estes;
  - os produtos premium devem ter uma tag de destaque na tela de listagem.

## Passo a passo

Em conjunto o grupo tomou decisões que nortearam o desenvolvimento do projeto como, por exemplo, quais ferramentas usar, como documentar, divisão de tarefas e regras de negócio, entre outras. Na sequência estão detalhadas algumas delas.

### Modelagem de Dados

Antes mesmo de escrever a primeira a linha de código, foi realizada a modelagem de dados, onde foram definidas as entidades, seus atributos, relacionamentos e cardinalidades. Utilizamos a ferramenta [Drawio](https://www.drawio.com/) para a criação do Diagrama Entidade-Relacionamento (Der) e [QuickDBD](https://www.quickdatabasediagrams.com/) para a criação do Diagrama Lógico Relacional. Durante o desenvolvimento algumas alterações foram necessárias, incluindo a criação de duas novas entidades: Token e Indicator. O resultado do Diagrama Lógigo Relacional pode ser visto abaixo:

- [x] Diagrama Lógico Relacional

### Inicialização do projeto

Com a modelagem de dados pronta, começamos a pensar nas configurações iniciais que seriam necessárias para o projeto, incluindo _gems_, banco de dados, entre outras. Em seguida foi criado o repositório no Gitlab e o projeto foi iniciado seguindo as etapas que foram documentadas [aqui](.gitlab/starting-project.md). Configurações como variáveis de ambiente e opção de iniciar o banco de dados com `docker`foram incluídas. Realizamos ainda algumas configurações a nível de repositório como bloqueio da branch `main` e criação da branch `develop` que foi definida como `default`e de onde partiram todas as outras branches criadas durante o desenvolvimento do projeto.

### Estruturando documentação

Já pensando na melhor forma de documentar todo o processo de desenvolvimento do projeto foram criados templates para serem aplicados nas _issues_ do Gilab. O objetivo era que todas as _issues_ tivessem a mesma estrutura, facilitando assim a leitura e entendimento de todos os envolvidos. O template criado pode ser visto [aqui](.gitlab/issue_templates/default.md). Para o _merge request_ também foi criado um template que pode ser conferido [aqui](.gitlab/merge_request_templates/default.md).
Sobre a criação de _issues_, fizemos uma lista com todas as funcionalidades que deveriam ser desenvolvidas, incluindo as regras de negócio. A lista pode ser conferida [aqui](.gitlab/issues-list.md). A partir dessa lista foram criadas as _issues_ que foram distribuídas entre os membros do grupo. Abaixo está demonstrado como o _board_ foi utilizando. Criamos _labels_: to do, doing, review e done. A medida que as _issues_ eram criadas, elas eram adicionadas na coluna to do. Quando um membro do grupo assumia a _issue_, ela era movida para a coluna doing. Quando o desenvolvimento da _issue_ era finalizado, ela era movida para a coluna review, onde outro membro do grupo fazia a revisão do código. Quando a revisão era finalizada, a _issue_ era movida para a coluna _closed_ com label done. Tivemos ainda uma label com título _extra_, para marcar que uma tarefa era "extra código", como tarefas de design e documentação.

### Iniciando o código

Durante as reuniões diárias da primeira semana, o grupo definiu que o desenvolvimento do projeto poderia ser definido em partes, conforme foi feito durante o curso na execução do projeto Raro Food. Sendo assim, seguindo a arquitetura MVC, o projeto foi dividido da seguinte forma:

- **Models**
  Separamos as 6 entidades iniciais e dividimos entre cada integrante. Dessa forma, cada um ficou responsável por criar as migrations, models, validações, scopes, callbacks e testes de cada entidade. A distribuição das entidades ficou assim:

  - Klaus: Investments e User_investments
  - Sabrina: Users e Classrooms
  - Thalys: Account e Transactions

  A notação dos relacionamentos foram realizadas em _issues_ a parte. Ou seja, apenas quando as migrates e models estavam prontos, as notações de _has many_, _has one_ foram concluídas.

  Essa divisão seguiu até o final do projeto, porém novas entidades surgiram: Token e Indicator. A primeira para guardar e gerenciar as informações dos tokens das transações e por isso o Thalys ficou responsável por ela. A segunda foi necessária para armazenar as informações consumidas da API do Banco Central necessárias para a funcionalidade de Investimentos, por isso o Klaus ficou responsável por ela.

  - **Controllers e Views**
    Para não separar os controllers das views, já que ambos funcionam em conjunto, a próxima etapa foi configurar os controllers de cada entidade e deixar as views necessárias o mais funcional possível, sem a preocupação com o estilo. Nesse momento também cada integrante precisaria criar as rotas de acordo com a necessidades de seus controllers, porém, buscando uma melhor organização e padronização foi definida uma _issue_ para realizar estruturar todas as rotas da aplicação e dessa forma o desenvolvimento seguir uma padrão.

  - **Rotas**
  - Nesse momento foi definido toda a estrutura da aplicação baseada de acordo com o atributo _role_ da entidade User. Mas antes, foi pensando também nos acessos da aplicação onde um usuário ainda não está logado. O resultado foi esse:

    - Usuários não autenticados serão redirecionados para a página de login ao bater em qualquer rota, exceto rotas para _cadastro de usuário_ e _esqueci minha senha_;
    - Usuários autenticados forão divididos em dois grupos: admin e user premium/free:

  - `ADMIN`

    - foi definido _namespace_ admin, ou seja, todas as rotas deste usuário começarão com `/admin`;

    `constraints/roles_constraint.rb`

    - O acesso as rotas acontecem de acordo com as constraints aplicadas. Por exemplo, as rotas acessadas por usuários com o atributo role do tipo admin passarão por uma validação, garantindo o acesso restrito.

    `application_controller.rb`

    - Implementados os métodos que verificam e validam as autenticação dos usuários nos controllers, utilizando o `before_action`.
      - authenticate_admin! - verifica se o usuário logado possui role: admin, lança erra caso não;
      - authenticate_free! - verifica se o usuário logado possui role: free, lança erra caso não;
      - authenticate_premium! - verifica se o usuário logado possui role: premium, lança erra caso não;
      - authenticate_free_or_premium_user! - verifica se o usuário logado possui role: free ou premium, lança erra caso não.

    `views`

    - As views e controllers _home_ e _admin_ foram criadas para dar inicio a separação citada anteriormente;
    - As views foram separadas em dois layouts: "admin" e "application". Um para aplicação em ambiente administrativo e outro para ambiente de usuário padrão, respectivamente;

As rotas foram criadas no intuito de indicar o caminho do que seria implementado, para que fosse possível visualizar o cenário e utilizá-las como guia, mas cada caso foi ajustado conforme suas necessidades e particularidades.

- **Regras de negócio e funcionalidades**
  Com todo o MVC estruturado passamos a trabalhar para realizar implementações que garantissem as regras de negócio definidas para o projeto (tendo como base [proposta do projeto final](.gitlab/enunciado.md)). Abaixo estão detalhadas as implementações realizadas.

  - Investimentos:
  - - Criada rota para o catálogo de investimentos '/catalogs', nela é listado todos os investimentos registrados que já estão na start_date ou seja que já começaram o seu período de duração. Os investimentos do usuário são acessados na rota /user_investments.
    - Para os usuários _free_ será listado todos os investimentos(free e premium) mas eles não poderão acessar os investimentos para _premium_. Já os usuários premium podem ver todos e comprar todos os tipos de investimentos.
    - Criado métodos para que ao o usuário comprar ou resgatar um investimento, seu saldo na conta atualize.
    - - Criado Job para agendar a action `destroy` do investimento para a sua data de expiração. Quando o investimento expirar, as contas de todos os usuários que estavam registrados nele, receberão o seu o lucro de acordo com o investido.
  - Adicionada tela de detalhes do investimento do usúario, onde ele pode resgastar o investimento.

- Implementado Job para atualizar o profit do investimento. Nele é calculado o valor diário que deve render, de acordo o nome do investimento. Ex: Selic + 200% => renderia o valor diário x 200%.
- Criado uma task para que ao o whenever fazer a request diária para a API do banco central, ser disparado a atualização do profit para o valor do dia.
- Implementado validações para checagem de balance ao comprar um investimento e checar se o initial amount é suficiente para a compra.

Foi nessa etapa que surgiram as novas entidades citadas anteriormente como apoio para Transactions e Investments.

## Usuário Administrador

## Usuário Premium

# Raro Academy Bank

- [Enunciado](.gitlab/enunciado.md)
- [Iniciando o projeto](.gitlab/starting-project.md)
- [Configurando o ambiente com Docker](.gitlab/docker-instructions.md)
- [Diagrama Entidade-Relacionamento (Der)](.gitlab/DiagramaRelacional-RaroBank.svg)
- [Diagrama Lógico Relacional](.gitlab/diagrama-relacional-logico.svg)
- [Lista de Issues](.gitlab/issues-list.md)
- [Styleguide](.gitlab/styleguide.md)
- [Figma](.gitlab/styleguide-figma.md)

Para acompanhar o restante do desenvolvimento, enquanto não realizamos nossa documentação, acesse nosso [board](https://git.raroacademy.com.br/sabrina.gomes/projeto-final-grupo-1-raro-academy-bank/-/boards).
