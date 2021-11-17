<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <form action="login.php" method="POST">
        <label for="">Nombre Usuario</label>
        <input type="text" name="username" id="username"/><br/>
        <label for="">Contrase&ntilde;a</label>
        <input type="text" name="password" id="password"/><br/>
        <input type="submit" name="accion" id="registro" value="login"/>
    </form>
   
    <script>
        <?php if(isset($id_usuario)){ ?>
         var id_usu = '<?=$id_usuario?>';
         console.log(id_usu)
         localStorage.setItem('id_usu',id_usu);
         alert("Usuario Correcto");
  
    <?php } else { ?>
        alert("Usuario y/o Contraseña incorrecto");
    <?php } ?> 
     </script>
</body>
</html>