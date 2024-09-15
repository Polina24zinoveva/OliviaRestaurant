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
      max-width: 800px;
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
            <center><img src="../logotip2.png" style="height: 180px;" alt="Logo"></center>
        </div>

        <p class="p-custom" style="padding-top: 1rem;">Вам могут понравиться наши сезонные букеты</p>

        <!-- Если нет букетов, выводим сообщение о их отсутствии -->
        <p class="p-text-center">На данный момент у нас нет сезонных букетов</p>


        <div class="background_color_about_us text-center">
            <p class="p-custom" style="padding-top: 4rem;">О нас</p>
            <h5>OLIVIA - это цветы, собранные с любовью.</h5>
            <p class="p-custom-text" style="padding-bottom: 4rem;">Цветы сопровождают нас в самые радостные моменты жизни, и мы рады проживать их вместе с вами.<br>
              Наша команда занимается разработкой авторских букетов и композиций, декором свадеб и других мероприятий.<br>
            </p>
        </div>



        <div class="row row-custom-delivery d-flex justify-content-center" style="max-width: 100%">
            <div class="col-sm-6 col-md-4 col-lg-3">
                <div class="card h-100 custom-card-delivery">
                    <div class="card-body">
                        <h5 class="card-title">Доставка по городу</h5>
                        <p class="card-text">Курьером по городу 300₽</p>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-md-4 col-lg-3">
                <div class="card h-100 custom-card-delivery">
                    <div class="card-body">
                        <h5 class="card-title">Бесплатная доставка</h5>
                        <p class="card-text">При заказе от 3000₽</p>
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