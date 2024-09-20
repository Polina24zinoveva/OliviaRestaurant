<div class="container-fluid text-center">
    <nav class="navbar navbar-custom navbar-expand-sm">
        <a class="navbar-brand" href="/">Olivia Restaurant</a>

        <ul class="navbar-nav ms-auto">
            <li class="nav-item">
                <a class="nav-link active" aria-current="page" href="/catalog">Каталог</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" aria-current="page" href="/order">Корзина</a>
            </li>

            <li class="nav-item">
                <#if userRole??>
                    <#if userRole=="ROLE_ADMIN">
                        <li class="nav-item">
                            <a class="nav-link active" aria-current="page" href="/adminOrderList">Для администратора</a>
                        </li>
                    <#else>
                        <#if userRole=="ROLE_MANAGER">
                            <li class="nav-item">
                                <a class="nav-link active" aria-current="page" href="/managerProfile">Для менеджера</a>
                            </li>
                        <#else>
                            <#if userRole=="ROLE_COURIER">
                                <li class="nav-item">
                                    <a class="nav-link active" aria-current="page" href="/courierProfile">Для курьера</a>
                                </li>
                            <#else>
                            </#if>
                        </#if>
                    </#if>
                <#else>
                    <a class="nav-link active" aria-current="page" href="/profile">Профиль</a>
                </#if>
            </li>
        </ul>
    </nav>
</div>

<style>
    .container-fluid, .navbar-custom{
        background-color: #f0eade;
    }
</style>