<!DOCTYPE html>
<html lang="ru">

<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css">
    <link rel="icon" href="icon_logo.png" type="image/x-icon">
    <title>Заказы</title>

    <script>
        function showDateTimeDeliverySelect() {
            if (document.getElementById("earliest").selected) {
                document.getElementById("dateTimeDeliveryContainer").style.display = "none"
            } else {
                document.getElementById("dateTimeDeliveryContainer").style.display = "block"
            }
        }

        function showaddress() {
            if (document.getElementById("nodelivery").selected) {
                document.getElementById("addressDelivery").style.display = "none"
            } else {
                document.getElementById("addressDelivery").style.display = "block"
            }
        }

        function setTime(){
            const datra = document.getElementById("dateDelivery").value;
            const dater = new Date(datra);
            const PBY = new Date();
            const tdy = new Date(PBY.getFullYear(), PBY.getMonth(), PBY.getDate());
            const PBJ = new Date(dater.getFullYear(), dater.getMonth(), dater.getDate());
            console.log("Today's date:", tdy.getTime());
            console.log("Input date:", PBJ.getTime());
            var select = document.getElementById("timeDelivery");

            if(tdy.getTime() == PBJ.getTime()){
                console.log("Равенство работает");

                PBY.setMinutes(PBY.getMinutes() + 59);

                // Обновляем часы и минуты после добавления
                curhour = PBY.getHours();
                curminute = PBY.getMinutes();

                console.log("Часы:", curhour, "Минуты:", curminute);

                for (var i = 0; i < select.length; i++){

                    var timesel = select.options[i].text;
                    var timeParts = timesel.split(':');
                    var optionHour = parseInt(timeParts[0]);
                    var optionMinute = parseInt(timeParts[1]);

                    // Сравниваем текущее время с временем опции
                    if(optionHour < curhour || (optionHour === curhour && optionMinute <= curminute)){
                        select.options[i].style.display = 'none';
                    } else {
                        select.options[i].style.display = 'list-item';
                    }
                }

                // Устанавливаем первое доступное значение
                for(var i = 0; i < select.length; i++){
                    if(select.options[i].style.display !== 'none'){
                        console.log("wawa", select.options[i].text);
                        select.value = select.options[i].value;
                        break;
                    }
                }

            } else {
                // Если дата не сегодняшняя, показываем все опции
                for (var i = 0; i < select.length; i++){
                    select.options[i].style.display = 'list-item';
                }
                select.value = select.options[0].value;
            }

            // Обновление текстового поля с датой
            const parts = datra.split('-');
            const formattedDate = parts[2] + '.' + parts[1] + '.' + parts[0];
            document.getElementById("dateDisplay").value = formattedDate;
        }



        function validateForm() {
            var addressDelivery = document.getElementById("addressDelivery").value;
            var dateDelivery = document.getElementById("dateDelivery").value;
            var timeDelivery = document.getElementById("timeDelivery").value;

            if (addressDelivery === "" || dateDelivery === "" || timeDelivery === "") {
                alert("Пожалуйста, заполните все обязательные поля.");
                return false;
            }
        }

        document.addEventListener('DOMContentLoaded', function () {
            var carousel = document.getElementById("postcardCarousel");

            carousel.addEventListener('slid.bs.carousel', function (event) {
                var activeImage = carousel.querySelector('.carousel-item.active img');
                var postcardId = activeImage.getAttribute('data-postcard-id');
                document.getElementById("postcardId").value = postcardId;
            });
        });
    </script>

    <style>
        h5 {
            text-align: right;
        }

        .container-fluid,
        .navbar-custom,
        .image-container{
            background-color: #f0eade;
        }

        th {
            font-weight: 500; /* Жирность шрифта */
        }

        table {
            background-color: transparent; /* установите цвет фона, который вам нужен */
        }

        .btn-custom {
            margin-top: 10px;
            background-color: #f0eade;
            border-color: #f0eade;
            color: #333;
            width: 100%;
        }

        .btn-custom:hover {
            background-color: #ffffff;
            border-color: #f0eade;
        }

        .card-link {
            margin-bottom: .75rem; /* Отступ снизу */
            font-size: 1rem; /* Размер шрифта */
            color: black;
            text-decoration: none;
            font-weight: 500; /* Жирность шрифта */
        }

        .photo {
            margin-top: 10px; /* Отступ сверху */
            margin-bottom: 10px; /* Отступ снизу */
            border-radius: 10px;
        }

        /* Для футера внизу страницы: html, body, wrapper*/
        html, body {
            height: 100%;
        }

        .wrapper {
            flex-grow: 1;
            padding-bottom: 3rem; /* Добавление отступа снизу */
        }

        /* Chrome, Safari, Edge, Opera */
        input::-webkit-outer-spin-button,
        input::-webkit-inner-spin-button {
          -webkit-appearance: none;
          margin: 0;
        }

        /* Firefox */
        input[type=number] {
          -moz-appearance: textfield;
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

        #emptyCartMessage {
            flex-direction: column; /* Отображаем дочерние элементы в столбце */
            justify-content: center; /* Выравниваем элементы по вертикали */
            align-items: center; /* Выравниваем элементы по горизонтали */
        }

        input[type="date"]::-webkit-calendar-picker-indicator {
            position: absolute;
        }


        input::-webkit-datetime-edit-fields-wrapper {
            display:none;
        }


    </style>
