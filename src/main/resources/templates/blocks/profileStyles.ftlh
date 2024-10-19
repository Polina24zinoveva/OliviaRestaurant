<#include "alert.ftlh">
<style>
    .container{
        margin-top: 4rem;
        margin-bottom: 4rem;
    }

    .icon-text {
        display: flex;
        align-items: center;
    }

    .icon-text svg {
        margin-right: 8px; /* Отступ между иконкой и текстом */
    }

    .p {
        font-size: 20px;
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

    .image{
        border-radius: 7px;
        max-width: 10rem;
        max-height: 10rem;
        margin-bottom: 2rem;
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

    #emptyCartMessage {
        flex-direction: column; /* Отображаем дочерние элементы в столбце */
        justify-content: center; /* Выравниваем элементы по вертикали */
        align-items: center; /* Выравниваем элементы по горизонтали */
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
</style>




