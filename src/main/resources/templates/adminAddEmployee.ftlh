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
                        <#if allUsers?size = 0>
                            <div id="emptyCartMessage" class="d-flex flex-column justify-content-center align-items-center" style="height: 94%;">
                                <h5>Нет пользователей в базе</h5>
                            </div>

                        <#else>
                           <h5 style="margin-top: 10px; margin-bottom: 2rem;">Все пользователи</h5>
                           <table class="table">
                               <thead>
                               <tr>
                                   <th>ID</th>
                                   <th>Имя</th>
                                   <th>Фамилия</th>
                                   <th>Номер телефона</th>
                                   <th>Эл. почта</th>
                                   <th>Текущая роль</th>
                                   <th>Изменить роль</th>
                               </tr>
                               </thead>
                               <tbody>
                               <#list allUsers as user>
                                   <tr>
                                       <td>${user.id}</td>
                                       <td>${user.name}</td>
                                       <td>${user.surname}</td>
                                       <td>${user.phoneNumber}</td>
                                       <td>${user.email}</td>
                                       <td>
                                            <#if user.role == "ROLE_MANAGER">Менеджер</#if>
                                            <#if user.role == "ROLE_COURIER">Курьер</#if>
                                            <#if user.role == "ROLE_USER">Пользователь</#if>
                                       </td>
                                       <td>
                                           <form action="/adminChangeRole" method="post" id="changeForm_${user.id}">
                                               <input type="hidden" name="id" value="${user.id}">
                                               <select name="role" class="form-select">
                                                   <option value="ROLE_USER" <#if user.role == "ROLE_USER">selected</#if>>Пользователь</option>
                                                   <option value="ROLE_COURIER" <#if user.role == "ROLE_COURIER">selected</#if>>Курьер</option>
                                                   <option value="ROLE_MANAGER" <#if user.role == "ROLE_MANAGER">selected</#if>>Менеджер</option>
                                               </select>
                                               <button type="submit" class="btn btn-custom mt-2" onclick="confirmChange(this.closest('form'))">Сохранить</button>
                                           </form>

                                           <script>
                                               function confirmChange(formElement) {
                                                   event.preventDefault(); // Предотвращаем стандартное действие (отправка формы)

                                                   Swal.fire({
                                                       title: 'Подтвердите назначение сотрудника',
                                                       text: 'Должность сотрудника будет изменена',
                                                       icon: 'warning',
                                                       showCancelButton: true,
                                                       confirmButtonText: 'Назначить',
                                                       confirmButtonColor: '#333',
                                                       cancelButtonText: 'Отмена',
                                                       cancelButtonColor: '#999',
                                                       reverseButtons: true
                                                   }).then((result) => {
                                                       if (result.isConfirmed) {
                                                           formElement.submit();
                                                       }
                                                   });
                                               }
                                           </script>
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
