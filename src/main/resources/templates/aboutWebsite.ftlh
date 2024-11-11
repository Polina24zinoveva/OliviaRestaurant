<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <link rel="icon" href="icon_logo.png" type="image/x-icon">
    <title>Olivia Flowers</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <style>

        .p-custom {
            font-size: 18px;
        }

        .p-custom-text {
            font-size: 16px;
            max-width: 1000px;
            margin: auto;
        }

        .div-text {
            margin-bottom: 4rem;
        }

        .headline{
            margin-top:2rem;
            margin-bottom:1rem;
        }

        .subHeadline{
            margin-top:1rem;
        }

        /* Обновим контейнер для выравнивания элементов по горизонтали */
        .links-container {
            padding: 1rem 0; /* Добавим отступы сверху и снизу */
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

        /* Стили для кнопки "Наверх" */
        #scrollToTop {
            position: fixed; /* Фиксированное позиционирование */
            bottom: 70px; /* Отступ от нижней части экрана */
            right: 20px; /* Отступ от правой части экрана */
            background-color: #white; /* Цвет фона */
            color: #666; /* Цвет текста */
            border: 1px solid #666; /* Без границы */
            border-radius: 5px; /* Скругленные углы */
            padding: 10px 20px; /* Отступы внутри кнопки */
            cursor: pointer; /* Курсор-указатель при наведении */
            z-index: 1000; /* Чтобы кнопка была сверху других элементов */
            text-decoration: none;
        }

        /* Добавление эффекта при наведении */
        #scrollToTop:hover {
            color: white; /* Цвет текста */
            background-color: #666; /* Темный оттенок при наведении */
        }

        img {
            max-width: 80%;
            height: auto; /* Сохраняет пропорции изображений */
            border-radius: 5px; /* Скругляет углы */
            margin-top: 0.5rem; /* Отступ снизу */
            margin-bottom: 1rem; /* Отступ снизу */
            border: 2px solid #f0eade;
        }


  </style>
