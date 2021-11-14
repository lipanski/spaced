module.exports = {
  plugins: [
    require('@tailwindcss/typography'),
  ],
  purge: { content: ["./app/views/**/*.erb/"] },
  theme: {},
  mode: 'jit',
  darkMode: false,
  variants: {},
}
