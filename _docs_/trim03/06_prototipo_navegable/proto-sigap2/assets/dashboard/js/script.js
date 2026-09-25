document.getElementById('form-login').addEventListener('submit', function (e) {
    e.preventDefault();
    window.location.hash = 'dashboard';
});