</head>

<body class="d-flex flex-column h-100">
    <div class="wrapper flex-grow-1">
        <#include "blocks/header.ftlh">

        <div class="container mt-5">
            <div class="row">
                <div class="col-md-7">
                    <#if dishes?size = 0>
                        <div id="emptyCartMessage" class="d-flex flex-column justify-content-center align-items-center" style="height: 94%;">
                            <h4>Ваша корзина пуста</h4>
                        </div>
                    <#else>
                        <#assign x = 0>
                        <h4>Корзина:</h4>
                        <table class="table">
                            <thead>
                                <tr>
                                    <th></th>
                                    <th></th>
                                    <th>Цена</th>
                                    <th>Количество</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <#list dishes as dish>
                                    <tr>
                                        <td>
                                            <#if dish.images?has_content>
                                                <img src="/images/${dish.images[0].id}" class="d-block w-100 photo" alt="Фото" style="max-width: 8rem;">
                                            </#if>
                                        </td>

                                        <td style="vertical-align: middle; text-align: center;">
                                            <a href="/dish/${dish.id}" class="card-link">${dish.name}</a>
                                        </td>

                                        <td style="vertical-align: middle; text-align: center;">${dish.price}</td>


                                        <td style="vertical-align: middle; text-align: center;">
                                            <form action="/changeDishCount/${dish.id}" method="post" >
                                                <div class="input-group input-group-sm" style="max-width: 5rem;">
                                                    <button class="btn btn-outline-secondary" type="submit" id="decreaseButton_${dish.id}" onclick="this.parentNode.querySelector('input[type=number]').stepDown()">-</button>
                                                    <input type="number" id="count" name="count" style="text-align: center;" readonly class="form-control form-control-sm" size="1" min="1" max="50" value="${amounts[x]}">
                                                    <button class="btn btn-outline-secondary" type="submit" id="increaseButton_${dish.id}" onclick="this.parentNode.querySelector('input[type=number]').stepUp()">+</button>
                                                </div>
                                            </form>
                                        </td>

                                        <script>
                                            function validateDishCount() {
                                                const dishInputs = document.querySelectorAll('input[name="count"]');
                                                let totalDishes = 0;

                                                dishInputs.forEach(input => {
                                                    totalDishes += parseInt(input.value, 10);
                                                });

                                                if (totalDishes > 50) {
                                                    alert("Общее количество блюд в заказе не должно превышать 50.");
                                                    return false;
                                                }
                                                return true;
                                            }

                                            // Добавление к существующей функции валидации
                                            function validateForm() {
                                                if (!validateDishCount()) {
                                                    return false;
                                                }

                                                var addressDelivery = document.getElementById("addressDelivery").value;
                                                var dateDelivery = document.getElementById("dateDelivery").value;
                                                var timeDelivery = document.getElementById("timeDelivery").value;

                                                if (addressDelivery === "" || dateDelivery === "" || timeDelivery === "") {
                                                    alert("Пожалуйста, заполните все обязательные поля.");
                                                    return false;
                                                }

                                                return true;
                                            }
                                        </script>



                                        <td style="vertical-align: middle; text-align: center;">
                                            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
                                                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
                                                crossorigin="anonymous"></script>
                                            <form action="/deleteDishFromOrder/${dish.id}" method="post" id="deleteForm_${dish.id}">
                                                <button type="button" class="btn btn-custom" onclick="confirmDelete('${dish.id}', this.closest('form'))">Удалить</button>
                                            </form>

                                            <script>
                                                function confirmDelete(dishId, formElement) {
                                                    event.preventDefault(); // Предотвращаем стандартное действие (отправка формы)

                                                    Swal.fire({
                                                        title: 'Вы уверены?',
                                                        text: 'Это блюдо будет удалено из заказа.',
                                                        icon: 'warning',
                                                        showCancelButton: true,
                                                        confirmButtonText: 'Удалить',
                                                        confirmButtonColor: '#333',
                                                        cancelButtonText: 'Отмена',
                                                        cancelButtonColor: '#999',
                                                        reverseButtons: true
                                                    }).then((result) => {
                                                        if (result.isConfirmed) {
                                                            formElement.submit();
                                                        }
                                                    });
                                                }
                                            </script>
                                        </td>

                                    </tr>
                                    <#assign x = x + 1>
                                </#list>

                            </tbody>
                        </table>
                    </#if>
                </div>

                <div class="col-md-1 vertical-line">
                </div>

                <div class="col-md-4">
                    <#if dishes?size != 0>
                        <h4 class="text-start">Заказ:</h4>
                        <br>
                        <form action="/orderCheckout" method="post" onsubmit="return validateForm()">
                            <hr>

                            <div class="row">
                                <div class="col-6">
                                    <p>${countDishesInOrderString}</p>
                                </div>
                                <div class="col-6">
                                    <p class="text-end">${order.totalPrice} руб.</p>
                                </div>
                            </div>

                            <hr>

                            <div class="row">
                                <div class="col-6">
                                    <h5 class="text-start">Сумма заказа:</h5>
                                </div>
                                <div class="col-6">
                                    <h5 class="text-end">${order.totalPrice} руб.</h5>
                                </div>
                            </div>

                            <br><br>
                            <div class="">
                                <div class="row">

                                    <div class="col-12 mb-3">
                                        <div class="form-group" id="addressDelivery">
                                            <h6 class="text-start">Адрес доставки</h6>
                                            <input class="form-control" name="addressDelivery" id="addressDelivery"
                                                placeholder="Улица, дом, квартира" required minlength="10" maxlength="50">
                                        </div>
                                    </div>

                                    <div class="col-12 mb-3">
                                        <div class="form-group">
                                            <h6 class="text-start">Дата доставки</h6>
                                            <div style="display:flex;">
                                                <input type="date" class="form-control" style="width:48px" id="dateDelivery" name="dateDelivery" min="${minDate}" max="${maxDate}" onchange="setTime()" required>
                                                <input type="text" class="form-control" id="dateDisplay" readonly style="margin-left:4px">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-12 mb-3">
                                        <h6 for="dateTimeDelivery" class="form-label">Время доставки:</h6>
                                        <select name="timeDelivery" id="timeDelivery" class="form-control">
                                            <option value="11:00">11:00</option>
                                            <option value="11:30">11:30</option>
                                            <option value="12:00">12:00</option>
                                            <option value="12:30">12:30</option>
                                            <option value="13:00">13:00</option>
                                            <option value="13:30">13:30</option>
                                            <option value="14:00">14:00</option>
                                            <option value="14:30">14:30</option>
                                            <option value="15:00">15:00</option>
                                            <option value="15:30">15:30</option>
                                            <option value="16:00">16:00</option>
                                            <option value="16:30">16:30</option>
                                            <option value="17:00">17:00</option>
                                            <option value="17:30">17:30</option>
                                            <option value="18:00">18:00</option>
                                            <option value="18:30">18:30</option>
                                            <option value="19:00">19:00</option>
                                            <option value="19:30">19:30</option>
                                            <option value="20:00">20:00</option>
                                            <option value="20:30">20:30</option>
                                            <option value="21:00">21:00</option>
                                            <option value="21:30">21:30</option>
                                            <option value="22:00">22:00</option>
                                            <option value="22:30">22:30</option>
                                            <option value="23:00">23:00</option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="d-flex justify-content-center">
                                <button type="submit" class="btn btn-custom">Оформить заказ</button>
                            </div>
                        </form>
                    <#else>
                        <h4 class="text-start">Заказ:</h4>
                        <br>
                        <div class="row">
                            <div class="col-6">
                                <p>0 блюд</p>
                            </div>
                            <div class="col-6">
                                <p class="text-end">0 руб.</p>
                            </div>
                        </div>

                        <hr>

                        <div class="row">
                            <div class="col-6">
                                <h5 class="text-start">Сумма заказа:</h5>
                            </div>
                            <div class="col-6">
                                <h5 class="text-end">0 руб.</h5>
                            </div>
                        </div>

                    </#if>
                </div>
            </div>
        </div>
    </div>
    <#include "blocks/alert.ftlh">
    <footer class="footer mt-auto">
        <#include "blocks/footer.ftlh">
    </footer>
</body>
</html>