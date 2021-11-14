module.exports = {
  plugins: [
    require('@tailwindcss/typography'),
  ],
  purge: { content: ["./app/views/**/*.haml", "./app/views/**/*.erb/"] },
  theme: {},
  mode: 'jit',
  darkMode: false,
  variants: {},
}