</head>
<body class="d-flex flex-column h-100">
    <#include "blocks/header.ftlh">
    <div class="wrapper flex-grow-1" style="margin-top:3rem;">
        <div class="d-flex">
            <div class="container">
                <div class="row">
                    <div class="col-md-2">
                        <div class="links-container">
                            <p><a href="/aboutWebsite" class="custom-link category-link" style="padding-top: 1rem;">О веб-приложении</a></p>
                            <div style="padding-left: 1rem;">
                                <p><a href="#introduction" class="custom-link">Введение</a></p>
                                <ul>
                                    <li><a href="#authorization" class="custom-link ">Авторизация</a></li>
                                    <li><a href="#home" class="custom-link">Главная страница и навигация на страницах</a></li>
                                    <li><a href="#registration" class="custom-link">Регистрация</a></li>
                                </ul>
                                <p><a class="custom-link">Пользователи</a></p>
                                <ul>
                                    <li><a href="#menu" class="custom-link">Просмотр меню</a></li>
                                    <li><a href="#addDish" class="custom-link">Добавление блюда в корзину</a></li>
                                    <li><a href="#order" class="custom-link">Оформление заказа</a></li>
                                    <li><a href="#trackingOrder" class="custom-link">Отслеживание заказа</a></li>
                                    <li><a href="#historyUser" class="custom-link">Просмотр истории заказов</a></li>
                                    <li><a href="#exitUser" class="custom-link">Выход из аккаунта</a></li>
                                </ul>
                            </div>
                            <p><a href="/aboutDevelopers" class="custom-link category-link">О разработчиках</a></p>
                        </div>
                    </div>
                    <div class="col-md-1 vertical-line">
                    </div>

                    <div class="col-md-9">

                        <div class="div-text">
                            <p class="p-custom text-center" style="padding-top: 1rem;">О сайте Olivia Restaurant</p>

                            <h5 class="headline" id="introduction">Введение</h5>
                            <p class="p-custom-text">
                                Приложение для удаленного создания заказов в системе ресторана и контроля их исполнения создан для того,
                                чтобы сделать опыт взаимодействия пользователей с рестораном максимально удобным и приятным.<br>
                                Программа использует базу данных MySQL. Системные требования: тип операционной системы – Windows 7 и выше;
                                браузер – Google Chrome 86.0.4240.183 (64-битный) и выше, Firefox 83.0 (64-битный) и выше.
                            </p>
                            <ul>
                                <li>
                                    <p class="subHeadline" id="home">Главная страница и навигация на страницах</p>
                                    <p class="p-custom-text">
                                        На главной странице вы можете ознакомиться с общей информацией о ресторане:
                                        название, фотографии, раздел «О нас», в котором рассказывается о концепции
                                        данного заведения, адрес и время работы. Снизу на каждой странице расположена
                                        информация для связи с рестораном: город, номер телефона и ссылки на социальные
                                        сети.<br>
                                        Для навигации на страницах сверху каждой страницы предусмотрено меню для навигации.
                                    </p>
                                </li>
                                <li>
                                    <p class="subHeadline" id="authorization">Авторизация</p>
                                    <p class="p-custom-text">
                                        Для авторизации пользователю необходимо ввести свои учётные данные: адрес
                                        электронной почты, пароль и нажать кнопку «Войти». Если пользователь ещё
                                        не зарегистрирован можно перейти по гиперссылке «Зарегистрироваться» для
                                        открытия страницы регистрации.
                                    </p>
                                    <img src="../login.png">
                                </li>
                                <li>
                                    <p class="subHeadline" id="registration">Регистрация</p>
                                    <p class="p-custom-text">
                                        На странице регистрации можно создать новый аккаунт в системе, для этого
                                        необходимо заполнить поля: имя, фамилия, адрес электронной почты, номер телефона
                                        и пароль. Для подтверждения пароля предусмотрено дополнительное поле. После
                                        заполнения всех данных и нажатия кнопки «Зарегистрироваться» вы будете
                                        зарегистрированы в системе.
                                    </p>
                                    <img src="../registration.png">
                                </li>
                            </ul>

                            <h5 class="headline" id="introduction">Пользователь</h5>
                            Эта часть системы служит для осуществления взаимодействия пользователя с рестораном.
                            <ul>
                                <li>
                                    <p class="subHeadline" id="menu">Просмотр меню</p>
                                    <p class="p-custom-text">
                                    На странице «Каталог» представлено меню ресторана. Для детального просмотра каждого
                                    блюда достаточно нажать на его название, после чего откроется его полное описание
                                    на отдельной странице.
                                    </p>
                                    <img src="../catalog.png">
                                </li>
                                <li>
                                    <p class="subHeadline" id="addDish">Добавление блюда в корзину</pZZz>
                                    <p class="p-custom-text">
                                    Любое блюдо можно добавить в корзину, нажав на кнопку "Добавить в корзину" на
                                    странице блюда.
                                    </p>
                                    <img src="../dish.png">
                                </li>

                                <li>
                                    <p class="subHeadline" id="order">Оформление заказа</p>
                                    <p class="p-custom-text">
                                    Для изменения количества блюд в корзине предусмотрены кнопки «–» и «+» и
                                    «Удалить».<br>
                                    Для оформления заказа необходимо ввести данные для доставки: адрес, дату и
                                    время, а затем нажать кнопку «Оформить заказ».
                                    </p>
                                    <img src="../order.png">
                                </li>
                                <li>
                                    <p class="subHeadline" id="trackingOrder">Отслеживание заказа</p>
                                    <p class="p-custom-text">
                                    В личном кабинете можно отслеживать статусы заказов.
                                    </p>
                                    <img src="../lk.png">
                                </li>
                                <li>
                                    <p class="subHeadline" id="historyUser">Просмотр истории заказов</p>
                                    <p class="p-custom-text">
                                    Также в личном кабинете можно просматривать историю заказов. Для этого перейдите по
                                    гиперссылке "История заказов".
                                    </p>
                                    <img src="../history.png">
                                </li>
                                <li>
                                    <p class="subHeadline" id="exitUser">Выход из аккаунта</p>
                                    <p class="p-custom-text">
                                    Для выхода из аккаунта нажмите на кнопку "Выйти" в личном кабинете.
                                    </p>
                                </li>
                            </ul>
                            <p><a id="scrollToTop" href="#top">Наверх</a></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <#include "blocks/menuScript.ftlh">
    <#include "blocks/alert.ftlh">
    <footer class="footer mt-auto">
        <#include "blocks/footer.ftlh">
    </footer>
</body>
<script>
    document.getElementById('scrollToTop').addEventListener('click', function(e) {
        e.preventDefault();
        window.scrollTo({ top: 0, behavior: 'smooth' });
    });

</script>

</html>

