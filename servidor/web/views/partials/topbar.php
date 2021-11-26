<div class="topbar">
    <div class="toggle">
        <ion-icon name="menu-outline"></ion-icon>
    </div>
    <div class="search">
        <?php if($pagina == "usuarios"): ?> <!-- Usuarios -->
            <label>
                <input type="text" name="busqueda" id="search" placeholder="Buscar">
                <ion-icon name="search-outline"></ion-icon>
            </label>
            <div class="filtro-tipo-select">
                <select name="filtro-tipo" id="filtro-tipo">
                    <option value="">Todos</option>
                    <option value="A">Admins</option>
                    <option value="C">Clientes</option>
                    <option value="V">Vendedores</option>
                </select>
            </div>
        <?php elseif($pagina == "panel-admin"): ?> <!-- Panel admin -->
            
        <?php else: ?> <!-- Por defecto -->
            <label>
                <input type="text" name="busqueda" id="search" placeholder="Buscar">
                <ion-icon name="search-outline"></ion-icon>
            </label>
            <div class="filtro">
                <ion-icon name="options-outline"></ion-icon>
            </div>
            <div class="filtros-container">
                <div class="filtroButton">Filtro</div>
                <div class="filtroButton">Filtro</div>
                <div class="filtroButton">Filtro</div>
                <div class="filtroButton" id="filtroFavoritos"></div>
                <button class="accionFiltros" id="aplicarFiltros">Aplicar</button>
                <button class="accionFiltros" id="resetearFiltros">Resetear</button>
            </div>
        <?php endif; ?>
        
    </div>
    <a href="./perfil.php?id=<?= $_COOKIE["id_usuario"] ?>" class="profile-pic">
        <?php
            $profile_pic="../img/usuarios/";
            if (isset($_COOKIE["foto"])) {
                $profile_pic .= $_COOKIE["foto"];
            } else {
                $profile_pic .= "default_user.png";
            }
        ?>
        <img src="<?=$profile_pic?>" alt="Foto de perfil">
    </a>
</div>