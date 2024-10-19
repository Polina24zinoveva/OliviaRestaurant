<style>
    .container-fluid, .navbar-custom{
        background-color: #f0eade;
    }
</style>

<div class="container-fluid text-center">
    <nav class="navbar navbar-custom navbar-expand-sm">
        <a class="navbar-brand" href="/">Olivia Restaurant</a>

        <ul class="navbar-nav ms-auto">
            <li class="nav-item">
                <a class="nav-link active" aria-current="page" href="/aboutWebsite">О сайте</a>
            </li>
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
                            <a class="nav-link active" aria-current="page" href="/adminOrderList">Администратор</a>
                        </li>
                    <#else>
                        <#if userRole=="ROLE_MANAGER">
                            <li class="nav-item">
                                <a class="nav-link active" aria-current="page" href="/managerProfile">Менеджер</a>
                            </li>
                        <#else>
                            <#if userRole=="ROLE_COURIER">
                                <li class="nav-item">
                                    <a class="nav-link active" aria-current="page" href="/courierProfile">Курьер</a>
                                </li>
                            <#else>
                                <a class="nav-link active" aria-current="page" href="/profile">Профиль</a>
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

