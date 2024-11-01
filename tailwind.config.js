/** @type {import('tailwindcss').Config} */
module.exports = {
    content: ["./potluck-warzone/**/*.{html,js,ftl}"],
    theme: {
        extend: {},
    },
    plugins: [require('@tailwindcss/forms')],
}