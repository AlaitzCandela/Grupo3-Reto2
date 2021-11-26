<nav>
    <ul>
        <li id="menuLogo">
            <a href="./home.php">
                <span class="icon logo"><img src="../img/tomNookLogo.svg" alt="Logo"></span>
                <span class="title logo">Tom&nbsp;Nook</span>
            </a>
        </li>

        <li id="menuHome" class="">
            <a href="./home.php">
                <span class="icon"><ion-icon name="home-outline"></ion-icon></span>
                <?php if ($tipo == 'A'): ?>
                    <span class="title">Panel Control</span>
                <?php elseif ($tipo == 'V'): ?>
                    <span class="title">Estadísticas</span>
                <?php else: ?>
                    <span class="title">Anuncios</span>
                <?php endif; ?>
            </a>
        </li>

        <?php if ($tipo != 'C'): ?>
            <li id="menuAnuncios" class="">
                <a href="./anuncios.php">
                    <span class="icon"><ion-icon name="albums-outline"></ion-icon></span>
                    <span class="title">Anuncios</span>
                </a>
            </li>
        <?php endif; ?>

        <?php if ($tipo != 'A'): ?>
            <li id="menuCarrito" class="">
                <a href="./carrito.php">
                    <span class="icon"><ion-icon name="cart-outline"></ion-icon></span>
                    <span class="title">Carrito&nbsp;de&nbsp;la&nbsp;compra</span>
                </a>
            </li>

            

            <li id="menuHistorial" class="">
                <a href="./historial.php">
                    <span class="icon"><ion-icon name="time-outline"></ion-icon></span>
                    <span class="title"><?= ($tipo == 'C') ? 'Mis compras' : 'Mis ventas' ;?></span>
                </a>
            </li>
            
            
            <li id="menuSubirAnuncio">
                <a href="./subir-anuncio.php">
                    <span class="icon"><ion-icon name="cloud-upload-outline"></ion-icon></span>
                    <span class="title">Subir&nbsp;anuncio</span>
                </a>
            </li>
        <?php endif; ?>

        <li id="menuAyuda">
            <a href="https://codefun973161967.wordpress.com/" target="_blank">
                <span class="icon"><ion-icon name="help-outline"></ion-icon></span>
                <span class="title">Contacto</span>
            </a>
        </li>

        <li id="menuPerfil">
            <a href="./perfil.php?id=<?= $_COOKIE["id_usuario"] ?>">
                <span class="icon"><ion-icon name="person-outline"></ion-icon></ion-icon></span>
                <span class="title">Ajustes&nbsp;del&nbsp;perfil</span>
            </a>
        </li>

        <li id="menuLogout">
            <a href="./login.php?logout=true">
                <span class="icon"><ion-icon name="log-out-outline"></ion-icon></span>
                <span class="title">Cerrar&nbsp;sesi&oacute;n</span>
            </a>
        </li>
    </ul>
</nav>