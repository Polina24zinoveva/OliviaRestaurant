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
                        <#list bouquet.images as image>
                            <img src="/images/${image.id}" class="thumbnail <#if image_index == 0>active</#if>" data-bs-target="#carouselBouquet" data-bs-slide-to="${image_index}" alt="Фото">
                        </#list>
                    </div>
                </div>
                <div class="col-md-10">
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
                    <div id="carouselBouquet" class="carousel slide">
                        <div class="carousel-indicators">
                            <#list bouquet.images as image>
                                <button type="button" data-bs-target="#carouselBouquet" data-bs-slide-to="${image_index}"<#if image_index == 0> class="active"</#if> aria-current="true" aria-label="Slide ${image_index + 1}"></button>
                            </#list>
                        </div>
                        <div class="carousel-inner">
                            <#list bouquet.images as image>
                                <div class="carousel-item<#if image_index == 0> active</#if>">
                                    <img src="/images/${image.id}" class="d-block w-100 image" alt="Фото">
                                </div>
                            </#list>
                        </div>
                        <button class="carousel-control-prev" type="button" data-bs-target="#carouselBouquet" data-bs-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Previous</span>
                        </button>
                        <button class="carousel-control-next" type="button" data-bs-target="#carouselBouquet" data-bs-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Next</span>
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-4 d-flex flex-column">
            <div class="flex-grow-1">
                <h4 class="text" style="margin-top: 3rem;">${bouquet.name}</h4>
            </div>
            <div class="flex-grow-1">
                <h6 class="text">Состав:</h6>
                <p><#list (bouquet.composition)?split("\n") as line>
                    ${line}<br>
                </#list></p>
                <h6 class="text">${bouquet.price} рублей</h6>
            </div>
            <div class="d-flex justify-content-between" style="margin-bottom: 50px;"> <!-- Добавляем классы d-flex и justify-content-between -->
                <!-- Кнопка "Добавить в корзину" -->
                <#if inCard==false>
                    <form id="addButton" onclick="addOrAdded()" action="/bouquet_addcar/${bouquet.id}" method="post">
                        <button type="submit" class="btn btn-custom">Добавить в корзину</button>
                    </form>
                    <form id="addedButton" action="/order" style="display:none;">
                        <button type="submit" class="btn btn-custom2">Перейти в корзину</button>
                    </form>
                <#else>
                    <form id="addButton" onclick="addOrAdded()" action="/bouquet_addcar/${bouquet.id}" method="post" style="display:none;">
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

                <#if inFav==false>
                    <form id="addFav" onclick="addOrAddedFav()" action="/add_to_favorites" method="post">
                        <input type="hidden" name="bouquetId" value="${bouquet.id}">
                        <button type="submit" class="btn btn-custom-fav">
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-heart" viewBox="0 0 16 16">
                                <path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143q.09.083.176.171a3 3 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15"/>
                            </svg>
                        </button>
                    </form>
                    <form id="addedFav" onclick="addOrAdded()" action="/remove_from_favorites_without_user" method="post" style="display:none;">
                        <input type="hidden" name="bouquetId" value="${bouquet.id}">
                        <button type="submit" class="btn btn-custom-fav">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16">
                                <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314"/>
                            </svg>
                        </button>
                    </form>
                <#else>
                    <form id="addFav" onclick="addOrAdded()" action="/add_to_favorites" method="post" style="display:none;">
                        <input type="hidden" name="bouquetId" value="${bouquet.id}">
                        <button type="submit" class="btn btn-custom-fav">
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-heart" viewBox="0 0 16 16">
                                <path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143q.09.083.176.171a3 3 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15"/>
                            </svg>
                        </button>
                    </form>
                    <form id="addedFav" onclick="addOrAdded()" action="/remove_from_favorites_without_user" method="post">
                        <input type="hidden" name="bouquetId" value="${bouquet.id}">
                        <button type="submit" class="btn btn-custom-fav">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16">
                                <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314"/>
                            </svg>
                        </button>
                    </form>
                </#if>

                <script>
                    function addOrAddedFav() {
                        if (document.getElementById("addedFav").style.display === "none") {
                            document.getElementById("addedFav").style.display = "block"
                            document.getElementById("addFav").style.display = "none"
                        } else {
                            document.getElementById("addedFav").style.display = "none"
                            document.getElementById("addFav").style.display = "block"
                        }
                    }
                </script>

                <!-- Кнопка "Добавить в избранное" -->

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

    var carousel = document.getElementById('carouselBouquet');
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
