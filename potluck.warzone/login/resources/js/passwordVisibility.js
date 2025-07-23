document.addEventListener('DOMContentLoaded', function() {
    const passwordToggles = document.querySelectorAll('[data-password-toggle]');
    
    passwordToggles.forEach(toggle => {
        toggle.addEventListener('click', function() {
            const passwordField = document.getElementById(this.getAttribute('aria-controls'));
            const icon = this.querySelector('svg');
            const text = this.querySelector('span');
            
            if (passwordField.type === 'password') {
                // Show password
                passwordField.type = 'text';
                icon.innerHTML = '<path fill="currentColor" d="M12 4.5C7 4.5 2.73 7.61 1 12c1.73 4.39 6 7.5 11 7.5s9.27-3.11 11-7.5c-1.73-4.39-6-7.5-11-7.5zM12 17c-2.76 0-5-2.24-5-5s2.24-5 5-5 5 2.24 5 5-2.24 5-5 5zm0-8c-1.66 0-3 1.34-3 3s1.34 3 3 3 3-1.34 3-3-1.34-3-3-3z"/><path fill="currentColor" d="M2 5.27L3.28 4L21 21.72L19.73 23L2 5.27z"/>';
                if (text) {
                    text.textContent = 'Hide password';
                }
                this.setAttribute('aria-label', 'Hide password');
            } else {
                // Hide password
                passwordField.type = 'password';
                icon.innerHTML = '<path fill="currentColor" d="M12 4.5C7 4.5 2.73 7.61 1 12c1.73 4.39 6 7.5 11 7.5s9.27-3.11 11-7.5c-1.73-4.39-6-7.5-11-7.5zM12 17c-2.76 0-5-2.24-5-5s2.24-5 5-5 5 2.24 5 5-2.24 5-5 5zm0-8c-1.66 0-3 1.34-3 3s1.34 3 3 3 3-1.34 3-3-1.34-3-3-3z"/>';
                if (text) {
                    text.textContent = 'Show password';
                }
                this.setAttribute('aria-label', 'Show password');
            }
        });
    });
}); 