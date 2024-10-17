<style>
    /* Добавленный класс активности для выбранной категории */
    .category-link.active {
        text-decoration: underline; /* Подчеркиваем выбранную категорию */
    }

    .custom-link {
        font-size: 1.05rem; /* Размер шрифта */
        color: #333;
        text-decoration: none;
    }

    .custom-link:hover {
        text-decoration: underline; /* Подчеркивание при наведении */
    }

</style>

<script>
    // Получаем текущий путь
    var currentPath = window.location.pathname;

    // Получаем все ссылки категорий
    var categoryLinks = document.querySelectorAll('.category-link');

    // Проходим по каждой ссылке
    categoryLinks.forEach(function(link) {
        // Если текущий путь совпадает с атрибутом href этой ссылки
        if (link.getAttribute('href') === currentPath) {
            // Добавляем класс активности
            link.classList.add('active');
        }
    });
</script>

