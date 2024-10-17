<#include "alert.ftlh">
<style>
    /* Добавленный класс активности для выбранной категории */
    .category-link.active {
        text-decoration: underline; /* Подчеркиваем выбранную категорию */
    }

    .container{
        margin-top: 4rem;
        margin-bottom: 4rem;
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

    .image {
        border-radius: 10px; /* Скругление углов */
        margin: auto;
    }

    .btn-custom {
        width: 100%;
        margin-top: 10px;
        background-color: #f0eade; /* Основной цвет кнопки */
        border-color: #f0eade; /* Цвет границы кнопки */
        color: #333; /* Цвет текста кнопки */
    }

    .btn-custom:hover, .btn-custom2:hover {
        color: #333; /* Цвет текста кнопки */
        background-color: #e0d8d0; /* Цвет кнопки при наведении */
        border-color: #e0d8d0; /* Цвет границы кнопки при наведении */
    }

    .btn-custom2 {
        width: 100%;
        margin-top: 10px;
        border-color: #f0eade; /* Цвет границы кнопки */
        color: #333; /* Цвет текста кнопки */
    }
</style>

<h6 for="typeRecipient" class="form-label" style="margin-top: 1rem;">Заказы:</h6>
<div style="margin-left: 2rem; padding-top: 0.5rem;">
    <p><a href="/adminOrderList" class="custom-link category-link">Активные заказы</a></p>
    <p><a href="/adminFinishedOrderList" class="custom-link category-link">Доставленные заказы</a></p>
</div>
<h6 for="typeRecipient" class="form-label" style="margin-top: 2rem;">Блюда:</h6>
<div style="margin-left: 2rem; margin-right: 2rem; padding-top: 0.5rem;">
    <p><a href="/adminAllDishes" class="custom-link category-link">Все блюда</a></p>
    <p><a href="/adminAddDish" class="custom-link category-link">Добавление нового блюда</a></p>
    <p><a href="/adminChoiceDish" class="custom-link category-link">Выбор блюд в меню</a></p>
</div>

<h6 for="typeRecipient" class="form-label" style="margin-top: 2rem;">Сотрудники:</h6>
<div style="margin-left: 2rem; margin-right: 2rem; padding-top: 0.5rem;">
    <p><a href="/adminAllEmployee" class="custom-link category-link">Сотрудники</a></p>
    <p><a href="/adminAddEmployee" class="custom-link category-link">Назначение сотрудника</a></p>
</div>

<h6 for="typeRecipient" class="form-label" style="margin-top: 2rem;">Пользователи:</h6>
<div style="margin-left: 2rem; margin-right: 2rem; padding-top: 0.5rem;">
    <p><a href="/adminAllUsers" class="custom-link category-link">Пользователи</a></p>
</div>

<form action="/logout" method="post">
    <button type="submit" class="btn btn-custom">Выйти</button>
</form>

<#include "menuScript.ftlh">




