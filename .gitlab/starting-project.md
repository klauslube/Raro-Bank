# Documentando o inicio do projeto

Todos os passos realizados para iniciar o projeto e configurações iniciais.

### Rails new

- [x] Criar projeto com as seguintes flags:

```bash
  rails new raro-academy_bank -T -c=tailwind -d=postgresql -j=esbuild
```

### Configuração de Banco de dados

- [x] Setar config no config/database.yml:

```bash
username: <%= ENV['POSTGRES_USER'] %>
password: <%= ENV['POSTGRES_PASSWORD'] %>
host: <%= ENV['POSTGRES_HOST'] %>
```

- [x] Se quiser utilizar o docker pra subir apenas o banco de dados:

```bash
  docker run --name postgres -e POSTGRESQL_USERNAME=root -e POSTGRESQL_PASSWORD=root@123 -e POSTGRESQL_DATABASE=postgres -p 5432:5432 bitnami/postgresql:latest
```

- [x] Guardar as variáveis no arquivo `.env` na raiz do projeto:

```bash
export POSTGRES_HOST=localhost
export POSTGRES_PASSWORD=root@123
export POSTGRES_USER=root
```

### Gems

Adicionar as gems a seguir nos seus respectivos grupos:

```ruby
group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'faker'
  gem 'byebug'
  gem 'factory_bot_rails'
 gem 'htmlbeautifier'
 gem 'overcommit'
 gem 'dotenv-rails'
end

group :development do
 gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
 gem 'solargraph'
end

group :test do
  gem 'simplecov'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
end
```

- [x] **Rspec**

  ```ruby
    # instalar rspec
    bin/rails generate rspec:install
    # preparar banco de dados de teste
    bin/rails db:migrate db:test:prepare
    # gerar base de testes para algum model especifico
    bin/rails generate rspec:model State
  ```

- [x] **Overcommit** \*\*\*\*

  ```ruby
  # instalar gem no ambiente de dev
  gem install overcommit
  # instalar gem no projeto
  overcommit --install
  # setar overcommit com as configurações do arquivo overcommit.yml
  overcommit --sign
  ```

  ```ruby
  PreCommit:
    RuboCop:
      enabled: true
      on_warn: fail # Treat all warnings as failures
      problem_on_unmodified_line: ignore # run RuboCop only on modified code
    RSpec:
      enabled: true
      command: ["bundle", "exec", "rspec", "spec"]
      on_warn: fail
    BundleInstall:
      enabled: true
      on_warn: fail
    CapitalizedSubject:
      enabled: false
    ForbiddenBranches:
      enabled: true
      branch_patterns: ["main"]
    TextWidth:
      enabled: true
      max_width: 80
  ```

- [x] **ShouldaMatchers** - No arquivo gerado, cole no final do arquivo `rails_helper.rb`

  ```ruby
  Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end
  ```

- [x] **Simplecov** - Adicionar ao começo do _`spec_helper.rb`_

  ```ruby
  require 'simplecov'
  SimpleCov.start
  ```

- [x] **dotenv-rails** - Adicionar o arquivo _`.env.example`_ na raiz do projeto

  ```ruby
  # Duplicar o arquivo .env.example para .env e preencher com as informações do banco de dados

  POSTGRES_HOST=localhost
  POSTGRES_PASSWORD=YOUR_PASSWORD
  POSTGRES_USER=YOUR_USER
  ```

  ```ruby
  # Adicionar ao application.rb:

  Dotenv::Railtie.load
  ```

- [x] **Factory** - Crie um arquivo: `spec/support/factory_bot.rb` com o seguinte conteúdo

  ```ruby
  # frozen_string_literal: true

  RSpec.configure do |config|
    config.include FactoryBot::Syntax::Methods
  end
  ```

  Ative o carregamento automático do diretório de support descomentando a seguinte linha em seu `spec/rails_helper.rb`:

  ```ruby
  Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
  ```

- [x] **htmlbeautifier** - instalar extensão do vscode **ERB Formatter/Beautify**
      no json de configuração do vscode colar:

  ```ruby
  "[erb]": {
    "editor.defaultFormatter": "aliariff.vscode-erb-beautify",
    "editor.formatOnSave": true
  },
  "files.associations": {
    "*.html.erb": "erb"
  }
  ```

  É interessante instalar globalmente também `gem install htmlbeautifier`.

- [x] **Rubocop** - Na raiz do projeto crie um arquivo `.rubocop.yml` com o seguinte conteúdo:

  ```ruby
  require:
    - rubocop-rails
    - rubocop-rspec

  AllCops:
    NewCops: enable
    Exclude:
      - "spec/**/*_spec.rb"
      - "test/**/*"
      - "db/schema.rb"
      - "db/migrate/*"
      - "config/**/*"
      - "bin/*"
      - "vendor/*"
      - "node_modules/*"
      - "tmp/*"
      - "log/*"
      - "coverage/*"
      - "config/initializers/*"
      - "config/environments/*"
      - "config/application.rb"
      - "**/spec/fixtures/*"
    TargetRubyVersion: 3.1.2

  Style/FrozenStringLiteralComment:
    Enabled: false

  Style/Documentation:
    Enabled: false

  RSpec/MultipleExpectations:
    Enabled: false

  Layout/LineLength:
    Enabled: false

  Rails/OutputSafety:
    Enabled: false

  Rails/I18nLocaleTexts:
    Enabled: false

  Metrics/MethodLength:
    Max: 50

  Rails/FilePath:
    Exclude:
      - "spec/rails_helper.rb"
  ```

  ```ruby
  # para executar as correções do rubocop
  rubocop -A
  ```

### Dependências Javascript

Adicionar ao package.json na lista de dependências os forms do tailwind

```json
  "@tailwindcss/forms": "^0.5.3",
```

### Start do projeto

Executar

```ruby
# instalar dependecias do ruby
bundle install
./bin/setup
# criar/rodar migrations/gerar seed do bd
rails db:create
rails db:migrate
rails db:seed
# instalar dependencias de javascript
# iniciar servidor
./bin/dev
```
