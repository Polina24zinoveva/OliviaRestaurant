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
        .btn-custom {
            margin-bottom: 2rem;
        }

        .btn-custom2 {
            margin-bottom: 2rem;
            border-width: 2px;
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
