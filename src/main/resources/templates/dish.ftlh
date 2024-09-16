<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="icon" href="icon_logo.png" type="image/x-icon">
    <title>Olivia Flowers</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        function showMessage(message) {
            Swal.fire({
              text: message,
              icon: "success",
              confirmButtonColor: '#e0d8d0'
            });
        }
        function showWarning(warning) {
            Swal.fire({
              text: warning,
              icon: "warning",
              confirmButtonColor: '#e0d8d0'
            });
        }
    </script>

    <style>
        .container-fluid, .navbar-custom, .image-container {
            background-color: #f0eade;
        }

        .row-custom {
            border: 2px solid #f0eade;
            border-radius: 10px;
            max-width: 1000px;
            margin-left: auto;
            margin-right: auto;
            margin-top: 3rem;
            margin-bottom: 0rem;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1), 0px 4px 8px rgba(0, 0, 0, 0.1); /* Добавляем тень со всех сторон */
        }

        .image {
            border-radius: 10px;
            max-width: 500px;
            max-height: 500px;
        }

        .card {
            border: 0px;
        }

        .text {
            margin-top: 2rem;
        }

        .btn-custom {
            width: 240px;
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
            width: 240px;
            margin-top: 10px;
            background-color: #ffffff;
            border-color: #e0d8d0;
            color: #333;
        }

        .btn-custom2:hover {
            color: #333;
            background-color: #e0d8d0;
            border-color: #e0d8d0;
        }

        .btn-custom-fav {
            width: 50px;
            margin-top: 10px;
            margin-right: 10px;
            background-color: #ffffff;
            border-color: #e0d8d0;
            color: #333;
        }

        .btn-custom-fav:hover {
            color: #333;
            background-color: #e0d8d0;
            border-color: #e0d8d0;
        }

        .carousel-item img {
            margin-top: auto;
            margin-bottom: auto;
            max-width: 100%;
        }



        .thumbnail {
            cursor: pointer;
            border: 2px solid transparent;
            margin-bottom: 10px;
            max-width: 100%;
        }

        .thumbnail.active {
            border-color: #554635;
        }

        .thumbnails-wrapper {
            max-width: 100px; /* Ensure thumbnails container is within bounds */
            height: 100%;
            display: flex;
            flex-direction: column;
        }

        .thumbnails-wrapper img {
            max-width: 100%;
            display: block;
            border-radius: 7px;
        }

        /* Для футера внизу страницы: html, body, wrapper */
        html, body {
            height: 100%;
        }
        .wrapper {
            flex-grow: 1;
            padding-bottom: 3rem;
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

    <#if warning??>
        <script>
            showWarning("${warning}");
        </script>
    </#if>

    <div class="row row-custom">
        <div class="col-md-8">
            <div class="row" style="margin-top: 2rem; margin-bottom: 2rem;">
                <div class="col-md-2">
                    <div class="thumbnails-wrapper">
                        <#list dish.images as image>
                            <img src="/images/${image.id}" class="thumbnail <#if image_index == 0>active</#if>" data-bs-target="#carouselDish" data-bs-slide-to="${image_index}" alt="Фото">
                        </#list>
                    </div>
                </div>
                <div class="col-md-10">
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
                    <div id="carouselDish" class="carousel slide">
                        <div class="carousel-indicators">
                            <#list dish.images as image>
                                <button type="button" data-bs-target="#carouselDish" data-bs-slide-to="${image_index}"<#if image_index == 0> class="active"</#if> aria-current="true" aria-label="Slide ${image_index + 1}"></button>
                            </#list>
                        </div>
                        <div class="carousel-inner">
                            <#list dish.images as image>
                                <div class="carousel-item<#if image_index == 0> active</#if>">
                                    <img src="/images/${image.id}" class="d-block w-100 image" alt="Фото">
                                </div>
                            </#list>
                        </div>
                        <button class="carousel-control-prev" type="button" data-bs-target="#carouselDish" data-bs-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Previous</span>
                        </button>
                        <button class="carousel-control-next" type="button" data-bs-target="#carouselDish" data-bs-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Next</span>
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-4 d-flex flex-column">
            <div class="flex-grow-1">
                <h4 class="text" style="margin-top: 3rem;">${dish.name}</h4>
            </div>
            <div class="flex-grow-1">
                <h6 class="text">Состав:</h6>
                <p><#list (dish.composition)?split("\n") as line>
                    ${line}<br>
                </#list></p>
                <p class="text">Калорийность: ${dish.calories}</p>
                <p class="text">Вес: ${dish.weight}</p>
                <p class="text">Кухня: ${dish.cuisine.name}</p>
                <p class="text">Тип блюда: ${dish.dishType.name}</p>
                <h6 class="text">${dish.price} рублей</h6>
            </div>
            <div class="d-flex justify-content-between" style="margin-bottom: 50px;"> <!-- Добавляем классы d-flex и justify-content-between -->
                <!-- Кнопка "Добавить в корзину" -->
                <#if inCard==false>
                    <form id="addButton" onclick="addOrAdded()" action="/addDishToOrder/${dish.id}" method="post">
                        <button type="submit" class="btn btn-custom">Добавить в корзину</button>
                    </form>
                    <form id="addedButton" action="/order" style="display:none;">
                        <button type="submit" class="btn btn-custom2">Перейти в корзину</button>
                    </form>
                <#else>
                    <form id="addButton" onclick="addOrAdded()" action="/addDishToOrder/${dish.id}" method="post" style="display:none;">
                        <button type="submit" class="btn btn-custom">Добавить в корзину</button>
                    </form>
                    <form id="addedButton" action="/order">
                        <button type="submit" class="btn btn-custom2">Перейти в корзину</button>
                    </form>
                </#if>

                <script>
                    function addOrAdded() {
                        if (document.getElementById("addedButton").style.display === "none") {
                            document.getElementById("addedButton").style.display = "block"
                            document.getElementById("addButton").style.display = "none"
                        } else {
                            document.getElementById("addedButton").style.display = "none"
                            document.getElementById("addButton").style.display = "block"
                        }
                    }
                </script>

            </div>
        </div>

    </div>
</div>
<footer class="footer mt-auto">
    <#include "blocks/footer.ftlh">
</footer>
<script>
    document.querySelectorAll('.thumbnail').forEach(function(thumb) {
        thumb.addEventListener('click', function() {
            document.querySelectorAll('.thumbnail').forEach(function(t) {
                t.classList.remove('active');
            });
            this.classList.add('active');
        });
    });

    var carousel = document.getElementById('carouselDish');
    carousel.addEventListener('slide.bs.carousel', function (event) {
        var index = event.to;
        var thumbnails = document.querySelectorAll('.thumbnail');
        thumbnails.forEach(function(thumbnail, i) {
            if (i === index) {
                thumbnail.classList.add('active');
            } else {
                thumbnail.classList.remove('active');
            }
        });
    });
</script>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script>
    $(document).ready(function(){
        $('.btn-custom').click(function(){
            $(this).addClass('clicked');
            setTimeout(() => {
                $(this).removeClass('clicked');
            }, 1500); // Установите время, которое вы хотите сохранить анимацию (в миллисекундах)
        });
    });
</script>

</body>
</html>
