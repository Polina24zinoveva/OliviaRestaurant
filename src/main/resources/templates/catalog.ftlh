<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <link rel="icon" href="icon_logo.png" type="image/x-icon">
    <title>Olivia Flowers</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

    <style>
        /* Стили для фона */
        .container-fluid, .navbar-custom{
            background-color: #f0eade;
        }

        .product{
            margin-top: 20px;
            max-width: 18rem; /* Максимальная ширина карточки */
        }

        .image img{
            height: 18rem;
            width: 18rem;
            border-radius: 7px;
            object-fit: cover;
        }

        .image{
            margin-bottom: 10px;
        }

        .custom-link {
            font-size: 1.05rem; /* Размер шрифта */
            color: #333;
            text-decoration: none;
        }

        .container{
            margin-top: 4rem;
            margin-bottom: 4rem;
        }

        .sideMargin{
            margin-left: 2rem;
            margin-right: 2rem;
            margin-bottom: 28px;
        }

        .sideMarginRight{
            padding-right: 3rem;
        }

        .card-link-name {
            font-size: 18px; /* Размер шрифта */
            color: #333;
            text-decoration: none;
        }

        /* Для футера внизу страницы: html, body, wrapper */
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
        }

        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .content-wrapper {
            flex: 1;
        }

        .footer {
            flex-shrink: 0;
        }

        .price-filter {
            border: 1px solid #e0e0e0;
            padding: 20px;
            border-radius: 8px;
        }

        .price-filter h5 {
            font-weight: bold;
        }

        .price-filter .input-group {
            margin-bottom: 1rem;
        }

        .price-filter .form-check-label {
            font-weight: normal;
        }

        .price-filter .form-check-input:checked ~ .form-check-label {
            color: #007bff;
        }

        /* Стили для удаления кнопок увеличения и уменьшения в input type number */
        input[type=number]::-webkit-outer-spin-button,
        input[type=number]::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }
        input[type=number] {
            -moz-appearance: textfield;
        }

        .info {
            display: flex;
            justify-content: space-between;
            align-items: top;
            padding: 10px;
            margin-bottom: 10px;
        }

        /* Добавленный класс активности для выбранной категории */
        .category-link.active {
            text-decoration: underline; /* Подчеркиваем выбранную категорию */
        }

        .category-link.active {
            text-decoration: underline;
        }

        #emptyCartMessage {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100%;
            text-align: center;
        }

    </style>
</head>

