<!DOCTYPE html>
<html xmlns:border="http://www.w3.org/1999/xhtml" xmlns:padding="http://www.w3.org/1999/xhtml"
      xmlns:border-radius="http://www.w3.org/1999/xhtml">
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="icon" href="icon_logo.png" type="image/x-icon">
    <title>Мой профиль</title>
    <style>
        body {
                background-color: #f0eade; /* Устанавливаем фоновый цвет для всего документа */
            }
            .container-fluid, .navbar-custom, .image-container {
                background-color: #f0eade; /* Также устанавливаем фоновый цвет для других контейнеров или элементов при необходимости */
            }
        .container-fluid, .navbar-custom, .image-container {
            background-color: #f0eade;
        }
        .border {
            border: 2px solid #f0eade;
            border-radius: 10px;
            max-width: 500px;
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
            padding-top: 2rem;
            padding-bottom: 1rem;
        }
        .image {
            border-radius: 10px;
            margin: auto;
        }
        .text {
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
            background-color: #e0d8d0; /* Цвет кнопки при наведении */
            border-color: #e0d8d0; /* Цвет границы кнопки при наведении */
        }
        .btn-custom2 {
            width: 94%;
            margin-top: 10px;
            background-color: #f0eade;
            border-color: #f0eade;
            color: #333;
        }
        .btn-custom2:hover {
            color: #333;
            background-color: #e0d8d0;
            border-color: #e0d8d0;
        }
        .mt-4 {
            margin-top: 1.5rem; /* 4 * 0.25rem (base spacing unit) */
        }
        table th, table td {
            text-align: center;
        }
        html,
        body {
            height: 100%;
        }

        .wrapper {
            min-height: 100%;
            height: auto !important;
            height: 100%;
            margin: 0 auto -4em;
            flex: 1;
        }

        .footer,
        .push {
            height: 4em;
        }
    </style>
</head>
<body>
    <div class="wrapper">
        <#if isAdmin?? && isAdmin == true>
            <#include "blocks/headerAdmin.ftlh">
        <#else>
            <#include "blocks/header.ftlh">
        </#if>

        <div class="container-fluid">
            <div class="row">
                <div class="col-md-3 d-flex flex-column align-items-center">
                    <img src="user.jpg" alt="Фото пользователя" class="img-thumbnail mb-3" style="max-width: 100px; max-height: 100px;">
                    <h3 class="mb-3">${currentUser.name} ${currentUser.surname}</h3>
                    <nav class="nav flex-column">
                        <a href="/info" class="btn btn-custom2">Информация о пользователе</a>
                        <a href="/profile" class="btn btn-custom2">Избранные букеты</a>
                        <form action="/logout" method="post style="border: 2px solid #000000; padding: 5px; border-radius: 5px;">
                        <button type="submit" class="btn btn-custom2">Выйти</button>
                        </form>
                    </nav>
                </div>
                <div class="col-md-9 mt-4">
                    <h4>Информация о пользователе</h4>
                    <table class="table">
                        <tbody>
                            <tr>
                                <th>Имя</th>
                                <td>${currentUser.name}</td>
                            </tr>
                            <tr>
                                <th>Фамилия</th>
                                <td>${currentUser.surname}</td>
                            </tr>
                            <tr>
                                <th>Email</th>
                                <td>${currentUser.email}</td>
                            </tr>
                            <tr>
                                <th>Номер телефона</th>
                                <td>${currentUser.phoneNumber}</td>
                            </tr>
                            <tr>
                                <th>Дата рождения</th>
                                <td>${currentUser.dateOfBirthday!"N/A"}</td>
                            </tr>
                        </tbody>
                    </table>
                    <!-- Edit Form -->
                    <h4>Редактировать информацию</h4>
                    <form action="/info/update" method="post">
                        <div class="mb-3">
                            <label for="name" class="form-label">Имя</label>
                            <input type="text" class="form-control" id="name" name="name" value="${currentUser.name}" required>
                        </div>
                        <div class="mb-3">
                            <label for="surname" class="form-label">Фамилия</label>
                            <input type="text" class="form-control" id="surname" name="surname" value="${currentUser.surname}" required>
                        </div>
                        <button type="submit" class="btn btn-custom">Сохранить</button>
                    </form>
                </div>
            </div>
        </div>


        <div class="push"></div>
        <footer class="footer">
            <#include "blocks/footer.ftlh">
        </footer>
    </div>
</body>
</html>

