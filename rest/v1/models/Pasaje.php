<?php if(!defined('SPECIALCONSTANT')) die(json_encode([array('id'=>'0','nombre'=>'Acceso Denegado')]));

$app->get('/pasaje',function() use($app) {
	try {
		$conex = getConex();

		$result = $conex->prepare("SELECT p.id,v.horario,c.nombre,c.apellido,p.num_asiento,p.ubicacion,p.precio,p.fecha,v.id AS id_viaje FROM pasaje as p,viaje as v,cliente as c WHERE p.id_viaje=v.id AND p.id_cliente=c.id;");
		
		$result->execute();
		$res = $result->fetchAll(PDO::FETCH_OBJ);
		$conex = null;

		$app->response->headers->set('Content-type','application/json');
		$app->response->headers->set('Access-Control-Allow-Origin','*');
		$app->response->status(200);
		$app->response->body(json_encode($res));
	}catch(PDOException $e) {
		echo 'Error: '.$e->getMessage();
	}
});

$app->get('/pasaje/:id',function($id) use($app) {
	try {
		$conex = getConex();

		$result = $conex->prepare("SELECT p.id,v.horario,c.nombre,c.apellido,p.num_asiento,p.ubicacion,p.precio,p.fecha FROM pasaje as p,viaje as v,cliente as c WHERE p.id_viaje=v.id AND p.id_cliente=c.id AND p.id=$id;");

		$result->execute();
		$res = $result->fetchObject();
		$conex = null;

		$app->response->headers->set('Content-type','application/json');
		$app->response->headers->set('Access-Control-Allow-Origin','*');
		$app->response->status(200);
		$app->response->body(json_encode($res));
	}catch(PDOException $e) {
		echo 'Error: '.$e->getMessage();
	}
});


$app->post("/pasaje/",function() use($app) {
	$objDatos = json_decode(file_get_contents("php://input"));

	$id_viaje = $objDatos->id_viaje;
	$id_cliente = $objDatos->id_cliente;
	$num_asiento = $objDatos->num_asiento;
	$ubicacion = $objDatos->ubicacion;
	$precio = $objDatos->precio;

	try {
		$conex = getConex();

		$result = $conex->prepare("CALL pInsertPasaje('$id_viaje','$id_cliente','$num_asiento','$ubicacion','$precio');");

		$result->execute();
		$res = $result->fetchObject();
		//$res = array('response'=>'success');

		$conex = null;

		$app->response->headers->set("Content-type","application/json");
		$app->response->headers->set('Access-Control-Allow-Origin','*');
		$app->response->status(200);
		$app->response->body(json_encode($res));
		//$app->response->body($ci);

	}catch(PDOException $e) {
		echo "Error: ".$e->getMessage();
	}
});

$app->put("/pasaje/:id",function($id) use($app) {
	//$objDatos = json_decode(file_get_contents("php://input"));
	$jsonmessage = \Slim\Slim::getInstance()->request();
  	$objDatos = json_decode($jsonmessage->getBody());

	$id_viaje = $objDatos->id_viaje;
	$id_cliente = $objDatos->id_cliente;
	$num_asiento = $objDatos->num_asiento;
	$ubicacion = $objDatos->ubicacion;
	$precio = $objDatos->precio;

	try {
		$conex = getConex();
		$result = $conex->prepare("UPDATE pasaje SET id_viaje='$id_viaje',id_cliente='$id_cliente',num_asiento='$num_asiento',ubicacion='$ubicacion',precio='$precio' WHERE id='$id'");

		$result->execute();
		$conex = null;

		$app->response->headers->set('Content-type','application/json');
		$app->response->status(200);
		$app->response->body(json_encode(array('id'=>$id,'error'=>'success')));

	}catch(PDOException $e) {
		echo "Error: ".$e->getMessage();
	}
})->conditions(array('id'=>'[0-9]{1,11}'));

$app->delete('/pasaje/:id',function($id) use($app) {
	try {
		$conex = getConex();
		$result = $conex->prepare("DELETE FROM pasaje WHERE id='$id'");

		$result->execute();
		$conex = null;

		$app->response->headers->set('Content-type','application/json');
		$app->response->status(200);
		$app->response->body(json_encode(array('id'=>$id,'error'=>'success')));

	} catch(PDOException $e) {
		echo 'Error: '.$e->getMessage();
	}
})->conditions(array('id'=>'[0-9]{1,11}'));
