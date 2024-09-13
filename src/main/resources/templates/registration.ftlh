<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="icon" href="icon_logo.png" type="image/x-icon">
    <title>Olivia Flowers</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <style>
        /* Стили для фона */
        .container-fluid, .navbar-custom {
            background-color: #f0eade;
        }

        /* Отступы карт */
        .mx-custom {
            margin-left: 10rem;
            margin-right: 10rem;
        }

        /* Дополнительные стили для формы */
        .form-container {
            width: 60%;
        }

        /* Стили для кнопки */
        .btn-custom {
            width: 100%;
            margin-top: 10px;
            background-color: #f0eade; /* Основной цвет кнопки */
            border-color: #f0eade; /* Цвет границы кнопки */
            color: #333; /* Цвет текста кнопки */
        }

        .btn-custom:hover {
            background-color: #e0d8d0; /* Цвет кнопки при наведении */
            border-color: #e0d8d0; /* Цвет границы кнопки при наведении */
        }

        /* Для футера внизу страницы: html, body, wrapper*/
        html, body {
            height: 100%;
        }
        .wrapper {
            flex-grow: 1;
        }
        .row-custom {
            border: 2px solid #f0eade;
            border-radius: 10px;
            width: 60rem;
            height: 35rem;
            margin-top: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1), 0px 4px 8px rgba(0, 0, 0, 0.1); /* Добавляем тень со всех сторон */

        }


    </style>
    <script>
            function showMessage(message) {
                alert(message);
            }
        </script>
</head>
<body class="d-flex flex-column h-100">
    <div class="wrapper flex-grow-1 d-flex flex-column align-items-center">
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
        <div class="row row-custom">

            <div class="col-md-6" style="background-color: #f0eade; margin-left: 0; padding-left: 0;">
                <div class="image-container">
                     <img src="../login.jpg" style="height: 28rem" alt="Logo">
                </div>
            </div>

            <div class="col-md-6  d-flex flex-column align-items-center">
                <div class="form-container">
                     <form action="/registration" method="post">
                     <br>
                     <h5 class="mt-4 text-center">Регистрация</h5>
                                        <div class="form-group">
                                            <label for="name">Имя:</label>
                                            <input type="text" class="form-control" id="name" name="name" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="surname">Фамилия:</label>
                                            <input type="text" class="form-control" id="surname" name="surname" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="email">Эл. почта:</label>
                                            <input type="email" class="form-control" id="email" name="email" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="phoneNumber">Номер телефона:</label>
                                            <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" required>
                                        </div>
                                        <script>
                                            $(document).ready(function(){
                                                Inputmask({"mask": "8 (999) 999-99-99"}).mask("#phoneNumber");
                                            });
                                        </script>
                                        <div class="form-group">
                                            <label for="password">Пароль:</label>
                                            <input type="password" class="form-control" id="password" name="password" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="dateOfBirthday">Дата рождения:</label>
                                            <input type="date" class="form-control" id="dateOfBirthday" name="dateOfBirthday" required>
                                        </div>
                                        <button type="submit" class="btn btn-primary btn-custom">Зарегистрироваться</button>
                                    </form>
                                    <div class="d-flex d-flex justify-content-between align-items-center">
                                        <p class="mb-0 me-2">Уже есть аккаунт?</p>
                                        <a href="/login" class="btn custom-link text-end" style="font-size: 1rem; margin-right: 0; padding-right: 0;">Войти</a>
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




