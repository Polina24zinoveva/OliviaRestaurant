<!DOCTYPE html>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="icon" href="icon_logo.png" type="image/x-icon">

    <title>
        Администратор
    </title>

    <script>
        function request (id){

        }

    </script>

    <style>
        select.form-select {
            background-color: #eeeeee; /* Цвет фона */
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


                        <h5 style="margin-top: 10px; margin-bottom: 2rem;">Пользователи</h5>

                        <h6 style="margin-top: 1rem; margin-bottom: 1rem;">Поиск</h6>
                        <form class="d-flex mb-3" method="GET" action="/adminAllUsers">
                            <div class="input-group">
                                <!-- Выпадающий список -->
                                <select name="searchField" class="form-select" style="max-width: 150px; max-height:40px;">
                                    <option value="id">ID</option>
                                    <option value="name">Имя</option>
                                    <option value="surname">Фамилия</option>
                                    <option value="nameAndSurname">Имя и фамилия</option>
                                    <option value="phoneNumber">Номер телефона</option>
                                    <option value="email">Эл. почта</option>
                                </select>

                                <!-- Поле для ввода текста -->
                                <input type="text" name="searchQuery" class="form-control" style="max-height:40px;" placeholder="${searchQuery}">

                                <!-- Кнопка для поиска -->
                                <button type="submit" class="btn btn-custom" style="max-width: 150px; max-height:40px; margin-top: 0px;">Найти</button>
                            </div>
                        </form>


                        <div class="horizontal-line" style="margin-top:2rem;"></div> <!-- Горизонтальная линия -->

                        <#if allUsers?size = 0>
                            <div id="emptyCartMessage" class="d-flex flex-column justify-content-center align-items-center" style="height: 94%;">
                                <h5>Нет пользователей в базе</h5>
                            </div>

                        <#else>

                            <table class="table">
                                <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Имя</th>
                                    <th>Фамилия</th>
                                    <th>Номер телефона</th>
                                    <th>Эл. почта</th>
                                </tr>
                                </thead>
                                <tbody>
                                <#list allUsers as user>
                                    <tr>
                                        <td>${user.id}</td>
                                        <td>${user.name}</td>
                                        <td>${user.surname}</td>
                                        <td>${user.phoneNumber}</td>
                                        <td>${user.email}</td>
                                    </tr>
                                </#list>
                                </tbody>
                            </table>
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
