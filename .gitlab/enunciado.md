# Projeto Final Turma Ruby on Rails

# Raro Bank - O Banco para as suas Pauloeda$

## Motivação

Quem nunca ficou até depois da hora em alguma aula do Paulo que atire a primeira pedra…
Já não é de hoje que nosso querido instrutor Paulo se empolga em suas aulas e acaba alongando a aula por (muito) mais do que 2 horas. Depois de 4 turmas de muito conteúdo e empolgação, o volume de Pauloedas em circulação e na mão dos nossos alunos e ex-alunos vem crescendo cada vez mais. Por conta disso, vimos a necessidade de ter um local não só para um armazenamento seguro das Pauloedas, mas também para que elas possam trazer ganhos em rendimentos ou serem transferidas mais facilmente entre vocês.
Afinal, Pauloeda$ is the new crypto.

## A ferramenta e suas funcionalidades

### Cadastro de usuários

Perfis:

- Usuários free (qualquer pessoa)
- Usuários premium (alunos e ex-alunos): são usuários que possuem um vínculo com uma turma da Raro Academy. Eles têm acesso a investimentos específicos.
- Administrador: usuário com acesso às telas de cadastro da plataforma.

#### Requisitos acessórios:

- "Esqueci minha senha": O usuário deverá preencher seu email na ferramenta. O sistema deverá enviar um email para o usuário, que permita realizar a recuperação de sua senha, para obter o acesso novamente a plataforma. Esse email deve ser válido por apenas 2 horas.
- "Confirmação de conta": Para que o usuário utilize sua conta, é necessário que ele confirme sua conta em um e-mail a ser recebido após a finalização do cadastro.

### Cadastro de turmas

Telas de gestão de turmas. Usuários são considerados premium no momento que são associados a uma turma qualquer, tornando este usuário um "aluno".

### Cadastro de saldo

Usuários administradores precisam ter uma tela onde eles possam adicionar saldo de Pauloeda$ ao fim de uma aula que tenha se estendido além do horário normal. O depósito de moedas poderá ser feito para cada usuário individualmente, mas também deve ser permitido que o administrador filtre e execute o acréscimo do saldo para toda a turma.

### Consulta de saldo e extrato

Atenção! Um usuário deve somente ver seus próprios dados. Um usuário acessar informações de outros usuários será considerado uma vulnerabilidade crítica do sistema.

### Transferências

- O sistema deve ser capaz de realizar transferências de uma conta para outra. A conta do usuário será identificada pelo seu cpf. Ou seja, uma pessoa física somente poderá ter uma conta, e todo seu histórico de transferências deve estar associado a esta.
- Deve haver validação de saldo para a transferência.
- Notificação de transferência para os usuários que fazem e recebem as transferências. Será necessário enviar um e-mail para estes usuários para contemplar a notificação.
- Para que uma transferência seja efetuada, o usuário deverá receber um token com 6 caracteres numéricos por e-mail e digitá-lo para efetuar a transferência. Este token deve ter duração limitada de x minutos, parametrizado no sistema (parâmetros configurados por variável de ambiente).
- Transferências devem ser permitidas entre as 08hs e 18hs dos dias de semana (2ª a 6ª). Para outros horários, as transferências deverão ser realizadas no próximo dia de semana (2ª a 6ª), às 08hs da manhã. Não estamos levando feriados em consideração.
- Ao iniciar uma transferência, o usuário deverá ver uma lista de "meus contatos". Esta lista contém os dados das contas que já receberam transferências. Caso você envie Pauloeda$ para uma nova conta, o usuário poderá usar uma opção de "novo contato", que deve buscar um novo usuário da lista de contas existentes no sistema.

### Investimentos

- Os usuários poderão escolher seus investimentos a partir dos produtos listados no catálogo de investimentos.
- O investimento poderá ser retirado pelo investidor quando ele quiser. O valor a ser retirado deverá ser igual ao valor aplicado + rendimentos, baseado no produto contratado.
- selic, ipca, cdi, 120% cdi…, ipca + 3%
- Não estamos levando em consideração taxas ou percentuais de pagamento do banco. Considere que todo o valor investido mais rendimentos será retornado ao usuário.
- O rendimento dos investimentos deverá ser diário. Ou seja, se o valor da Selic está indicado em 13,75% ao ano, o valor do rendimento de hoje será Selic/365.
- O saldo do investimento deverá ser atualizado todos os dias às 08hs da manhã.
- Quando um investimento terminar seu período e o usuário não retirar o valor investido, esta retirada deverá ser feita de forma automática, enviando os valores para a conta do usuário.
- Os produtos do catálogo podem ser filtrados por indexador, valor mínimo, data de vencimento e produtos premium, se o usuário tiver acesso a estes.
- Os produtos premium devem ter uma tag de destaque na tela de listagem.

