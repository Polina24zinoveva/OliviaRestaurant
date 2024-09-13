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
                        <h6 for="typeRecipient" class="form-label" style="margin-top: 1rem;">Заказы:</h6>
                        <div style="margin-left: 2rem; padding-top: 0.5rem;">
                            <p><a href="/adminorderlist" class="custom-link category-link">Активные заказы</a></p>
                            <p><a href="/adminFinishedOrderList" class="custom-link category-link">Доставленные заказы</a></p>
                            <p><a href="/adminCanceledOrderList" class="custom-link category-link">Отмененные заказы</a></p>
                        </div>
                        <h6 for="typeRecipient" class="form-label" style="margin-top: 2rem;">Букеты:</h6>
                        <div style="margin-left: 2rem; margin-right: 2rem; padding-top: 0.5rem;">
                            <p><a href="/admin" class="custom-link category-link">Все букеты</a></p>
                            <p><a href="/adminaddbouquet" class="custom-link category-link">Добавление нового букета</a></p>
                            <p><a href="/adminchoicebouquet" class="custom-link category-link">Выбор букетов на главный экран</a></p>
                        </div>
                        <h6 for="typeRecipient" class="form-label" style="margin-top: 2rem;">Открытки:</h6>
                        <div style="margin-left: 2rem; margin-right: 2rem; padding-top: 0.5rem;">
                            <p><a href="/adminpostcard" class="custom-link category-link">Открытки</a></p>
                        </div>
                        <h6 for="typeRecipient" class="form-label" style="margin-top: 2rem;">Пользователи:</h6>
                        <div style="margin-left: 2rem; margin-right: 2rem; padding-top: 0.5rem;">
                            <p><a href="/adminAllUsers" class="custom-link category-link">Пользователи</a></p>
                        </div>
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
                        <h5 style="margin-top: 10px; margin-bottom: 2rem;">Добавление букета</h5>
                        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
                        <form action="/bouquet_create" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
                            <div class="mb-3">
                                <label for="name" class="form-label">Название:</label>
                                <input type="text" id="required1" class="form-control" id="name" name="name" required>
                            </div>
                            <div class="mb-3">
                                <label for="file1" class="form-label">Первое фото:</label>
                                <input type="file" id="required2" class="form-control" id="file1" name="file1" required>
                            </div>
                            <div class="mb-3">
                                <label for="file2" class="form-label">Второе фото:</label>
                                <input type="file" class="form-control" id="file2" name="file2">
                            </div>
                            <div class="mb-3">
                                <label for="file3" class="form-label">Третье фото:</label>
                                <input type="file" class="form-control" id="file3" name="file3">
                            </div>
                            <div class="mb-3">
                                <label for="composition" class="form-label">Состав:</label>
                                <textarea class="form-control" id="composition" name="composition" rows="4" required></textarea>
                            </div>
                            <div class="mb-3">
                                <label for="price" class="form-label">Цена:</label>
                                <input type="number" id="required3" class="form-control" id="price" name="price" required>
                            </div>
                            <div class="mb-3">
                                <h6 for="type" class="form-label">Тип букета:</h6>
                                <select name="type" id="type" class="form-control">
                                    <option value="Авторский">Авторский</option>
                                    <option value="В коробке">В коробке</option>
                                    <option value="Cвадебный">Cвадебный</option>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-custom">Добавить</button>
                        </form>
                        <script>
                            function validateForm() {
                                var required1 = document.getElementById("required1").value;
                                var required2 = document.getElementById("required2").value;
                                var required3 = document.getElementById("required3").value;
                                var composition = document.getElementById("composition").value;

                                if (required1 === "" || required1 === "" || required1 === "" || composition === "") {
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
