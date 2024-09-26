<!DOCTYPE html>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="icon" href="icon_logo.png" type="image/x-icon">

    <title>
        Администратор
    </title>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        function showMessage(message) {
            Swal.fire({
              text: message,
              icon: "success",
              confirmButtonColor: '#e0d8d0'
            });
        }
    </script>

    <script>
        function request (id){

        }

    </script>

    <style>

        .main-content {
            padding: 20px;
            border-left: 1px solid #ccc;
            margin-left: 100px;
            flex-grow: 1;
        }
        .border{
            border: 2px solid #f0eade; /* Цвет границы */
            border-radius: 10px; /* Скругление углов */
            max-width: 500px; /* Максимальная ширина карточки */
            margin-left: auto;
            margin-right: auto;
            margin-top: 4rem;
            margin-bottom: 4rem;
        }

        .form-container {
            max-width: 300px;
            margin: auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .background_color_pw {
            background-color: #f0eade;
            padding-top: 2rem;          /* padding отступ внутри блока */
            padding-bottom: 1rem;
        }


        .image{
            border-radius: 10px; /* Скругление углов */
            margin: auto;
        }

        .text{
            margin-top: 2rem;
        }

        .btn-custom {
            width: 100%;
            margin-top: 10px;
            background-color: #f0eade; /* Основной цвет кнопки */
            border-color: #f0eade; /* Цвет границы кнопки */
            color: #333; /* Цвет текста кнопки */
        }

        .btn-custom:hover {
            color: #333; /* Цвет текста кнопки */
            background-color: #e0d8d0; /* Цвет кнопки при наведении */
            border-color: #e0d8d0; /* Цвет границы кнопки при наведении */
        }

        .btn-custom2 {
            width: 94%;
            margin-top: 10px;
            background-color: #f0eade; /* Основной цвет кнопки */
            border-color: #f0eade; /* Цвет границы кнопки */
            color: #333; /* Цвет текста кнопки */
        }

        .btn-custom2:hover {
            color: #333; /* Цвет текста кнопки */
            background-color: #e0d8d0; /* Цвет кнопки при наведении */
            border-color: #e0d8d0; /* Цвет границы кнопки при наведении */
        }

        /* Для футера внизу страницы: html, body, wrapper*/
        html, body {
            height: 100%;
        }
        .wrapper {
            flex-grow: 1;
            padding-bottom: 3rem; /* Добавление отступа снизу */
        }
        .profile-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 40px;
            border-radius: 10px;
            max-width: 600px;
            margin: 20px;
        }
        .vertical-line {
            position: relative;
        }

        .vertical-line::after {
            content: "";
            position: absolute;
            top: 0;
            bottom: 0;
            left: 50%;
            border-left: 2px solid #f0eade; /* Цвет и стиль линии */
        }

        .horizontal-line {
            position: relative;
            height: 2px; /* Высота линии */
            width: 100%; /* Ширина линии */
            background-color: #f0eade; /* Цвет линии */
            margin: 1rem 0; /* Отступы сверху и снизу линии */
        }

        .container{
            margin-top: 4rem;
            margin-bottom: 4rem;
        }

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

        /* Для футера внизу страницы: html, body, wrapper*/
        html, body {
            height: 100%;
        }
        .wrapper {
            flex-grow: 1;
            padding-bottom: 3rem; /* Добавление отступа снизу */
        }
    </style>
