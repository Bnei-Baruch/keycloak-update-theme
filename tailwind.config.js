/** @type {import('tailwindcss').Config} */
module.exports = {
    content: ["./customs/**/*.{html,js,ftl}"],
    theme: {
        extend: {},
    },
    plugins: [require('@tailwindcss/forms')],
}