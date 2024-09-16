<!DOCTYPE html>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="icon" href="icon_logo.png" type="image/x-icon">

    <title>
        Администратор
    </title>

    <script>
        function showMessage(message) {
            alert(message);
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
                        <#if toDeliverOrders?size = 0>
                            <div id="emptyCartMessage" class="d-flex flex-column justify-content-center align-items-center" style="height: 94%;">
                                <h5>Нет отмененных заказов</h5>
                            </div>

                        <#else>
                            <h5 style="margin-top: 10px; margin-bottom: 2rem;">Доставленные заказы</h5>
                            <#assign x = 0>
                            <#list toDeliverOrders as order>
                                <div class="row">
                                    <div class="col d-flex align-items-center justify-content-between">
                                        <h5>Заказ №${order.id} от ${order.dateTimePayment}</h5>
                                        <div class="d-flex align-items-center">
                                            <p class="mb-0 me-2">оплачено</p>
                                            <h5 class="mb-0">${order.totalPrice} ₽</h5>
                                        </div>
                                    </div>
                                </div>



                                <div style="margin-top: 2rem;">
                                    <div class="d-flex">
                                        <div class="flex-fill">
                                            <h6>Доставка по адресу:</h6>
                                            <p>${order.address}</p>
                                        </div>
                                        <div class="flex-fill">
                                            <h6>Дата доставки:</h6>
                                            <p>${order.dateDelivery}</p>
                                        </div>
                                        <div class="flex-fill">
                                            <h6>Время доставки:</h6>
                                            <p>${order.timeDelivery!}</p>
                                        </div>
                                        <div class="flex-fill">
                                            <h6>Id покупателя:</h6>
                                            <p>${order.user.id}</p>
                                        </div>
                                        <div class="flex-fill">
                                            <h6>Контактный номер:</h6>
                                            <p>${order.user.phoneNumber!}</p>
                                        </div>
                                    </div>
                                </div>


                                <button id="toggleButton_${order.id}" class="btn btn-custom" style="max-width: 200px;  margin-bottom: 1rem;" onclick="showOrder(${order.id})">Товары в заказе</button>

                                <div id="orderItemsDiv_${order.id}" style="display:none;" >
                                    <br>
                                    <#assign y = 0>
                                    <#list toDeliverDishes[x] as dish>
                                        <div class="row" style="width: 36rem;">
                                            <div class="col-md-3" style="margin-bottom: 1rem;">
                                                <#if dish.images[0]?has_content && dish.images[0]?size gt 1>
                                                    <img src="/images/${dish.images[0].id}" alt="Фото" class="image" style="max-width: 6rem; max-height: 6rem;" class="me-2">
                                                <#else>
                                                    <!-- Здесь можно вывести какое-то сообщение или заглушку для изображения отсутствует -->
                                                </#if>
                                            </div>
                                            <div class="col-md-3">
                                                <a href="/dish/${dish.id}" class="custom-link me-auto">${dish.name}</a>
                                            </div>
                                            <div class="col-md-3">
                                                ${toDeliverAmounts[x][y]} шт
                                            </div>
                                            <div class="col-md-3">
                                                ${dish.price} ₽
                                            </div>
                                        </div>
                                    </#list>
                                    <#assign y++>
                                    <#assign x++>
                                </div>
                                <div class="horizontal-line"></div> <!-- Горизонтальная линия -->
                                <script>
                                    function showOrder(orderId) {
                                        var orderItemsDiv = document.getElementById("orderItemsDiv_" + orderId);
                                        if (orderItemsDiv.style.display === "none") {
                                            orderItemsDiv.style.display = "block";
                                        } else {
                                            orderItemsDiv.style.display = "none";
                                        }
                                    }
                                </script>
                            </#list>
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
