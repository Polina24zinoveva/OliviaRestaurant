<h6 for="typeRecipient" class="form-label" style="margin-top: 1rem;">Заказы:</h6>
<div style="margin-left: 2rem; padding-top: 0.5rem;">
    <p><a href="/adminOrderList" class="custom-link category-link">Активные заказы</a></p>
    <p><a href="/adminFinishedOrderList" class="custom-link category-link">Доставленные заказы</a></p>
</div>
<h6 for="typeRecipient" class="form-label" style="margin-top: 2rem;">Блюда:</h6>
<div style="margin-left: 2rem; margin-right: 2rem; padding-top: 0.5rem;">
    <p><a href="/adminAllDish" class="custom-link category-link">Все блюда</a></p>
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