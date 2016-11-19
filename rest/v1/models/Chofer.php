<?php if(!defined('SPECIALCONSTANT')) die(json_encode([array('id'=>'0','nombre'=>'Acceso Denegado')]));

$app->get('/chofer',function() use($app) {
	try {
		$conex = getConex();

		$result = $conex->prepare("SELECT * FROM chofer;");
		
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

$app->get('/chofer/:id',function($id) use($app) {
	try {
		$conex = getConex();

		$result = $conex->prepare("SELECT * FROM chofer WHERE id='$id';");

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

$app->post("/chofer/",function() use($app) {
	$objDatos = json_decode(file_get_contents("php://input"));

	$ci = $objDatos->ci;
	$nombre = $objDatos->nombre;
	$apellido = $objDatos->apellido;
	$categoria = $objDatos->categoria;
	$descripcion = $objDatos->descripcion;

	try {
		$conex = getConex();

		$result = $conex->prepare("CALL pInsertChofer('$ci','$nombre','$apellido','$categoria','$descripcion');");

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

$app->put("/chofer/:id",function($id) use($app) {
	//$objDatos = json_decode(file_get_contents("php://input"));
	$jsonmessage = \Slim\Slim::getInstance()->request();
  	$objDatos = json_decode($jsonmessage->getBody());

	$ci = $objDatos->ci;
	$nombre = $objDatos->nombre;
	$apellido = $objDatos->apellido;
	$categoria = $objDatos->categoria;
	$descripcion = $objDatos->descripcion;

	try {
		$conex = getConex();
		$result = $conex->prepare("UPDATE chofer SET ci='$ci',nombre='$nombre',apellido='$apellido',categoria='$categoria',descripcion='$descripcion', WHERE id='$id'");

		$result->execute();
		$conex = null;

		$app->response->headers->set('Content-type','application/json');
		$app->response->status(200);
		$app->response->body(json_encode(array('id'=>$id,'error'=>'success')));

	}catch(PDOException $e) {
		echo "Error: ".$e->getMessage();
	}
})->conditions(array('id'=>'[0-9]{1,11}'));

$app->delete('/chofer/:id',function($id) use($app) {
	try {
		$conex = getConex();
		$result = $conex->prepare("DELETE FROM chofer WHERE id='$id'");

		$result->execute();
		$conex = null;

		$app->response->headers->set('Content-type','application/json');
		$app->response->status(200);
		$app->response->body(json_encode(array('id'=>$id,'error'=>'success')));
	} catch(PDOException $e) {
		echo 'Error: '.$e->getMessage();
	}
})->conditions(array('id'=>'[0-9]{1,11}'));
