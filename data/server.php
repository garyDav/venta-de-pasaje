<?php

if(!is_dir('../material/photos/'))
	mkdir('../material/photos/',0777);
if($_FILES['img']) {
	if(is_uploaded_file($_FILES['img']['tmp_name'])) {
		//Definir nombres
		$e = '';
		$msg = '';
		$name = '';

		$nombre = $_FILES['img']['name'];
		$nombre = strtolower($nombre);
		$tipo = $_FILES['img']['type'];
		$tipo = strtolower($tipo);
		$size = $_FILES['img']['size'];
		$error = $_FILES['img']['error'];
		$extension = substr($tipo,strpos($tipo,'/')+1);
		$name = time().'.'.$extension;
		$lugar = '../material/photos/';
		//Fin de definir nombres

		if(!empty($nombre) && isset($nombre)) {
			if($error == 0) {
				if(strpos($tipo,'jpg') || strpos($tipo,'jpeg') || strpos($tipo,'bmp') || strpos($tipo,'png')) {
					if($size < 14779556) {
						if(move_uploaded_file($_FILES['img']['tmp_name'], $lugar.$name)) {
							$msg = 'Imagen subida';
							$e = 'success';
						}
					} else
						$msg = 'Imagen demasiado grande.';
				} else
					$msg = 'Formato incorrecto de la imagen.';
			} else
				$msg = 'Error al subir la imagen.';
		} else
			$msg = 'La imagen no se subio bien.';
	} else
		$msg = 'Por favor elija una imagen.';
	print_r(json_encode(array('error'=>$e,'msg'=>$msg,'src'=>$name)));
}
?>