### Cadastro de produtos de investimentos (exclusivo para admins)

- Um usuário administrador poderá cadastrar diversos produtos de investimentos. Cada produto precisará ter um nome, data de início e fim de vigência, valor mínimo de investimento e um indexador, sendo este qualquer índice coletável na API do Banco Central.
- Todos os investimentos cadastrados estarão listados em uma área chamada de catálogo de investimentos.
- O produto poderá ser cadastrado para perfis exclusivos do tipo "premium". Desta forma, o usuário comum até consegue visualizar os produtos premium, mas não poderão investir neles. O usuário privilegiado terá acesso e poderá investir em todos os produtos, inclusive os registrados como premium.
- Todos os produtos serão de renda fixa, ou seja, a cada dia do período investido, o valor do índice aplicado será somado ao montante acumulado pelo investidor ao final do período.
- Ex1 de produto: nome: "SELIC + 10%"; período: "3 meses"; valor mínimo: P$ 100,00; indexador: "SELIC"; premium: true
- Ex2 de produto: nome: "CDI"; período: "12 meses"; valor mínimo: P$ 50,00; indexador: "CDI"; premium: false

## Integração

- Consulta à [API do Banco Central](https://dadosabertos.bcb.gov.br/dataset/11-taxa-de-juros---selic/resource/b73edc07-bbac-430c-a2cb-b1639e605fa8):
- O sistema deve permitir a um público de usuários administradores o cadastro de produtos de investimentos, que aceitam aplicações em Pauloedas. Estes produtos deverão ser indexados por indicadores reais, como SELIC, CDI, IPCA…
- Você precisará consultar a API para buscar os valores de cada indicador, a fim de calcular para o seu cliente os valores a serem recebidos nos investimentos. Este recurso deverá estar presente no valor parcial do investimento e no momento do saque dos valores. Estes indicadores deverão ser buscados através de um job, responsável por capturar na API os valores dos indicadores diários e armazená-los no banco.

### Observações e dicas

- O fluxo de trabalho dos integrantes da equipe é parte fundamental da avaliação. Não deixem de documentar todo o desenvolvimento, utilizando o readme, issues, MRs e quaisquer outros meios que forem necessários ao time.
- Os professores vão avaliar a branch main do repositório apresentado pelos integrantes. Outros branches não serão avaliados. Será avaliado o último commit na branch main até as 23:59 do dia 12/06.
- Quaisquer recomendações para o funcionamento do projeto deverão ser apresentadas no readme. Caso não funcione, os professores não serão responsáveis por buscar informações ou depurar o projeto.
- Não se esqueçam de provisionar o funcionamento do sistema, mantendo seeds, migrations e outras estruturas necessárias atualizadas. Se for utilizado um banco de dados em específico, não deixem de documentar.
- Desenhamos um mock-up de baixa resolução para auxiliar vocês. Está disponível no seguinte [link](https://drive.google.com/file/d/15ZSxbJRGecbepLGEVpWxnT0trDCP1wUM/view?usp=sharing)

# REGRAS

## O que será avaliado?

#### Totalidade dos requisitos implementados: 12 pontos

- O projeto deverá ser criado através do comando de inicialização do ruby on rails. O grupo deve decidir pelas opções de alteração de processadores de js e css.
- Os requisitos do sistema devem estar completamente e corretamente implementados.
- Está vetado o uso de ferramentas como [active admin](https://activeadmin.info/). Os grupos devem implementar o projeto através do modelo MVC. O uso de concerns ou outras camadas necessárias não serão impedidas.
- Os dados do projeto deverão ser salvos em banco de dados POSTGRES. Demais bancos não poderão ser utilizados. Sugerimos que toda instrução necessária para facilitar a conexão ao banco de dados da aplicação seja apresentada no readme.
- Iremos aceitar trabalhos feitos na versão 3.2.1 do Ruby e 7.0 do Rails
- Espera-se que seguindo as boas práticas do TDD, sejam feitos testes da aplicação.

#### Usabilidade: 5 pontos

- A usabilidade deste sistema será levada em consideração na avaliação do trabalho. Será avaliada a facilidade do usuário encontrar os recursos disponibilizados. Para isso, garanta que as funcionalidades sejam acessíveis por menus, usem textos e validações legíveis e que sejam visualmente fáceis de operar. O uso de tabelas, filtros, formulários organizados e telas de apresentação dos dados (show) legíveis são fortemente recomendados.

#### Qualidade: 10 pontos

- A qualidade do código e boas práticas de organização e segurança das rotas da API.

#### Documentação: 8 pontos

- Deverá ser detalhada no README, a fim de ajudar a banca avaliadora e possíveis novos devs do projeto, para que consigam sustentar a aplicação de forma autônoma;
  - Documento demonstrando as tabelas e relações entre elas no banco de dados (MER - Modelo Entidade Relacionamento);
  - Recursos terceiros que sua aplicação utiliza: contas, credenciais, custos, etc.
  - O grupo precisa criar um repositório do projeto no gitlab da Raro Academy. Este repositório deverá ser acessível por todos os integrantes do grupo, pelos professores e monitores da turma.
    O grupo deverá organizar todo seu trabalho através de issues. Sugerimos a utilização dos [boards](https://docs.gitlab.com/ee/user/project/issue_board.html) do gitlab, para facilitar a gestão das tarefas em backlog, iniciadas ou finalizadas. Lembrem-se também de adicionar os responsáveis pelas tarefas.
    Vamos trabalhar com o modelo de trabalho do gitflow. Desta forma, o grupo deverá entregar o trabalho na branch main. Toda contribuição deverá ser feita ao projeto através de Merge Requests. Sugerimos que o grupo trabalhe com [branches protegidas](https://docs.gitlab.com/ee/user/project/protected_branches.html) para main e develop, permitindo contribuições apenas por merge requests aceitos.
    Os textos descrevendo issues e MRs serão critérios de avaliação da entrega. Sugerimos o uso de [template de MRs issues](https://docs.gitlab.com/ee/user/project/description_templates.html), para facilitar estes processos.

#### Desempenho: 5 pontos

- Será verificado se há problemas do ponto de vista de desempenho e se foi feito bom uso dos recursos computacionais. Ex.: Verificar se há um consumo excessivo da API, em atividades que esta utilização pode ser mais moderada;
- uso de eager loading de entidades em cascata
- uso de hotwire e demais estratégias de otimização da renderização do conteúdo

#### Apresentação: 5 pontos

- Não temos critérios obrigatórios para essa apresentação. Mas temos algumas dicas para ajudar vocês:
- É sempre interessante falar um pouco sobre o produto em si, antes de já apresentar o que foi entregue. “O que é?” “O que busca resolver?” “Quais as principais funcionalidades?”
- Imaginem que vocês fazem parte de um time de desenvolvimento de uma empresa, que desenvolveu a solução para um cliente, e esta apresentação é o momento de vocês venderem a solução criada.
- Pode ser interessante compartilhar um pouco do processo de desenvolvimento
- Não se esqueçam de que a apresentação é algo visual. Evite colocar muitos textos nos slides.
- Quanto mais integrantes do grupo participarem da apresentação, melhor! É um projeto em grupo, então estamos curiosos para ouvir um pouquinho de cada um. Porém, tenha cuidado para não estourar o tempo. - Organizem-se e ensaiem antes para não terem imprevistos durante a apresentação.
  - As regras para a Apresentação/Banca Final são essas:
    - 10 minutos de apresentação por grupo;
    - 15 minutos para comentários e perguntas da banca;
    - Banca composta pelos instrutores + Alguma(s) pessoa(s) de referência técnica da Raro Labs;
    - A nota final para este critério será a média das notas de cada membro da banca;
  - A nota da Apresentação será a mesma para todos os integrantes do grupo;

E VAMOS AOS GRUPOS………

#### Grupo 1:

- Davidson Couto Silva de Azevedo Lima
- Klaus Lube Paixão
- Sabrina Gomes Bezerra
- NoByte (Thalys Augusto da Silveira Silva)

#### Grupo 2:

- Alex Sandro Moreno da Silva Júnior
- Cristiano dos Santos
- Danilo Miranda de Araujo Laet Lopes
- Humberto Antonio Correia Ferro
- Rayssa Guilherme Neris Soares

#### Grupo 3:

- Bruna Chaves Barreto
- Gabriel Augusto Garcia Zanco
- Samuel Furtado Pinho
- Sidney de Souza Fontes Junior

#### Grupo 4:

- Daniel Drumond Fonte Boa
- Igor Corrêa Lana
- Thomás Batista Neves Ribeiro
- Yan Sousa de Castro

#### Grupo 5:

- Jadson Rubens Rocha de Oliveira
- João Vitor Lima Pereira Gonçalves
- Lucas Menezes Pinheiro
- Xita (Rodrigo Pimentel Satyro)
