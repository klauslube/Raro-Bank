module.exports = {
  content: [
    "./app/views/**/*.html.erb",
    "./app/helpers/**/*.rb",
    "./app/assets/stylesheets/**/*.css",
    "./app/javascript/**/*.js",
    "./node_modules/flowbite/**/*.js",
  ],
  plugins: [require("flowbite/plugin"), require("@tailwindcss/forms")],
  theme: {
    colors: {
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
    },
  },
};
