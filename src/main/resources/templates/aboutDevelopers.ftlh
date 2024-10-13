<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <link rel="icon" href="icon_logo.png" type="image/x-icon">
    <title>Olivia Flowers</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <style>

        .background_color_about_us{
          background-color: #f0eade;
        }

        .image-container{
          background-color: #f0eade;
          padding-bottom: 2rem;
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

        /* Стили для заголовка для сезонных цветов */
        .p-custom {
          text-align: center;
          font-size: 18px;
        }

        .p-custom-text {
          text-align: center;
          font-size: 16px;
          max-width: 1000px;
          margin: auto;
        }

        .card-link {
            margin-bottom: .75rem; /* Отступ снизу */
            font-size: 1.25rem; /* Размер шрифта */
            font-weight: 500; /* Жирность шрифта */
            color: #333;
            text-decoration: none;
        }
        .card-link:hover {
            text-decoration: underline; /* Подчеркивание при наведении */
        }

        .p-text-center {
              text-align: center;
              margin: auto;
              margin-bottom: 4rem;
            }

        /* Для футера внизу страницы: html, body, wrapper*/
        html, body {
            height: 100%;
        }
        .wrapper {
            flex-grow: 1;
        }


  </style>
</head>
<body class="d-flex flex-column h-100">
    <#include "blocks/header.ftlh">
    <#include "menuScript.ftlh">
    <div class="wrapper flex-grow-1">
        <div class="d-flex">
            <div class="container">
                <div class="row">
                    <div class="col-md-2">
                        <div style="padding-top: 0.5rem;">
                            <p><a href="/aboutWebsite" class="custom-link category-link">О веб-приложении</a></p>
                            <p><a href="/aboutDevelopers" class="custom-link category-link">О разработчиках</a></p>
                        </div>
                    </div>

                    <div class="col-md-1 vertical-line">
                    </div>

                    <div class="col-md-9">

                        <div class="text-center">
                            <p class="p-custom" style="padding-top: 1rem;">Самарский университет. Институт информатики и кибернетики</p>

                            <p class="p-custom-text" style="margin-bottom: 6rem;">
                                Курсовой проект по дисциплине «Программная инженерия»<br>
                                по теме «Приложение для удаленного создания заказов в системе ресторана и контроля их исполнения»<br>
                            </p>
                            <p class="p-custom-text" style="margin-bottom: 6rem;">
                                Разработчики обучающиеся группы 6403-020302D:<br>
                                Зиновьева П.Д.<br>
                                Плешаков И.С.<br>
                                Гришкова В.А.<br>
                            </p>
                            <p class="p-custom-text">Самара 2024</p>
                        </div>
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

