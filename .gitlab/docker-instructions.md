# Aplicação Rails com Docker e PostgreSQL

### Sobre

Informações sobre como configurar e executar uma aplicação Rails usando Docker como ambiente, juntamente com o banco de dados PostgreSQL.

### Pré-requisito

Antes de iniciar a configuração do ambiente, verifique se você possui o Docker instalado com o comando:

```bash
  docker version
```

Caso não tenha, verifique as [instruções de instalação do Docker](https://docs.docker.com/get-docker/).

### Configuração do Ambiente

Siga as etapas abaixo para configurar o ambiente:

- Clone o repositório da aplicação Rails para o seu ambiente local:

```bash
git clone https://git.raroacademy.com.br/sabrina.gomes/projeto-final-grupo-1-raro-academy-bank
```

- Navegue até o diretório raiz do projeto:

```bash
  cd projeto-final-grupo-1-raro-academy-bank
```

### Construção do Contêiner

Para construir o contêiner Docker para a aplicação Rails, execute o seguinte comando no diretório raiz do projeto:

```bash
  docker compose build
```

Para verificar se tudo ocorreu corretamente:

```bash
  docker images
```

O retorno deverá conter: `projeto-final-grupo-1-raro-academy-bank-we`

### Execução de comandos do Rails

Você pode executar comandos do Rails dentro do contêiner Docker. Por exemplo, para executar as ações no banco de dados, use o seguinte comando:

```bash
  docker compose run web rails db:create db:migrate db:seed
```

Ao final os bancos de dados deverão ter sido criados.

### Execução do Contêiner - Subindo a aplicação

```bash
  docker compose up
```

Para liberar o terminal e parar o serviço pressione `CTRL + C`.

Ou caso deseje subir o contêiner em background, ou seja, sem travar o terminal, execute o seguinte comando:

```bash
  docker compose up -d
```

Para verificar se aplicação está sendo executada, utilize o comando `docker compose ps` que lista os serviços docker rodando na sua maquina. O retorno deverá conter:

- **Aplicação Rails**: `projeto-final-grupo-1-raro-academy-bank-web-1`;
- **Banco de Dados PostgreSQL**: `projeto-final-grupo-1-raro-academy-bank-db-1`.

E para encerrá-la utilize o comando: `docker compose down`, não esqueça de verificar se os serviços foram encerrados com o comando `docker compose ps`.

### Acesso à Aplicação

A aplicação estará disponível no endereço [http:localhost:3000](http://localhost:3000)