</head>
<body class="d-flex flex-column h-100">
    <div class="wrapper flex-grow-1">
        <#if isAdmin?? && isAdmin == true>
            <#include "blocks/headerAdmin.ftlh">
        <#else>
            <#include "blocks/header.ftlh">
        </#if>

        <#if message??>
            <script>
                showMessage("${message}");
            </script>
        </#if>

        <div class="d-flex">
            <div class="container">
                <div class="row">
                    <div class="col-md-2">
                        <#include "blocks/adminMenu.ftlh">
                    </div>
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


                    <div class="col-md-1 vertical-line">
                    </div>

                    <div class="col-md-9">
                        <h5 style="margin-top: 10px; margin-bottom: 2rem;">Добавление нового блюда</h5>
                        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
                        <form action="/adminEditDish/${dish.id}" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
                            <div class="mb-3">
                                <label for="name" class="form-label">Название:</label>
                                <input type="text" id="required1" class="form-control" id="name" name="name" value="${dish.name}" required>
                            </div>
                            <div class="mb-3">
                                <label for="image" class="form-label">Текущие фото:</label>
                                <#if dish.images[0]?has_content && dish.images[0]?size gt 1>
                                    <img src="/images/${dish.images[0].id}" alt="Фото" style="max-width: 200px; max-height: 100px;">
                                <#else>
                                    <!-- Здесь можно вывести какое-то сообщение или заглушку для изображения отсутствует -->
                                </#if>

                                <#if dish.images[1]?has_content && dish.images[1]?size gt 1>
                                    <img src="/images/${dish.images[1].id}" alt="Фото"  style="max-width: 200px; max-height: 100px;">
                                <#else>
                                    <!-- Здесь можно вывести какое-то сообщение или заглушку для изображения отсутствует -->
                                </#if>

                                <#if dish.images[2]?has_content && dish.images[2]?size gt 1>
                                    <img src="/images/${dish.images[2].id}" alt="Фото" style="max-width: 200px; max-height: 100px;">
                                <#else>
                                    <!-- Здесь можно вывести какое-то сообщение или заглушку для изображения отсутствует -->
                                </#if>
                            </div>
                            <div class="mb-3">
                                <label for="composition" class="form-label">Состав:</label>
                                <textarea class="form-control" id="composition" name="composition" rows="4">${dish.composition}</textarea>
                            </div>
                            <div class="mb-3">
                                <label for="calories" class="form-label">Калорийность:</label>
                                <input type="number" id="required3" class="form-control" id="calories" name="calories" value="${dish.calories}" required>
                            </div>
                            <div class="mb-3">
                                <label for="weight" class="form-label">Вес:</label>
                                <input type="number" id="required4" class="form-control" id="weight" name="weight" value="${dish.weight}" required>
                            </div>
                            <div class="mb-3">
                                <label for="price" class="form-label">Цена:</label>
                                <input type="number" id="required5" class="form-control" id="price" name="price" value="${dish.price}" required>
                            </div>

                            <input type="hidden" id="inMenu" name="inMenu" value="${dish.inMenu?c}" required>

                            <div class="mb-3">
                                <h6 for="type" class="form-label">Тип блюда:</h6>
                                <select name="dishTypeId" id="type" class="form-control">
                                    <option value="1" <#if dish.dishType.id == 1>selected</#if>>Роллы</option>
                                    <option value="2" <#if dish.dishType.id == 2>selected</#if>>Салаты</option>
                                    <option value="3" <#if dish.dishType.id == 3>selected</#if>>Супы</option>
                                    <option value="4" <#if dish.dishType.id == 4>selected</#if>>Горячие закуски и гарниры</option>
                                    <option value="5" <#if dish.dishType.id == 5>selected</#if>>Пицца</option>
                                    <option value="6" <#if dish.dishType.id == 6>selected</#if>>Горячие блюда</option>
                                    <option value="7" <#if dish.dishType.id == 7>selected</#if>>Wok</option>
                                    <option value="8" <#if dish.dishType.id == 8>selected</#if>>Паста</option>
                                    <option value="9" <#if dish.dishType.id == 9>selected</#if>>Десерты</option>
                                    <option value="10" <#if dish.dishType.id == 10>selected</#if>>Безалкогольные напитки</option>
                                    <option value="11" <#if dish.dishType.id == 11>selected</#if>>Алкогольные напитки</option>
                                </select>
                            </div>

                            <div class="mb-3">
                                <h6 for="type" class="form-label">Тип кухни:</h6>
                                <select name="cuisineId" id="cuisine" class="form-control">
                                    <option value="1" <#if dish.cuisine.id == 1>selected</#if>>Русская</option>
                                    <option value="2" <#if dish.cuisine.id == 2>selected</#if>>Европейская</option>
                                    <option value="3" <#if dish.cuisine.id == 3>selected</#if>>Итальянская</option>
                                    <option value="4" <#if dish.cuisine.id == 4>selected</#if>>Азиатская</option>
                                </select>
                            </div>

                            <button type="submit" class="btn btn-custom">Сохранить</button>
                        </form>
                        <script>
                            function validateForm() {
                                var required1 = document.getElementById("required1").value;
                                var required2 = document.getElementById("required2").value;
                                var required3 = document.getElementById("required3").value;
                                var required4 = document.getElementById("required4").value;
                                var required5 = document.getElementById("required5").value;
                                var composition = document.getElementById("composition").value;

                                if (required1 === "" || required2 === "" || required3 === "" || required4 === "" || required5 === "" || composition === "") {
                                    alert("Пожалуйста, заполните все обязательные поля.");
                                    return false;
                                }
                            }
                        </script>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <footer class="footer mt-auto">
        <#include "blocks/footer.ftlh">
    </footer>
</body>
</html>
