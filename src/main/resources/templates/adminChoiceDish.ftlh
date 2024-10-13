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
            width: 94%;
            margin-top: 10px;
            background-color: #f0eade; /* Основной цвет кнопки */
            border-color: #f0eade; /* Цвет границы кнопки */
            color: #333; /* Цвет текста кнопки */
            margin-bottom: 2rem;
        }

        .btn-custom:hover {
            color: #333; /* Цвет текста кнопки */
            background-color: #e0d8d0; /* Цвет кнопки при наведении */
            border-color: #e0d8d0; /* Цвет границы кнопки при наведении */
        }

        .btn-custom2 {
            width: 94%;
            margin-top: 10px;
            border-color: #f0eade; /* Цвет границы кнопки */
            color: #333; /* Цвет текста кнопки */
            margin-bottom: 2rem;
            border-width: 2px;
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

        input[type="checkbox"]:checked {
            background-color: gray;
            border-color: gray;
            accent-color: #000000;
        }
    </style>
</head>
<body class="d-flex flex-column h-100">
    <div class="wrapper flex-grow-1">
        <#include "blocks/header.ftlh">
        <div class="d-flex">
            <div class="container">
                <div class="row">
                    <div class="col-md-2">
                        <#include "blocks/adminMenu.ftlh">
                    </div>

                    <div class="col-md-1 vertical-line">
                    </div>

                    <div class="col-md-9">
                        <#if allDishes?size = 0>
                            <div id="emptyCartMessage" class="d-flex flex-column justify-content-center align-items-center" style="height: 94%;">
                                <h5>Нет блюд в базе</h5>
                            </div>

                        <#else>
                            <form action="/adminChoiceDish" method="post" id="dishForm">
                                <h5 style="margin-top: 10px; margin-bottom: 2rem;">Выбор блюд для добавления в меню</h5>
                                <div class="d-flex justify-content-between">
                                    <button type="button" class="btn btn-custom2" id="buttonSelectAll" name="buttonSelectAll" onclick="selectAll()">Выбрать все</button>
                                    <button type="submit" class="btn btn-custom" style="margin-left:1rem;">Выбрать</button>
                                </div>

                                <table class="table">
                                    <thead>
                                    <tr>
                                        <th></th>
                                        <th>ID</th>
                                        <th>Название</th>
                                        <th>Состав</th>
                                        <th>Калорийность</th>
                                        <th>Вес</th>
                                        <th>Цена</th>
                                        <th>Фото</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <#list allDishes as dish>
                                        <tr>
                                            <td>
                                                <input class="form-check-input" id="dish_${dish.id}" name="dishes" value="${dish.id}" type="checkbox" <#if dish.inMenu == true>checked</#if>>
                                            </td>
                                            <td>${dish.id}</td>
                                            <td>${dish.name}</td>
                                            <td>${dish.composition}</td>
                                            <td>${dish.calories}</td>
                                            <td>${dish.weight}</td>
                                            <td>${dish.price}</td>
                                            <td>
                                                <#if dish.images[0]?has_content && dish.images[0]?size gt 1>
                                                    <img src="/images/${dish.images[0].id}" alt="Фото" style="max-width: 100px; max-height: 100px;">
                                                <#else>
                                                    <!-- Здесь можно вывести какое-то сообщение или заглушку для изображения отсутствует -->
                                                </#if>

                                                <#if dish.images[1]?has_content && dish.images[1]?size gt 1>
                                                    <img src="/images/${dish.images[1].id}" alt="Фото"  style="max-width: 100px; max-height: 100px;">
                                                <#else>
                                                    <!-- Здесь можно вывести какое-то сообщение или заглушку для изображения отсутствует -->
                                                </#if>

                                                <#if dish.images[2]?has_content && dish.images[2]?size gt 1>
                                                    <img src="/images/${dish.images[2].id}" alt="Фото" style="max-width: 100px; max-height: 100px;">
                                                <#else>
                                                    <!-- Здесь можно вывести какое-то сообщение или заглушку для изображения отсутствует -->
                                                </#if>

                                            </td>
                                        </tr>
                                    </#list>
                                    </tbody>
                                </table>

                                <script>
                                    function selectAll() {
                                        // Получаем все чекбоксы с name="dishes"
                                            let checkboxes = document.querySelectorAll('input[name="dishes"]');

                                            // Проверяем текущее состояние первого чекбокса
                                            let allChecked = Array.from(checkboxes).every(checkbox => checkbox.checked);

                                            // Переключаем состояние чекбоксов
                                            checkboxes.forEach((checkbox) => {
                                                checkbox.checked = !allChecked; // Устанавливаем в true, если все были отмечены, и наоборот
                                            });



                                            let button = document.getElementsByName("buttonSelectAll")[0];
                                            button.textContent = allChecked ? "Выбрать все" : "Снять выбор";
                                    }
                                </script>
                            </form>
                        </#if>
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
