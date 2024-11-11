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
                        <#if banOfAdding??>
                            <h5 style="margin-top: 10px; margin-bottom: 2rem;">
                                ${banOfAdding}
                            </h5>
                            <script>
                                // JavaScript для отключения всех полей формы
                                document.addEventListener("DOMContentLoaded", function() {
                                    // Отключение всех input, select, textarea и кнопок формы
                                    const formElements = document.querySelectorAll("form input, form select, form textarea, form button");
                                    formElements.forEach(element => {
                                        element.disabled = true; // Делает элементы некликабельными
                                    });
                                });
                            </script>
                        </#if>

                        <h5 style="margin-top: 10px; margin-bottom: 2rem; <#if banOfAdding??>color: gray;</#if>">Добавление нового блюда</h5>
                        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
                        <form action="/adminCreateDish" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
                            <div class="mb-3">
                                <label for="name" class="form-label">Название:</label>
                                <input type="text" id="required1" class="form-control" id="name" name="name" required minlength="4" maxlength="50">
                            </div>
                            <div class="mb-3">
                                <label for="file1" class="form-label">Первое фото:</label>
                                <input type="file" id="required2" class="form-control" id="file1" name="file1" required>
                            </div>
                            <div class="mb-3">
                                <label for="file2" class="form-label">Второе фото:</label>
                                <input type="file" class="form-control" id="file2" name="file2">
                            </div>
                            <div class="mb-3">
                                <label for="file3" class="form-label">Третье фото:</label>
                                <input type="file" class="form-control" id="file3" name="file3">
                            </div>
                            <div class="mb-3">
                                <label for="composition" class="form-label">Состав:</label>
                                <textarea class="form-control" id="composition" name="composition" rows="4" required minlength="5" maxlength="200"></textarea>
                            </div>
                            <div class="mb-3">
                                <label for="calories" class="form-label">Калорийность:</label>
                                <input type="number" id="required3" class="form-control" id="calories" name="calories" required min="0" max="1500">
                            </div>
                            <div class="mb-3">
                                <label for="weight" class="form-label">Вес:</label>
                                <input type="number" id="required4" class="form-control" id="weight" name="weight" required min="10" max="800">
                            </div>
                            <div class="mb-3">
                                <label for="price" class="form-label">Цена:</label>
                                <input type="number" id="required5" class="form-control" id="price" name="price" required min="100" max="1500">
                            </div>

                            <div class="mb-3">
                                <label for="type" class="form-label">Тип блюда:</label>
                                <select name="dishTypeId" id="type" class="form-control">
                                    <option value="1">Роллы</option>
                                    <option value="2">Салаты</option>
                                    <option value="3">Супы</option>
                                    <option value="4">Горячие закуски и гарниры</option>
                                    <option value="5">Пицца</option>
                                    <option value="6">Горячие блюда</option>
                                    <option value="7">Wok</option>
                                    <option value="8">Паста</option>
                                    <option value="9">Десерты</option>
                                    <option value="10">Безалкогольные напитки</option>
                                    <option value="11">Алкогольные напитки</option>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label for="type" class="form-label">Вид кухни:</label>
                                <select name="cuisineId" id="cuisine" class="form-control">
                                    <option value="1">Русская</option>
                                    <option value="2">Европейская</option>
                                    <option value="3">Итальянская</option>
                                    <option value="4">Азиатская</option>
                                </select>
                            </div>


                            <button type="submit" class="btn btn-custom">Добавить</button>
                        </form>
                        <script>
                            function validateForm() {
                                var required1 = document.getElementById("required1").value;
                                var required2 = document.getElementById("required2").value;
                                var required3 = document.getElementById("required3").value;
                                var required4 = document.getElementById("required4").value;
                                var required5 = document.getElementById("required5").value;
                                var composition = document.getElementById("composition").value;

                                if (required1 === "" || required2 === "" || required3 === "" || required4 === "" || required5 === "" || composition === "") {
                                    alert("Пожалуйста, заполните все обязательные поля.");
                                    return false;
                                }
                            }
                        </script>
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
