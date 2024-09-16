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
      margin-top: 3rem;
      font-size: 21px;
    }

    /* Отступы карт */
    .row-custom-flower {
      margin-left: 14rem;
      margin-right: 14rem;
      padding-bottom: 2rem;
    }

    /* Стили для границы карты */
    .custom-card-flower {
      border: 2px solid #f0eade; /* Цвет границы */
      border-radius: 10px; /* Скругление углов */
      max-width: 250px; /* Максимальная ширина карточки */
    }

    .custom-card-flower_img {
      border-radius: 10px; /* Скругление углов для изображения */
      width: 250px;
      height: 250px;
    }

    /* Отступы карт */
    .row-custom-delivery {
      margin-bottom: 4rem;

    }

    /* Стили для границы карты */
    .custom-card-delivery {
      border: 2px solid #f0eade; /* Цвет границы */
      border-radius: 10px; /* Скругление углов */
      max-width: 400px; /* Максимальная ширина карточки */
      margin-left: 10px;
      margin-right: 10px;
    }

    /* Стили для заголовка для сезонных цветов */
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

  </style>
</head>

<body>
    <div>
        <#include "blocks/headerAdmin.ftlh">


        <div class="image-container">
            <center><img src="../logotip.png" style="height: 100px;" alt="Logo"></center>
        </div>


        <center><img src="../rest.jpg" style="height: 400px; padding-top: 3rem; padding-bottom: 2rem;"></center>
        <p class="text-center" style="font-size: 20px;">${address}</p>
        <p class="text-center" style="font-size: 16px;">Часы работы: ${openHours} - ${closeHours}</p>


        <div class="background_color_about_us text-center">
            <p class="p-custom" style="padding-top: 4rem;">О нас</p>
            <h5>OLIVIA — это ресторан, созданный с любовью к каждому гостю.</h5>
            <p class="p-custom-text" style="padding-bottom: 4rem;"> Мы стремимся создавать уникальные гастрономические впечатления, которые дополняют важные моменты вашей жизни. <br>
                Команда наших шеф-поваров использует лучшие ингредиенты и инновационные рецепты, чтобы предлагать вам блюда, которые радуют вкусом.
                OLIVIA — это не просто ресторан, это пространство для уютных встреч, торжеств и незабываемых вечеров, где каждый гость получает внимание и заботу.<br>
            </p>
        </div>

    </div>
    <footer class="footer mt-auto">
       <#include "blocks/footer.ftlh">
    </footer>
</body>
</html>