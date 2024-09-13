<!DOCTYPE html>
<html lang="ru">

<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css">
    <link rel="icon" href="icon_logo.png" type="image/x-icon">
    <title>Заказы</title>

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


        function showPostcardText() {
            if (document.getElementById("noPostcard").selected) {
                document.getElementById("postcardCarousel").style.display = "none"
                document.getElementById("textPostcardContainer").style.display = "none"
            } else {
                document.getElementById("postcardCarousel").style.display = "block"
                document.getElementById("textPostcardContainer").style.display = "block"
            }
        }

        function showNumberPhone() {
            if (document.getElementById("me").selected) {
                document.getElementById("phoneNumberContainer").style.display = "none"
                document.getElementById("phoneNumber").value = "${phoneNumber}"
            } else {
                document.getElementById("phoneNumberContainer").style.display = "block"
                document.getElementById("phoneNumber").value = ""
            }
        }

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

        function timeaddresser(){
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

                var curhour = PBY.getHours();
                console.log("Часы:", curhour);
                for (var i = 0; i < select.length; i++){

                    var timesel = select.options[i].text;
                    var terer= parseInt(timesel.substring(0,2));
                    if(terer <= curhour){
                            select.options[i].style.display = 'none';
                    }
                    else {
                        select.options[i].style.display = 'list-item';
                    }

                }
                for(var i = 0; i < select.length; i++){
                    if(select.options[i].style.display !== 'none'){
                        console.log("wawa", select.options[i].text);
                        select.value = select.options[i].value;
                        break;
                    }
                }

            }else{
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

        th {
            font-weight: 500; /* Жирность шрифта */
        }

        .background_color_order {
            background-color: #ffffff;
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

        table {
            background-color: transparent; /* установите цвет фона, который вам нужен */
        }

        .btn-custom {
            width: 75%;
            margin-top: 10px;
            background-color: #f0eade;
            border-color: #f0eade;
            color: #333;
        }

        .btn-custom:hover {
            color: #333;
            background-color: #e0d8d0;
            border-color: #e0d8d0;
        }

        .btn-custom2 {
          width: 10rem;
          margin-top: 10px;
          margin-bottom: 10px;
          background-color: #ffffff; /* Основной цвет кнопки */
          border-color: #e0d8d0; /* Цвет границы кнопки */
          color: #333; /* Цвет текста кнопки */
        }

        .btn-custom2:hover {
          color: #333; /* Цвет текста кнопки */
          background-color: #e0d8d0; /* Цвет кнопки при наведении */
          border-color: #e0d8d0; /* Цвет границы кнопки при наведении */
        }

        .btn-custom-order {
            width: 100%;
            margin-top: 10px;
            background-color: #f0eade;
            border-color: #f0eade;
            color: #333;
        }

        .btn-custom-order:hover {
            color: #333;
            background-color: #e0d8d0;
            border-color: #e0d8d0;
        }


        .custom-card {
            max-width: 8rem;
            margin: auto;
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
        <#if acBouquets?size = 0>
            <div id="emptyCartMessage" class="d-flex flex-column justify-content-center align-items-center" style="height: 94%;">
                <h4>Ваша корзина пуста</h4>
            </div>
        <#else>
            <div class="container mt-5">
                <div class="row">
                    <div class="col-md-7">
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
                                <#list acBouquets as bouquet>
                                    <tr>
                                        <td>
                                            <#if bouquet.images?has_content>
                                                <img src="/images/${bouquet.images[0].id}" class="d-block w-100 photo" alt="Фото" style="max-width: 8rem;">
                                            </#if>
                                        </td>

                                        <td style="vertical-align: middle; text-align: center;">
                                            <a href="/bouquet/${bouquet.id}" class="card-link">${bouquet.name}</a>
                                        </td>

                                        <td style="vertical-align: middle; text-align: center;">${bouquet.price}</td>


                                        <td style="vertical-align: middle; text-align: center;">
                                            <form action="/order_amountchange/${bouquet.id}" method="post" >
                                                <div class="input-group input-group-sm" style="max-width: 5rem;">
                                                    <button class="btn btn-outline-secondary" type="submit" id="decreaseButton_${bouquet.id}" onclick="this.parentNode.querySelector('input[type=number]').stepDown()">-</button>
                                                    <input type="number" id="count" name="count" style="text-align: center;" class="form-control form-control-sm" size="1" min="1" max="10" value="${acAmounts[x]}">
                                                    <button class="btn btn-outline-secondary" type="submit" id="increaseButton_${bouquet.id}" onclick="this.parentNode.querySelector('input[type=number]').stepUp()">+</button>
                                                </div>
                                            </form>
                                        </td>


                                        <td style="vertical-align: middle; text-align: center;">
                                            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
                                                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
                                                crossorigin="anonymous"></script>
                                            <form action="/order_delete/${bouquet.id}" method="post">
                                                <button type="submit" class="btn btn-custom">Удалить</button>
                                            </form>
                                        </td>

                                    </tr>
                                    <#assign x = x + 1>
                                </#list>

                            </tbody>
                        </table>
                    </div>

                    <div class="col-md-1 vertical-line">
                    </div>

                    <div class="col-md-4">
                        <#if acBouquets?size != 0>
                            <h4 class="text-start">Заказ:</h4>
                            <br>
                            <form action="/order_checkout" method="post" onsubmit="return validateForm()">
                                <hr>

                                <div class="row">
                                    <div class="col-6">
                                        <p>${countBouquetsInOrderString}</p>
                                    </div>
                                    <div class="col-6">
                                        <p class="text-end">${acOrder.sumOrder} руб.</p>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-6">
                                        <p>Доставка</p>
                                    </div>
                                    <div class="col-6">
                                        <p class="text-end">${acOrder.sumDelivery} руб.</p>
                                    </div>
                                </div>

                                <hr>

                                <div class="row">
                                    <div class="col-6">
                                        <h5 class="text-start">Сумма заказа:</h5>
                                    </div>
                                    <div class="col-6">
                                        <h5 class="text-end">${acOrder.sumOrderWithDelivery} руб.</h5>
                                    </div>
                                </div>

                                <br><br>
                                <div class="">
                                    <div class="row">
                                        <#if allPostcards?? && allPostcards?size != 0>
                                            <div class="col-12 mb-3">
                                                <h6 for="typePostcard" class="form-label">Тип открытки:</h6>
                                                <select onchange = "showPostcardText()" name = "typePostcard" id = "typePostcard" class = "form-control">
                                                    <option id = "noPostcard" value = "-1">Без открытки</option>
                                                    <option value = "0">C открыткой</option>
                                                </select>
                                            </div>

                                            <div class="col-md-auto">
                                                <div id="postcardCarousel" class="carousel carousel-dark slide custom-card" style="display:none">
                                                    <div class="carousel-inner">
                                                        <#list allPostcards as postcard>
                                                            <div class="carousel-item<#if postcard_index == 0> active</#if>">
                                                                <img src="/images/${postcard.image.id}" data-postcard-id="${postcard.id}" class="d-block w-100 custom-card" alt="Фото открытки">
                                                                <input type="hidden" id="postcardId" name="dataPostcardId" value="${postcard.id}">
                                                            </div>
                                                        </#list>
                                                    </div>
                                                    <button class="carousel-control-prev" type="button" data-bs-target="#postcardCarousel" data-bs-slide="prev">
                                                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                                        <span class="visually-hidden">Previous</span>
                                                    </button>
                                                    <button class="carousel-control-next" type="button" data-bs-target="#postcardCarousel" data-bs-slide="next">
                                                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                                        <span class="visually-hidden">Next</span>
                                                    </button>
                                                </div>
                                            </div>
                                            <div class="col">
                                                <div id = "textPostcardContainer" class ="mb-3" style = "display:none">
                                                   <label for="textPostcard" class="form-label">Текст открытки:</label>
                                                   <textarea class="form-control" id="textPostcard" name="textPostcard" rows="5"></textarea>
                                                </div>
                                            </div>
                                        </#if>
                                        <div class="col-12 mb-3">
                                            <h6 for="typeRecipient" class="form-label">Получатель:</h6>
                                            <select onchange = "showNumberPhone()" name = "typeRecipient" id = "typeRecipient" class = "form-control">
                                                <option id = "me" value = "0">Я</option>
                                                <option value = "1">Другой человек</option>
                                            </select>
                                        </div>
                                        <!--для правильного формата номера телефона-->
                                        <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
                                        <script src="https://cdn.jsdelivr.net/npm/inputmask@5.0.6-beta.29/dist/inputmask.min.js"></script>

                                        <div class="col-12 mb-3">
                                            <div class="form-group" id="phoneNumberContainer" style = "display:none">
                                                <h6 class="text-start">Номер телефона</h6>
                                                <input class="form-control" name="phoneNumber" id="phoneNumber" value = "${phoneNumber}" required>
                                            </div>
                                        </div>
                                        <script>
                                            $(document).ready(function(){
                                                Inputmask({"mask": "8 (999) 999-99-99"}).mask("#phoneNumber");
                                            });
                                        </script>

                                    <div class="col-12 mb-3">
                                        <div class="form-group" id="addressDelivery">
                                            <h6 class="text-start">Адрес доставки</h6>
                                            <input class="form-control" name="addressDelivery" id="addressDelivery"
                                                placeholder="Улица, дом, квартира" required>
                                        </div>
                                    </div>




                                    <div class="col-12 mb-3">
                                        <div class="form-group">
                                            <h6 class="text-start">Дата доставки</h6>
                                                <div style="display:flex;">
                                                    <input type="date" class="form-control" style="width:48px" id="dateDelivery" name="dateDelivery" min="${minDate}" max="${maxDate}" onchange="timeaddresser()" required>
                                                    <input type="text" class="form-control" id="dateDisplay" readonly style="margin-left:4px">
                                                </div>
                                        </div>
                                    </div>

                                    <div class="col-12 mb-3">
                                       <h6 for="dateTimeDelivery" class="form-label">Время доставки:</h6>
                                       <select name="timeDelivery" id="timeDelivery" class="form-control">
                                          <option value="08:00 - 10:00">08:00 - 10:00</option>
                                          <option value="10:00 - 12:00">10:00 - 12:00</option>
                                          <option value="12:00 - 14:00">12:00 - 14:00</option>
                                          <option value="14:00 - 16:00">14:00 - 16:00</option>
                                          <option value="16:00 - 18:00">16:00 - 18:00</option>
                                          <option value="18:00 - 20:00">18:00 - 20:00</option>
                                          <option value="20:00 - 22:00">20:00 - 22:00</option>
                                          <option value="Спросить у получателя">Спросить у получателя</option>
                                       </select>
                                    </div>

                                </div>


                            </div>

                            <div class="d-flex justify-content-center">
                                <button type="submit" class="btn btn-custom-order">Оформить заказ</button>
                            </div>
                        </form>
                        </#if>
                </div>
            </div>
        </div>
        </#if>
    </div>
     <footer class="footer mt-auto">
        <#include "blocks/footer.ftlh">
    </footer>
</body>
</html>