<body>
    <#include "blocks/header.ftlh">

    <#if allDishes??>

        <div class="container mt-5">
            <div class="row">
                <div class="col-md-3 sideMarginRight">
                    <br>
                    <h6 class="form-label" style="margin-bottom: 1rem;">Сортировка:</h6>
                    <select name="sort" id="typeRecipient" class="form-control">
                        <option value="0">По умолчанию</option>
                        <option value="1">По возрастанию цены</option>
                        <option value="2">По убыванию цены</option>
                    </select>

                    <script>
                        document.addEventListener("DOMContentLoaded", function() {
                            var selectedSort = "${selectedSort}";  // Получаем значение с сервера
                            var selectedCuisine = "${selectedCuisine}";  // Текущая выбранная кухня
                            var selectedDishType = "${selectedDishType}";  // Текущий выбранный тип блюда

                            var selectElement = document.getElementById("typeRecipient");

                            // Устанавливаем выбранное значение в select
                            if (selectedSort) {
                                selectElement.value = selectedSort;
                            }

                            // Обработчик изменения значения в select
                            selectElement.addEventListener("change", function() {
                                var selectedSort = selectElement.value;

                                // Перенаправляем на страницу с текущими параметрами кухни и блюда
                                var url = "/catalog?sort=" + selectedSort + "&cuisine=" + selectedCuisine + "&dishType=" + selectedDishType;
                                window.location.href = url;
                            });
                        });
                    </script>

                    <br>

                    <h6 class="form-label" style="margin-bottom: 28px;">
                        <a href="#" class="custom-link category-link" data-cuisine="all" id="allMenuLink">Все меню</a>
                    </h6>


                    <h6 for="typeRecipient" class="form-label" style="margin-bottom: 1rem;">Кухня:</h6>
                    <div class="sideMargin">
                        <p><a class="custom-link category-link" href="#" data-cuisine="russian">Русская</a></p>
                        <p><a class="custom-link category-link" href="#" data-cuisine="european">Европейская</a></p>
                        <p><a class="custom-link category-link" href="#" data-cuisine="italian">Итальянская</a></p>
                        <p><a class="custom-link category-link" href="#" data-cuisine="asian">Азиатская</a></p>
                    </div>

                    <h6 for="typeRecipient" class="form-label" style="margin-bottom: 1rem;">Тип блюда:</h6>
                    <div class="sideMargin">
                        <p><a class="custom-link category-link" href="#" data-dishType="rolls">Роллы</a></p>
                        <p><a class="custom-link category-link" href="#" data-dishType="salads">Салаты</a></p>
                        <p><a class="custom-link category-link" href="#" data-dishType="soups">Супы</a></p>
                        <p><a class="custom-link category-link" href="#" data-dishType="appetizers">Горячие закуски и гарниры</a></p>
                        <p><a class="custom-link category-link" href="#" data-dishType="pizza">Пицца</a></p>
                        <p><a class="custom-link category-link" href="#" data-dishType="hotDishes">Горячие блюда</a></p>
                        <p><a class="custom-link category-link" href="#" data-dishType="wok">Wok</a></p>
                        <p><a class="custom-link category-link" href="#" data-dishType="pasta">Паста</a></p>
                        <p><a class="custom-link category-link" href="#" data-dishType="desserts">Десерты</a></p>
                        <p><a class="custom-link category-link" href="#" data-dishType="softDrinks">Безалкогольные напитки</a></p>
                        <p><a class="custom-link category-link" href="#" data-dishType="alcoholicDrinks">Алкогольные напитки</a></p>

                    </div>

                    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz4fnFO9gybBogGz5oCJ6pFYQ4IHg8DUi4zxtqDShTZ7H25QpYaetFG8L" crossorigin="anonymous"></script>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-ho+j7jyWK8fNodH5t+1/s+M8fvr57Xj9sx1ztf5d1D3+6sni5BRp8FJaWwMGTOs3" crossorigin="anonymous"></script>
                </div>
                <script>
                    document.addEventListener("DOMContentLoaded", function() {
                        // Находим все ссылки для выбора кухни и типа блюда
                        var cuisineLinks = document.querySelectorAll('.category-link[data-cuisine]');
                        var dishTypeLinks = document.querySelectorAll('.category-link[data-dishType]');
                        var allMenuLink = document.getElementById('allMenuLink'); // "Все меню"

                        // Обработчик клика для кухонь
                        cuisineLinks.forEach(function(link) {
                            link.addEventListener("click", function(event) {
                                event.preventDefault();  // Отключаем стандартное поведение ссылки

                                // Снимаем класс 'active' со всех ссылок
                                cuisineLinks.forEach(function(l) {
                                    l.classList.remove('active');
                                });

                                dishTypeLinks.forEach(function(l) {
                                    l.classList.remove('active');
                                });

                                allMenuLink.classList.remove('active');

                                // Устанавливаем класс 'active' для выбранной кухни
                                this.classList.add('active');

                                // Получаем значение выбранной кухни
                                var selectedCuisine = this.getAttribute("data-cuisine");

                                // Формируем URL
                                var url = "/catalog?cuisine=" + selectedCuisine;
                                window.location.href = url;
                            });
                        });

                        // Обработчик клика для типов блюд
                        dishTypeLinks.forEach(function(link) {
                            link.addEventListener("click", function(event) {
                                event.preventDefault();  // Отключаем стандартное поведение ссылки

                                // Снимаем класс 'active' со всех ссылок
                                dishTypeLinks.forEach(function(l) {
                                    l.classList.remove('active');
                                });

                                cuisineLinks.forEach(function(l) {
                                    l.classList.remove('active');
                                });

                                allMenuLink.classList.remove('active');

                                // Устанавливаем класс 'active' для выбранного типа блюда
                                this.classList.add('active');

                                // Получаем значение выбранного типа блюда
                                var selectedDishType = this.getAttribute("data-dishType");

                                // Формируем URL
                                var url = "/catalog?dishType=" + selectedDishType;
                                window.location.href = url;
                            });
                        });

                        // Обработчик клика для ссылки "Все меню"
                        allMenuLink.addEventListener("click", function(event) {
                            event.preventDefault();  // Отключаем стандартное поведение ссылки

                            // Снимаем класс 'active' со всех ссылок
                            cuisineLinks.forEach(function(l) {
                                l.classList.remove('active');
                            });

                            dishTypeLinks.forEach(function(l) {
                                l.classList.remove('active');
                            });

                            // Устанавливаем класс 'active' для "Все меню"
                            allMenuLink.classList.add('active');

                            // Перенаправляем на все меню
                            window.location.href = "/catalog?cuisine=all&dishType=all";
                        });

                        // Установка активных элементов при загрузке страницы
                        var selectedCuisine = "${selectedCuisine}";
                        var selectedDishType = "${selectedDishType}";

                        if (selectedCuisine && selectedCuisine !== "all") {
                            var activeCuisineLink = document.querySelector(`.category-link[data-cuisine="${selectedCuisine}"]`);
                            if (activeCuisineLink) {
                                activeCuisineLink.classList.add('active');
                            }
                        } else if (!selectedDishType || selectedDishType === "all") {
                            // Если нет выбранного типа блюда, активируем ссылку "Все меню"
                            allMenuLink.classList.add('active');
                        }

                        if (selectedDishType && selectedDishType !== "all") {
                            var activeDishTypeLink = document.querySelector(`.category-link[data-dishType="${selectedDishType}"]`);
                            if (activeDishTypeLink) {
                                activeDishTypeLink.classList.add('active');
                            }
                        }
                    });
                </script>



                <#if allDishes?size = 0>
                    <div class="col-md-9 justify-content-center align-items-center">
                        <div id="emptyCartMessage" class="margin-top:5rem;" style="height: 40%;">
                            <h5>Нет доступных блюд</h5>
                        </div>
                    </div>
                <#else>
                    <div class="col-md-9">
                        <div class="row">
                            <#list allDishes as dish>
                                <div class="col-md-4">
                                    <div class="product">
                                        <a href="/dish/${dish.id}" class="image">
                                            <img src="/images/${dish.images[0].id}" alt="Фото">
                                        </a>
                                        <div class="info">
                                            <a href="/dish/${dish.id}" class="card-link-name">${dish.name}</a>
                                            <div style=" font-size: 18px;">${dish.price} ₽</div>
                                        </div>
                                    </div>
                                </div>
                            </#list>
                        </div>
                    </div>
                </div>
            </div>
        </#if>
    </#if>
    <footer class="footer mt-auto">
      <#include "blocks/footer.ftlh">
    </footer>
</body>
</html>