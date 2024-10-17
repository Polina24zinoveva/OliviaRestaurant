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

        /* Стили для заголовка для сезонных цветов */
        .p-custom {
            text-align: center;
            font-size: 21px;
        }

        .p-custom-text {
            text-align: center;
            font-size: 16px;
            max-width: 1000px;
            margin: auto;
            margin-bottom: 4rem;
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

        .restaurant-photos {
            display: flex; /* Используем Flexbox для выравнивания по центру */
            justify-content: center; /* Центрируем содержимое */
            gap: 10px; /* Задаем отступы между изображениями */
            height: auto;
            margin-top: 10px;
            margin-bottom: 10px;
            max-width: 100%;
        }

        .restaurant-photos img {
            height: 532px;
            width: auto; /* Автоматическая ширина для сохранения пропорций */
        }


  </style>
</head>

<body>
    <div>
        <#include "blocks/header.ftlh">


        <div class="image-container">
            <center><img src="../logotip.png" style="height: 100px;" alt="Logo"></center>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>

        <div class="restaurant-photos">
            <img src="../restaurant_photos/7.jpg">
            <img src="../restaurant_photos/1.jpg">
            <img src="../restaurant_photos/9.jpg">
        </div>

        <div class="background_color_about_us text-center">
            <p class="p-custom" style="padding-top: 4rem;">О нас</p>
            <h5>OLIVIA — это ресторан, созданный с любовью к каждому гостю.</h5>
            <p class="p-custom-text" style="padding-bottom: 4rem;"> Мы стремимся создавать уникальные гастрономические впечатления, которые дополняют важные моменты вашей жизни. <br>
                Команда наших шеф-поваров использует лучшие ингредиенты и инновационные рецепты, чтобы предлагать вам блюда, которые радуют вкусом.
                OLIVIA — это не просто ресторан, это пространство для уютных встреч, торжеств и незабываемых вечеров, где каждый гость получает внимание и заботу.<br>
            </p>
        </div>

        <p class="text-center" style="font-size: 20px; display: flex; justify-content: center; align-items: center;">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-geo-alt" viewBox="0 0 16 16" style="margin-right: 8px;">
                <path d="M12.166 8.94c-.524 1.062-1.234 2.12-1.96 3.07A32 32 0 0 1 8 14.58a32 32 0 0 1-2.206-2.57c-.726-.95-1.436-2.008-1.96-3.07C3.304 7.867 3 6.862 3 6a5 5 0 0 1 10 0c0 .862-.305 1.867-.834 2.94M8 16s6-5.686 6-10A6 6 0 0 0 2 6c0 4.314 6 10 6 10"/>
                <path d="M8 8a2 2 0 1 1 0-4 2 2 0 0 1 0 4m0 1a3 3 0 1 0 0-6 3 3 0 0 0 0 6"/>
            </svg>
            Адрес: ${address}
        </p>

        <p class="text-center" style="font-size: 20px; padding-bottom: 4rem; display: flex; justify-content: center; align-items: center;">
            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-clock" viewBox="0 0 16 16" style="margin-right: 8px;">
                <path d="M8 3.5a.5.5 0 0 0-1 0V9a.5.5 0 0 0 .252.434l3.5 2a.5.5 0 0 0 .496-.868L8 8.71z"/>
                <path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16m7-8A7 7 0 1 1 1 8a7 7 0 0 1 14 0"/>
            </svg>
            Часы работы: ${openHours} - ${closeHours}
        </p>


    </div>
    <footer class="footer mt-auto">
       <#include "blocks/footer.ftlh">
    </footer>
</body>
</html>