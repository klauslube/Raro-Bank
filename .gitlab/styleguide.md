# Instruções e documentação para as _views_

## Layouts

O projeto possui três estilos:

- Usuários não logados
- Usuários logados
- Usuários administrativos

## Cores

As cores utilizadas no projeto são:

```json
primary: {
        100: "#f4f3ff",
        200: "#dfdef8",
        300: "#b5b3e6",
        400: "#7a75d1",
        500: "#47449b",
        600: "#343090",
        700: "#2b2775",
        800: "#1f1d54",
        900: "#110f35",
      },
      secondary: {
        400: "#93ff90",
        500: "#4fff4b",
        600: "#42d73f",
      },
      abacate: {
        400: "#e9f94c",
        500: "#cbdb2c",
        600: "#b1bf21",
      },

```

Para utilizar nas classes utilitárias do Tailwind, utilizar o prefixo `text-` e o nome da cor com o número no sufixo , por exemplo:

```html
<p class="text-primary-500">Raro bank</p>
```

## Notificações

Foi utilizado o visual do [flowbite toast](https://flowbite.com/docs/components/toast/) para o estilo das notificações e para o comportamento foi utilizado o componente [Stimulus Notifications](https://www.stimulus-components.com/docs/stimulus-notification/). Foi dividido em três tipos de notificações:

- **success**: para notificações de sucesso;
- **error**: para notificações de erro;
- **form_error**: para notificações que referencia a erros de formulário.

Os erros de notice e alert foram configurados nos dois layout para utilizarem a notificação, já de erro de formulário é um pouco diferente das outras duas, pois ele precisa ser configurado no formulário, adicionando a seguinte linha:

```ruby
  # @objet é o objeto que está sendo utilizado no formulário, então precisa trocar pelo nome do objeto
  <%= render partial: 'shared/notifications/form_errors', locals: { object: @objet } %>
```

Para que fosse possível editar alguns estilos gerais, foi extraída a classe `container-notifications` para o arquivo `application.tailwind.css`. Aqui a documentação do tailwind fala um pouco mais sobre como pode ele pode ser reutilizável: [Tailwind CSS - Extracting Components](https://tailwindcss.com/docs/extracting-components).

## Ícones

Os ícones do projeto foram retirados do [heroicons](https://heroicons.com/), que é uma biblioteca de ícones open source que trabalha juntamente com o Tailwind. Pra usar:

1. Escolher o ícone desejado no site: ao passar o mouse pode ser copiado como svg;
2. Navegar para dentro da pasta `./app/assets/images/icons`, lá terá a pasta com formato do seu ícone: "solid" ou "outline";
3. Dentro dessa pasta, crie um arquivo e cole o conteúdo svg lá;
4. Salvar com seu respectivo nome e extensão `.svg'.

Foi adicionada a gem [inline-svg](https://github.com/jamesmartin/inline_svg), pois caso seja necessário, o ícone pode ser estilizado inline, utilizando as classes do Tailwind, como no exemplo abaixo:

```ruby
<%= inline_svg_tag 'icons/solid/cog-8-tooth.svg', class: 'w-6 h-6 text-red-400 hover:text-red-800' %>
```

## Fontes

As fontes utilizadas no projeto são:

- [Poppins](https://fonts.google.com/specimen/Poppins?query=poppins)
- [Titillium Web](https://fonts.google.com/specimen/Titillium+Web?query=titillium+web)

O projeto já está carregando ambas as fontes, cada uma no seu respectivo layout. Mas para utilizar as fontes de forma isolada (caso venha a ser necessário) nas classes utilitárias do Tailwind, utilizar o prefixo `font-` e o nome da fonte, por exemplo:

```html
<p class="font-admin">Raro bank Administrativo</p>
<p class="font-app">Raro bank</p>
```
