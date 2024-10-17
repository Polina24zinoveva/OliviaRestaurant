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
                        <#if toDeliverOrders?size = 0>
                            <div id="emptyCartMessage" class="d-flex flex-column justify-content-center align-items-center" style="height: 94%;">
                                <h5>Нет активных заказов</h5>
                            </div>

                        <#else>
                            <h5 style="margin-top: 10px; margin-bottom: 2rem;">Заказы к доставке</h5>
                            <#assign x = 0>
                            <#list toDeliverOrders as order>
                                <div class="row mb-4">
                                    <div class="col-12">
                                        <div class="row">
                                            <div class="d-flex align-items-baseline">
                                                <h5>Заказ №${order.id}. Доставка: ${datesDelivery[x]} к ${order.timeDelivery!},  ${order.address}</h5>
                                                <div>
                                                    <p class="text-center"
                                                        style="display: flex;
                                                            justify-content: center;
                                                            align-items: center;
                                                            background: #f0eade;
                                                            border-radius: 5px;
                                                            width: 120px;
                                                            height: 38px;
                                                            margin-left: 1rem;">
                                                        <#if order.status=="STATUS_PAID">Оплачен
                                                        <#else><#if order.status=="STATUS_IN_DELIVERY">В пути</#if>
                                                        </#if>
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row"  style="margin-top: 1rem;">
                                            <div class="col-7">
                                                <h6>Товары в заказе:</h6>
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
                                                    <#assign y++>
                                                </#list>
                                            </div>

                                            <div class="col-md-1 vertical-line">
                                            </div>

                                            <div class="col-4">
                                                <h6>Доставка по адресу:</h6>
                                                <p>${order.address}</p>
                                                <h6>Дата доставки:</h6>
                                                <p>${datesDelivery[x]}</p>
                                                <h6>Время доставки:</h6>
                                                <p>${order.timeDelivery!}</p>
                                                <h6>Id покупателя:</h6>
                                                <p>${order.user.id}</p>
                                                <h6>Контактный номер:</h6>
                                                <p>${order.user.phoneNumber!}</p>
                                                <h6>Сумма заказа:</h6>
                                                <p>${order.totalPrice} ₽</p>
                                                <h6>Дата оплаты:</h6>
                                                <p>${datesTimePayment[x]}</p>
                                                <h6>Курьер:</h6>
                                                <#if order.courier??>
                                                    <p>${order.courier.surname!} ${order.courier.name!}</p>
                                                <#else>
                                                    <p>Курьер не назначен</p>
                                                </#if>
                                            </div>
                                            <#assign x++>
                                        </div>
                                        <div class="horizontal-line"></div> <!-- Горизонтальная линия -->
                                    </div>
                                </div>
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
