<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="icon_logo.png" type="image/x-icon">
    <title>Olivia Flowers</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&display=swap');





        .container {
            background-color: #fff;
            border-radius: 30px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.35);
            position: relative;
            overflow: hidden;
            width: 55rem;
            height: 33rem;
            margin-top:1rem;
            margin-bottom:1rem;
        }


        .container button {
            background-color: #f0eade;
            font-size: 14px;
            padding: 10px 45px;
            border: 1px solid #f0eade;
            border-radius: 8px;
            font-weight: 600;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            margin-top: 10px;
            cursor: pointer;
            color: #333;
            width: 100%;
        }

        .container button.hidden {
            background-color: #e0d8d0;
            border-color: #e0d8d0;
        }

        .container form {
            background-color: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            padding: 0 40px;
            height: 100%;
        }

        .container input {
            background-color: #eee;
            border: none;
            margin: 8px 0;
            padding: 10px 15px;
            border-radius: 8px;
            width: 100%;
            outline: none;
        }

        .form-container {
            position: absolute;
            top: 0;
            height: 100%;
            transition: all 0.6s ease-in-out;
        }

        .sign-in {
            left: 0;
            width: 50%;
            z-index: 2;
        }

        .container.active .sign-in {
            transform: translateX(100%);
        }

        .sign-up {
            left: 0;
            width: 50%;
            opacity: 0;
            z-index: 1;
        }

        .container.active .sign-up {
            transform: translateX(100%);
            opacity: 1;
            z-index: 5;
            animation: move 0.6s;
        }

        @keyframes move {
            0%, 49.99% {
                opacity: 0;
                z-index: 1;
            }

            50%, 100% {
                opacity: 1;
                z-index: 5;
            }
        }




        .toggle-container {
            position: absolute;
            top: 0;
            left: 50%;
            width: 50%;
            height: 100%;
            overflow: hidden;
            transition: all 0.6s ease-in-out;
            border-radius: 150px 0 0 100px;
            z-index: 1000;
        }

        .container.active .toggle-container {
            transform: translateX(-100%);
            border-radius: 0 150px 100px 0;
        }

        .toggle {
            background-color: #f0eade;
            height: 100%;
            background: linear-gradient(to right, #f0eade, #e0d8d0);
            color: #333;
            position: relative;
            left: -100%;
            height: 100%;
            width: 200%;
            transform: translateX(0);
            transition: all 0.6s ease-in-out;
        }

        .container.active .toggle {
            transform: translateX(50%);
        }

        .toggle-panel {
            position: absolute;
            width: 50%;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            padding: 0 30px;
            text-align: center;
            top: 0;
            transform: translateX(0);
            transition: all 0.6s ease-in-out;
        }

        .toggle-left {
            transform: translateX(-200%);
        }

        .container.active .toggle-left {
            transform: translateX(0);
        }

        .toggle-right {
            right: 0;
            transform: translateX(0);
        }

        .container.active .toggle-right {
            transform: translateX(200%);
        }

        /* Custom styles for images */
        .toggle-left img,
        .toggle-right img {
            width: 200px;
            height: 200px;
            border-radius: 50%;
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
    </style>
</head>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    function showMessage(message) {
        Swal.fire({
          text: message,
          icon: "success",
          confirmButtonColor: '#e0d8d0'
        });
    }
    function showWarning(warning) {
        Swal.fire({
          text: warning,
          icon: "warning",
          confirmButtonColor: '#e0d8d0'
        });
    }
    function showError(error) {
        Swal.fire({
          text: error,
          icon: "error",
          confirmButtonColor: '#e0d8d0'
        });
    }
</script>
<body>
    <#if isAdmin?? && isAdmin == true>
        <#include "blocks/headerAdmin.ftlh">
    <#else>
        <#include "blocks/header.ftlh">
    </#if>
    <#if message??>
        <script>
            showMessage("${message}");
        </script>
    </#if>
    <#if warning??>
        <script>
            showWarning("${warning}");
        </script>
    </#if>
    <#if error??>
        <script>
            showError("${error}");
        </script>
    </#if>
    <div class="container" id="container">
        <div class="form-container sign-up">
            <form action="/registration" method="post">

                <h4>Регистрация</h4>
                <input type="text" class="form-control" id="name" name="name" placeholder="Имя" required>
                <input type="text" class="form-control" id="surname" name="surname" placeholder="Фамилия" required>
                <input type="email" class="form-control" id="email" name="email" placeholder="Email" required>
                <!--для правильного формата номера телефона-->
                <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/inputmask@5.0.6-beta.29/dist/inputmask.min.js"></script>
                <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" placeholder="Номер телефона" required>
                <script>
                    $(document).ready(function(){
                        Inputmask({"mask": "8 (999) 999-99-99"}).mask("#phoneNumber");
                    });
                </script>
                <input type="password" class="form-control" id="password" name="password" placeholder="Пароль" required>
                <input type="date" class="form-control" id="dateOfBirthday" name="dateOfBirthday" max="${maxDate}" placeholder="Дата рождения" required>

                <button>Зарегистрироваться</button>
            </form>
        </div>
        <div class="form-container sign-in">
            <form action="/login" method="post">
                <h4>Вход</h4>
                <input type="email" class="form-control" id="email" name="username" placeholder="Email">
                <input type="password" class="form-control" id="password" name="password" placeholder="Пароль">
                <button>Войти</button>
            </form>
        </div>
        <div class="toggle-container">
            <div class="toggle">
                <div class="toggle-panel toggle-left">
                    <h4>Уже есть аккаунт?</h4>
                    <a href="#" class="btn custom-link text-end" style="text-decoration: underline; " id="login" onclick="slideToLogin()">Войти</a>

                </div>
                <div class="toggle-panel toggle-right">
                    <h4>Еще нет аккаунта?</h4>
                    <a href="#" class="btn custom-link text-end" style="text-decoration: underline; " id="register" onclick="slideToRegister()">Зарегистрироваться</a>
                </div>
            </div>
        </div>
    </div>

    <script>
        const container = document.getElementById('container');
        const loginButton = document.getElementById('login');
        const registerButton = document.getElementById('register');

        loginButton.addEventListener('click', () => {
            container.classList.remove('active');
        });

        registerButton.addEventListener('click', () => {
            container.classList.add('active');
        });
    </script>
</body>

<footer class="footer mt-auto">
    <#include "blocks/footer.ftlh">
</footer>
</html>