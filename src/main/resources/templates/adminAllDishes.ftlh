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

                        <h5 style="margin-top: 10px; margin-bottom: 2rem;">Блюда</h5>
                        <form action="/adminAllDishes" method="get">
                            <div class="d-flex justify-content-between" style="margin-bottom:2rem;">
                                <select name="dishTypeId" id="type" class="form-select" onchange="this.form.submit()">
                                    <option value="0" <#if dishTypeId == "0">selected</#if>>Все типы блюд</option>
                                    <option value="1" <#if dishTypeId == "1">selected</#if>>Роллы</option>
                                    <option value="2" <#if dishTypeId == "2">selected</#if>>Салаты</option>
                                    <option value="3" <#if dishTypeId == "3">selected</#if>>Супы</option>
                                    <option value="4" <#if dishTypeId == "4">selected</#if>>Горячие закуски и гарниры</option>
                                    <option value="5" <#if dishTypeId == "5">selected</#if>>Пицца</option>
                                    <option value="6" <#if dishTypeId == "6">selected</#if>>Горячие блюда</option>
                                    <option value="7" <#if dishTypeId == "7">selected</#if>>Wok</option>
                                    <option value="8" <#if dishTypeId == "8">selected</#if>>Паста</option>
                                    <option value="9" <#if dishTypeId == "9">selected</#if>>Десерты</option>
                                    <option value="10" <#if dishTypeId == "10">selected</#if>>Безалкогольные напитки</option>
                                    <option value="11" <#if dishTypeId == "11">selected</#if>>Алкогольные напитки</option>
                                </select>
                                <select name="cuisineId" id="cuisine" class="form-select" onchange="this.form.submit()" style="margin-left:1rem;">
                                    <option value="0" <#if cuisineId == "0">selected</#if>>Все виды кухни</option>
                                    <option value="1" <#if cuisineId == "1">selected</#if>>Русская</option>
                                    <option value="2" <#if cuisineId == "2">selected</#if>>Европейская</option>
                                    <option value="3" <#if cuisineId == "3">selected</#if>>Итальянская</option>
                                    <option value="4" <#if cuisineId == "4">selected</#if>>Азиатская</option>
                                </select>
                            </div>
                        </form>

                        <#if allDishes?size = 0>
                            <div class="d-flex flex-column  align-items-center" style="height: 94%; margin-top:2rem;">
                                <h5>Нет блюд в базе</h5>
                            </div>

                        <#else>

                            <table class="table">
                                <thead>
                                <tr>
                                    <th>Название</th>
                                    <th>Состав</th>
                                    <th>Калорийность</th>
                                    <th>Вес</th>
                                    <th>Цена</th>
                                    <th>Вид кухни</th>
                                    <th>Тип блюда</th>
                                    <th>Фото</th>
                                    <th>Действия</th>
                                </tr>
                                </thead>
                                <tbody>
                                <#list allDishes as dish>
                                    <tr>
                                        <td>${dish.name}</td>
                                        <td>${dish.composition}</td>
                                        <td>${dish.calories}</td>
                                        <td>${dish.weight}</td>
                                        <td>${dish.price}</td>
                                        <td>${dish.cuisine.name}</td>
                                        <td>${dish.dishType.name}</td>
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
                                        <td>
                                            <a href="/dish/${dish.id}" class="btn btn-custom">Посмотреть</a>
                                            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
                                            <form action="/adminEditDish/${dish.id}" method="get">
                                                <button type="submit" class="btn btn-custom">Редактировать</button>
                                            </form>
                                            <form action="/adminDeleteDish/${dish.id}" method="post">
                                                <button type="submit" class="btn btn-custom">Удалить</button>
                                            </form>
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
