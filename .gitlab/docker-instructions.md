# Aplicação Rails com Docker e PostgreSQL

### Sobre

Informações sobre como configurar e executar uma aplicação Rails usando Docker como ambiente, juntamente com o banco de dados PostgreSQL.

### Pré-requisitos

Antes de iniciar a configuração do ambiente, verifique se você possui os seguintes requisitos:

- Docker instalado: [Instruções de instalação do Docker](https://docs.docker.com/get-docker/)

### Configuração do Ambiente

Siga as etapas abaixo para configurar o ambiente de desenvolvimento:

- Clone o repositório da aplicação Rails para o seu ambiente local.

```bash
git clone https://git.raroacademy.com.br/sabrina.gomes/projeto-final-grupo-1-raro-academy-bank
```

- Navegue até o diretório raiz do projeto.

```bash
  cd projeto-final-grupo-1-raro-academy-bank
```

### Construção do Contêiner

Pode construir o contêiner Docker para a aplicação Rails. Execute o seguinte comando no diretório raiz do projeto:

```bash
  docker compose build
```

### Execução de comandos do Rails

Você pode executar comandos do Rails dentro do contêiner Docker. Por exemplo, para executar as ações no banco de dados, use o seguinte comando:

```bash
  docker compose run web rails db:create db:migrate db:seed
```

### Execução do Contêiner

```bash
  docker compose up
```

Caso dejese subir o contêiner em background, execute o seguinte comando:

```bash
  docker compose up -d
```

### Acesso à Aplicação

A aplicação estará disponível no endereço [http:localhost:3000](http://localhost:3000)
