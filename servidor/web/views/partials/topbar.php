<div class="topbar">
    <div class="toggle">
        <ion-icon name="menu-outline"></ion-icon>
    </div>
    <div class="search">
        <label>
            <input type="text" name="busqueda" id="search" placeholder="Buscar">
            <ion-icon name="search-outline"></ion-icon>
        </label>
        <div class="filtro">
            <ion-icon name="options-outline"></ion-icon>
        </div>
    </div>
    <div class="profile-pic">
        <?php
            $profile_pic="../img/usuarios/";
            if (isset($_COOKIE["foto"])) {
                $profile_pic .= $_COOKIE["foto"];
            } else {
                $profile_pic .= "default_user.png";
            }
        ?>
        <img src="<?=$profile_pic?>" alt="Foto de perfil">
    </div>
</div>