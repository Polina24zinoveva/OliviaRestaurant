<!DOCTYPE html>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="icon" href="icon_logo.png" type="image/x-icon">

    <title>
    <title>
        Администратор
    </title>

    <script>
        function request (id){

        }

    </script>

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
                        <#if allEmployee?size = 0>
                            <div id="emptyCartMessage" class="d-flex flex-column justify-content-center align-items-center" style="height: 94%;">
                                <h5>Нет сотрудников в базе</h5>
                            </div>

                        <#else>
                            <h5 style="margin-top: 10px; margin-bottom: 2rem;">Сотрудники</h5>

                            <form action="/adminAllEmployee" method="get">
                                <select name="role" class="form-select" onchange="this.form.submit()">
                                    <option value="all" <#if role == "all">selected</#if>>Все сотрудники</option>
                                    <option value="ROLE_MANAGER" <#if role == "ROLE_MANAGER">selected</#if>>Менеджеры</option>
                                    <option value="ROLE_COURIER" <#if role == "ROLE_COURIER">selected</#if>>Курьеры</option>
                                </select>
                            </form>


                            <br>

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
