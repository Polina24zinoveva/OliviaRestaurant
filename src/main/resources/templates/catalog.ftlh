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
            border-radius: 7px;
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
        }

        .sideMarginRight{
            padding-right: 3rem;
        }

        .verticalMargin{
            margin-top: 1rem;
            margin-bottom: 1rem;
        }


        .card-link {
            margin-bottom: .75rem; /* Отступ снизу */
            font-size: 1.25rem; /* Размер шрифта */
            font-weight: 500; /* Жирность шрифта */
            color: #333;
            text-decoration: none;
        }

        .card-link-name {
            font-size: 1.25rem; /* Размер шрифта */
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
            align-items: center;
            padding: 10px;
            margin-bottom: 10px;
        }

        /* Добавленный класс активности для выбранной категории */
        .category-link.active {
            text-decoration: underline; /* Подчеркиваем выбранную категорию */
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
    <div>
        <#if isAdmin?? && isAdmin == true>
            <#include "blocks/headerAdmin.ftlh">
        <#else>
            <#include "blocks/header.ftlh">
        </#if>
    </div>


    <#if allBouquets??>
        <#if allBouquets?size = 0>
            <div class="container mt-5">
                <div class="row">
                    <div class="col-md-3 sideMarginRight">
                        <h6 for="typeRecipient" class="form-label" style="margin-top: 0.5rem;">Категория:</h6>
                        <div class="sideMargin" style="padding-top: 1rem;">
                            <p><a class="custom-link category-link" href="/catalog">Все букеты</a></p>
                            <p><a class="custom-link category-link" href="/authorBouquet">Авторские букеты</a></p>
                            <p><a class="custom-link category-link" href="/boxBouquet">Композиции в коробках и корзинах</a></p>
                            <p><a class="custom-link category-link" href="/weddingBouquet">Свадебный декор</a></p>
                            <p><a class="custom-link category-link" href="/catalogPostcard">Открытки</a></p>
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

                        <br>
                        <form action="/filterBouquets" method="get">
                            <h6 class="form-label">Сортировка:</h6>
                            <select name="sort" id="typeRecipient" class="form-control">
                                <option value="0">По умолчанию</option>
                                <option value="1">По возрастанию цены</option>
                                <option value="2">По убыванию цены</option>
                            </select>

                            <script>
                                document.addEventListener("DOMContentLoaded", function() {
                                    // Получаем переданное значение selectedSort
                                    var selectedSort = "${selectedSort}";

                                    // Находим элемент select
                                    var selectElement = document.getElementById("typeRecipient");

                                    // Устанавливаем значение selectedSort в select
                                    if (selectedSort) {
                                        selectElement.value = selectedSort;
                                    }
                                });
                            </script>

                            <br>
                            <div>
                                <h6>Цветы в составе: <i class="bi bi-info-circle"></i></h6>
                                <div class="form-check sideMargin verticalMargin">
                                    <#if roses??>
                                        <input checked class="form-check-input" type="checkbox" name="roses" id="roses" value="Роза">
                                    <#else>
                                        <input class="form-check-input" type="checkbox" name="roses" id="roses" value="Роза">
                                    </#if>
                                    <label class="form-check-label">
                                        розы
                                    </label>
                                </div>
                                <div class="form-check sideMargin verticalMargin">
                                    <#if peonies??>
                                       <input checked class="form-check-input" type="checkbox" name="peonies" id="peonies" value="Пион">
                                    <#else>
                                       <input class="form-check-input" type="checkbox" name="peonies" id="peonies" value="Пион">
                                    </#if>
                                    <label class="form-check-label">
                                        пионы
                                    </label>
                                </div>
                                <div class="form-check sideMargin verticalMargin">
                                    <#if ranunculus??>
                                       <input checked class="form-check-input" type="checkbox" name="ranunculus" id="ranunculus" value="Ранункулюс">
                                    <#else>
                                       <input class="form-check-input" type="checkbox" name="ranunculus" id="ranunculus" value="Ранункулюс">
                                    </#if>
                                    <label class="form-check-label">
                                        ранункулюсы
                                    </label>
                                </div>
                                <div class="form-check sideMargin verticalMargin">
                                    <#if eustoma??>
                                       <input checked class="form-check-input" type="checkbox" name="eustoma" id="eustoma" value="Эустома">
                                    <#else>
                                       <input class="form-check-input" type="checkbox" name="eustoma" id="eustoma" value="Эустома">
                                    </#if>
                                    <label class="form-check-label">
                                        эустомы
                                    </label>
                                </div>
                                <div class="form-check sideMargin verticalMargin">
                                    <#if hortensia??>
                                       <input checked class="form-check-input" type="checkbox" name="hortensia" id="hortensia" value="Гортензия">
                                    <#else>
                                       <input class="form-check-input" type="checkbox" name="hortensia" id="hortensia" value="Гортензия">
                                    </#if>
                                    <label class="form-check-label">
                                        гортензии
                                    </label>
                                </div>
                                <div class="form-check sideMargin verticalMargin">
                                    <#if alstroemeria??>
                                       <input checked class="form-check-input" type="checkbox" name="alstroemeria" id="alstroemeria" value="Альстромерия">
                                    <#else>
                                       <input class="form-check-input" type="checkbox" name="alstroemeria" id="alstroemeria" value="Альстромерия">
                                    </#if>
                                    <label class="form-check-label">
                                        альстромерии
                                    </label>
                                </div>
                                <div class="form-check sideMargin verticalMargin">
                                    <#if daisies??>
                                       <input checked class="form-check-input" type="checkbox" name="daisies" id="daisies" value="Ромашка">
                                    <#else>
                                       <input class="form-check-input" type="checkbox" name="daisies" id="daisies" value="Ромашка">
                                    </#if>
                                    <label class="form-check-label">
                                        ромашки
                                    </label>
                                </div>
                                <div class="form-check sideMargin verticalMargin">
                                    <#if chrysanthemums??>
                                       <input checked class="form-check-input" type="checkbox" name="chrysanthemums" id="chrysanthemums" value="Хризантема">
                                    <#else>
                                       <input class="form-check-input" type="checkbox" name="chrysanthemums" id="chrysanthemums" value="Хризантема">
                                    </#if>
                                    <label class="form-check-label">
                                        хризантемы
                                    </label>
                                </div>
                                <div class="form-check sideMargin verticalMargin">
                                    <#if gypsophila??>
                                       <input checked class="form-check-input" type="checkbox" name="gypsophila" id="gypsophila" value="Гипсофила">
                                    <#else>
                                       <input class="form-check-input" type="checkbox" name="gypsophila" id="gypsophila" value="Гипсофила">
                                    </#if>
                                    <label class="form-check-label">
                                        гипсофилы
                                    </label>
                                </div>
                                <div class="form-check sideMargin verticalMargin">
                                    <#if carnation??>
                                       <input checked class="form-check-input" type="checkbox" name="carnation" id="carnation" value="Гвоздика">
                                    <#else>
                                       <input class="form-check-input" type="checkbox" name="carnation" id="carnation" value="Гвоздика">
                                    </#if>
                                    <label class="form-check-label">
                                        гвоздики
                                    </label>
                                </div>
                                <div class="form-check sideMargin verticalMargin">
                                    <#if tulips??>
                                       <input checked class="form-check-input" type="checkbox" name="tulips" id="tulips" value="Тюльпан">
                                    <#else>
                                       <input class="form-check-input" type="checkbox" name="tulips" id="tulips" value="Тюльпан">
                                    </#if>
                                    <label class="form-check-label">
                                        тюльпаны
                                    </label>
                                </div>

                            </div>
                            <div>
                                <h6>Цена <i class="bi bi-info-circle"></i></h6>
                                <div class="input-group mb-3">
                                    <input type="number" name="minPrice" class="form-control" min="0" max="100000000" placeholder="от ${minPrice}">
                                    <input type="number" name="maxPrice" class="form-control" min="1" max="100000000" placeholder="до ${maxPrice}">
                                </div>
                                <div class="form-check sideMargin verticalMargin">
                                   <#if priceRangeSmall??>
                                       <input checked class="form-check-input" type="checkbox" name="priceRangeSmall" id="price1" value="0-2000">
                                    <#else>
                                       <input class="form-check-input" type="checkbox" name="priceRangeSmall" id="price1" value="0-2000">
                                    </#if>
                                    <label class="form-check-label" for="price1">
                                        до 2000 ₽
                                    </label>
                                </div>
                                <div class="form-check sideMargin verticalMargin">
                                    <#if priceRangeAverage??>
                                       <input checked class="form-check-input" type="checkbox" name="priceRangeAverage" id="price2" value="2000-4000">
                                    <#else>
                                       <input class="form-check-input" type="checkbox" name="priceRangeAverage" id="price2" value="2000-4000">
                                    </#if>
                                    <label class="form-check-label" for="price2">
                                        2000–4000 ₽
                                    </label>
                                </div>
                                <div class="form-check sideMargin verticalMargin">
                                    <#if priceRangeBig??>
                                       <input checked class="form-check-input" type="checkbox" name="priceRangeBig" id="price3" value="4000-999999999">
                                    <#else>
                                       <input class="form-check-input" type="checkbox" name="priceRangeBig" id="price3" value="4000-999999999">
                                    </#if>
                                    <label class="form-check-label" for="price3">
                                        от 4000 ₽
                                    </label>
                                </div>
                                <button type="submit" class="btn btn-custom mt-3">Применить</button>
                            </div>
                        </form>
                        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz4fnFO9gybBogGz5oCJ6pFYQ4IHg8DUi4zxtqDShTZ7H25QpYaetFG8L" crossorigin="anonymous"></script>
                        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-ho+j7jyWK8fNodH5t+1/s+M8fvr57Xj9sx1ztf5d1D3+6sni5BRp8FJaWwMGTOs3" crossorigin="anonymous"></script>
                    </div>
                    <div class="col-md-9 justify-content-center align-items-center">
                        <div id="emptyCartMessage" class="margin-top:5rem;" style="height: 40%;">
                            <h5>Нет доступных букетов</h5>
                        </div>
                    </div>
                </div>
            </div>
        <#else>
            <div class="container mt-5">
                <div class="row">
                    <div class="col-md-3 sideMarginRight">
                        <h6 for="typeRecipient" class="form-label" style="margin-top: 0.5rem;">Категория:</h6>
                        <div class="sideMargin" style="padding-top: 1rem;">
                            <p><a class="custom-link category-link" href="/catalog">Все букеты</a></p>
                            <p><a class="custom-link category-link" href="/authorBouquet">Авторские букеты</a></p>
                            <p><a class="custom-link category-link" href="/boxBouquet">Композиции в коробках и корзинах</a></p>
                            <p><a class="custom-link category-link" href="/weddingBouquet">Свадебный декор</a></p>
                            <p><a class="custom-link category-link" href="/catalogPostcard">Открытки</a></p>
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

                        <br>
                         <form action="/filterBouquets" method="get">
                             <h6 class="form-label">Сортировка:</h6>
                             <select name="sort" id="typeRecipient" class="form-control">
                                 <option value="0">По умолчанию</option>
                                 <option value="1">По возрастанию цены</option>
                                 <option value="2">По убыванию цены</option>
                             </select>

                             <script>
                                 document.addEventListener("DOMContentLoaded", function() {
                                     // Получаем переданное значение selectedSort
                                     var selectedSort = "${selectedSort}";

                                     // Находим элемент select
                                     var selectElement = document.getElementById("typeRecipient");

                                     // Устанавливаем значение selectedSort в select
                                     if (selectedSort) {
                                         selectElement.value = selectedSort;
                                     }
                                 });
                             </script>

                             <br>
                             <div>
                                 <h6>Цветы в составе: <i class="bi bi-info-circle"></i></h6>
                                 <div class="form-check sideMargin verticalMargin">
                                     <#if roses??>
                                         <input checked class="form-check-input" type="checkbox" name="roses" id="roses" value="Роза">
                                     <#else>
                                         <input class="form-check-input" type="checkbox" name="roses" id="roses" value="Роза">
                                     </#if>
                                     <label class="form-check-label">
                                         розы
                                     </label>
                                 </div>
                                 <div class="form-check sideMargin verticalMargin">
                                     <#if peonies??>
                                        <input checked class="form-check-input" type="checkbox" name="peonies" id="peonies" value="Пион">
                                     <#else>
                                        <input class="form-check-input" type="checkbox" name="peonies" id="peonies" value="Пион">
                                     </#if>
                                     <label class="form-check-label">
                                         пионы
                                     </label>
                                 </div>
                                 <div class="form-check sideMargin verticalMargin">
                                     <#if ranunculus??>
                                        <input checked class="form-check-input" type="checkbox" name="ranunculus" id="ranunculus" value="Ранункулюс">
                                     <#else>
                                        <input class="form-check-input" type="checkbox" name="ranunculus" id="ranunculus" value="Ранункулюс">
                                     </#if>
                                     <label class="form-check-label">
                                         ранункулюсы
                                     </label>
                                 </div>
                                 <div class="form-check sideMargin verticalMargin">
                                     <#if eustoma??>
                                        <input checked class="form-check-input" type="checkbox" name="eustoma" id="eustoma" value="Эустома">
                                     <#else>
                                        <input class="form-check-input" type="checkbox" name="eustoma" id="eustoma" value="Эустома">
                                     </#if>
                                     <label class="form-check-label">
                                         эустомы
                                     </label>
                                 </div>
                                 <div class="form-check sideMargin verticalMargin">
                                     <#if hortensia??>
                                        <input checked class="form-check-input" type="checkbox" name="hortensia" id="hortensia" value="Гортензия">
                                     <#else>
                                        <input class="form-check-input" type="checkbox" name="hortensia" id="hortensia" value="Гортензия">
                                     </#if>
                                     <label class="form-check-label">
                                         гортензии
                                     </label>
                                 </div>
                                 <div class="form-check sideMargin verticalMargin">
                                     <#if alstroemeria??>
                                        <input checked class="form-check-input" type="checkbox" name="alstroemeria" id="alstroemeria" value="Альстромерия">
                                     <#else>
                                        <input class="form-check-input" type="checkbox" name="alstroemeria" id="alstroemeria" value="Альстромерия">
                                     </#if>
                                     <label class="form-check-label">
                                         альстромерии
                                     </label>
                                 </div>
                                 <div class="form-check sideMargin verticalMargin">
                                     <#if daisies??>
                                        <input checked class="form-check-input" type="checkbox" name="daisies" id="daisies" value="Ромашка">
                                     <#else>
                                        <input class="form-check-input" type="checkbox" name="daisies" id="daisies" value="Ромашка">
                                     </#if>
                                     <label class="form-check-label">
                                         ромашки
                                     </label>
                                 </div>
                                 <div class="form-check sideMargin verticalMargin">
                                     <#if chrysanthemums??>
                                        <input checked class="form-check-input" type="checkbox" name="chrysanthemums" id="chrysanthemums" value="Хризантема">
                                     <#else>
                                        <input class="form-check-input" type="checkbox" name="chrysanthemums" id="chrysanthemums" value="Хризантема">
                                     </#if>
                                     <label class="form-check-label">
                                         хризантемы
                                     </label>
                                 </div>
                                 <div class="form-check sideMargin verticalMargin">
                                     <#if gypsophila??>
                                        <input checked class="form-check-input" type="checkbox" name="gypsophila" id="gypsophila" value="Гипсофила">
                                     <#else>
                                        <input class="form-check-input" type="checkbox" name="gypsophila" id="gypsophila" value="Гипсофила">
                                     </#if>
                                     <label class="form-check-label">
                                         гипсофилы
                                     </label>
                                 </div>
                                 <div class="form-check sideMargin verticalMargin">
                                     <#if carnation??>
                                        <input checked class="form-check-input" type="checkbox" name="carnation" id="carnation" value="Гвоздика">
                                     <#else>
                                        <input class="form-check-input" type="checkbox" name="carnation" id="carnation" value="Гвоздика">
                                     </#if>
                                     <label class="form-check-label">
                                         гвоздики
                                     </label>
                                 </div>
                                 <div class="form-check sideMargin verticalMargin">
                                     <#if tulips??>
                                        <input checked class="form-check-input" type="checkbox" name="tulips" id="tulips" value="Тюльпан">
                                     <#else>
                                        <input class="form-check-input" type="checkbox" name="tulips" id="tulips" value="Тюльпан">
                                     </#if>
                                     <label class="form-check-label">
                                         тюльпаны
                                     </label>
                                 </div>

                             </div>
                             <div>
                                 <h6>Цена <i class="bi bi-info-circle"></i></h6>
                                 <div class="input-group mb-3">
                                     <input type="number" name="minPrice" class="form-control" min="0" max="100000000" placeholder="от ${minPrice}">
                                     <input type="number" name="maxPrice" class="form-control" min="1" max="100000000" placeholder="до ${maxPrice}">
                                 </div>
                                 <div class="form-check sideMargin verticalMargin">
                                    <#if priceRangeSmall??>
                                        <input checked class="form-check-input" type="checkbox" name="priceRangeSmall" id="price1" value="0-2000">
                                     <#else>
                                        <input class="form-check-input" type="checkbox" name="priceRangeSmall" id="price1" value="0-2000">
                                     </#if>
                                     <label class="form-check-label" for="price1">
                                         до 2000 ₽
                                     </label>
                                 </div>
                                 <div class="form-check sideMargin verticalMargin">
                                     <#if priceRangeAverage??>
                                        <input checked class="form-check-input" type="checkbox" name="priceRangeAverage" id="price2" value="2000-4000">
                                     <#else>
                                        <input class="form-check-input" type="checkbox" name="priceRangeAverage" id="price2" value="2000-4000">
                                     </#if>
                                     <label class="form-check-label" for="price2">
                                         2000–4000 ₽
                                     </label>
                                 </div>
                                 <div class="form-check sideMargin verticalMargin">
                                     <#if priceRangeBig??>
                                        <input checked class="form-check-input" type="checkbox" name="priceRangeBig" id="price3" value="4000-999999999">
                                     <#else>
                                        <input class="form-check-input" type="checkbox" name="priceRangeBig" id="price3" value="4000-999999999">
                                     </#if>
                                     <label class="form-check-label" for="price3">
                                         от 4000 ₽
                                     </label>
                                 </div>
                                 <button type="submit" class="btn btn-custom mt-3">Применить</button>
                             </div>
                         </form>
                        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz4fnFO9gybBogGz5oCJ6pFYQ4IHg8DUi4zxtqDShTZ7H25QpYaetFG8L" crossorigin="anonymous"></script>
                        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-ho+j7jyWK8fNodH5t+1/s+M8fvr57Xj9sx1ztf5d1D3+6sni5BRp8FJaWwMGTOs3" crossorigin="anonymous"></script>
                    </div>
                    <div class="col-md-9">
                        <h4>${title}</h4>
                        <div class="row">
                            <#list allBouquets as bouquet>
                                <div class="col-md-4">
                                    <div class="product">
                                        <a href="/bouquet/${bouquet.id}" class="image">
                                            <img src="/images/${bouquet.images[0].id}" alt="Фото">
                                        </a>
                                        <div class="info">
                                            <a href="/bouquet/${bouquet.id}" class="card-link-name">${bouquet.name}</a>
                                            <div>${bouquet.price}</div>
                                        </div>
                                    </div>
                                </div>
                            </#list>
                        </div>
                    </div>
                </div>
            </div>
        </#if>

    <#else>
        <#if allPostcards?size = 0>
            <div class="container mt-5">
                <div class="row">
                    <div class="col-md-3 sideMarginRight">
                        <h6 for="typeRecipient" class="form-label" style="margin-top: 0.5rem;">Категория:</h6>
                        <div class="sideMargin" style="padding-top: 1rem;">
                            <p><a class="custom-link category-link" href="/catalog">Все букеты</a></p>
                            <p><a class="custom-link category-link" href="/authorBouquet">Авторские букеты</a></p>
                            <p><a class="custom-link category-link" href="/boxBouquet">Композиции в коробках и корзинах</a></p>
                            <p><a class="custom-link category-link" href="/weddingBouquet">Свадебный декор</a></p>
                            <p><a class="custom-link category-link" href="/catalogPostcard">Открытки</a></p>
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
                    </div>
                    <div class="col-md-9 d-flex flex-column justify-content-center align-items-center">
                        <div id="emptyCartMessage" class="d-flex flex-column justify-content-center align-items-center" style="height: 94%;">
                            <h5>Нет доступных открыток</h5>
                        </div>
                    </div>
                </div>
            </div>
        <#else>
            <div class="container mt-5">
                <div class="row">
                    <div class="col-md-3 sideMarginRight">
                        <h6 for="typeRecipient" class="form-label" style="margin-top: 0.5rem;">Категория:</h6>
                        <div class="sideMargin" style="padding-top: 1rem;">
                            <p><a class="custom-link category-link" href="/catalog">Все букеты</a></p>
                            <p><a class="custom-link category-link" href="/authorBouquet">Авторские букеты</a></p>
                            <p><a class="custom-link category-link" href="/boxBouquet">Композиции в коробках и корзинах</a></p>
                            <p><a class="custom-link category-link" href="/weddingBouquet">Свадебный декор</a></p>
                            <p><a class="custom-link category-link" href="/catalogPostcard">Открытки</a></p>
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

                        <br>

                    </div>
                    <div class="col-md-9">
                        <h4>${title}</h4>
                        <div class="row">
                            <#list allPostcards as Postcards>
                                <div class="col-md-4">
                                    <div class="product">
                                        <a href="/Postcards/${Postcards.id}" class="image">
                                            <img src="/images/${Postcards.image.id}" alt="Фото">
                                        </a>
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
