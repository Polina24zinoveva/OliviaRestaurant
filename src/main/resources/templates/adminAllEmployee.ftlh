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
        select.search-select  {
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

                        <h5 style="margin-top: 10px; margin-bottom: 2rem;">
                            <a href="/adminAllEmployee" style="text-decoration: none; color: inherit;">Сотрудники</a>
                        </h5>


                        <h6 style="margin-top: 1rem; margin-bottom: 1rem;">Поиск</h6>
                        <form class="d-flex mb-3" method="GET" action="/adminAllEmployee">
                            <div class="input-group">
                                <!-- Выпадающий список -->
                                <select name="searchField" class="form-select search-select" style="max-width: 150px; max-height:40px;">
                                    <option value="id" <#if searchField=="id">selected</#if> >ID</option>
                                    <option value="name" <#if searchField=="name">selected</#if>>Имя</option>
                                    <option value="surname" <#if searchField=="surname">selected</#if>>Фамилия</option>
                                    <option value="nameAndSurname" <#if searchField=="nameAndSurname">selected</#if>>Имя и фамилия</option>
                                    <option value="phoneNumber" <#if searchField=="phoneNumber">selected</#if>>Номер телефона</option>
                                    <option value="email" <#if searchField=="email">selected</#if>>Эл. почта</option>
                                </select>

                                <!-- Поле для ввода текста -->
                                <input type="text" name="searchQuery" class="form-control" style="max-height:40px;" placeholder="${searchQuery}">

                                <!-- Кнопка для поиска -->
                                <button type="submit" class="btn btn-custom" style="max-width: 150px; max-height:40px; margin-top: 0px;">Найти</button>
                            </div>
                        </form>

                        <h6 style="margin-top: 1rem; margin-bottom: 1rem;">Фильтрация</h6>

                        <form action="/adminAllEmployee" method="get">
                            <select name="role" class="form-select" onchange="this.form.submit()">
                                <option value="all" <#if role == "all">selected</#if>>Все сотрудники</option>
                                <option value="ROLE_MANAGER" <#if role == "ROLE_MANAGER">selected</#if>>Менеджеры</option>
                                <option value="ROLE_COURIER" <#if role == "ROLE_COURIER">selected</#if>>Курьеры</option>
                            </select>
                        </form>

                        <div class="horizontal-line" style="margin-top:2rem;"></div> <!-- Горизонтальная линия -->

                        <#if allEmployee?size = 0>
                            <div id="emptyCartMessage" class="d-flex flex-column justify-content-center align-items-center" style="height: 94%;">
                                <h5>Нет сотрудников в базе</h5>
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
                                    <th>Должность</th>
                                </tr>
                                </thead>
                                <tbody>
                                <#list allEmployee as employee>
                                    <tr>
                                        <td>${employee.id}</td>
                                        <td>${employee.name}</td>
                                        <td>${employee.surname}</td>
                                        <td>${employee.phoneNumber}</td>
                                        <td>${employee.email}</td>
                                        <td>
                                            <#if employee.role == "ROLE_MANAGER">Менеджер</#if>
                                            <#if employee.role == "ROLE_COURIER">Курьер</#if>
                                        </td>
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
