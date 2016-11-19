<?php if(!defined('SPECIALCONSTANT')) die(json_encode([array('id'=>'0','nombre'=>'Acceso Denegado')]));

$app->get('/bus',function() use($app) {
	try {
		$conex = getConex();

		$result = $conex->prepare("SELECT * FROM bus;");
		
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

$app->get('/bus/:id',function($id) use($app) {
	try {
		$conex = getConex();

		$result = $conex->prepare("SELECT * FROM bus WHERE id='$id';");

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

$app->post("/bus/",function() use($app) {
	$objDatos = json_decode(file_get_contents("php://input"));

	$placa = $objDatos->placa;
	$marca = $objDatos->marca;
	$modelo = $objDatos->modelo;
	$cilindrada = $objDatos->cilindrada;
	$motor = $objDatos->motor;
	$combustible = $objDatos->combustible;
	$capacidad = $objDatos->capacidad;
	$num_puertas = $objDatos->num_puertas;
	$tipo = $objDatos->tipo;

	try {
		$conex = getConex();

		$result = $conex->prepare("CALL pInsertBus('$placa','$marca','$modelo','$cilindrada','$motor','$combustible','$capacidad','$num_puertas','$tipo');");

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

$app->put("/bus/:id",function($id) use($app) {
	//$objDatos = json_decode(file_get_contents("php://input"));
	$jsonmessage = \Slim\Slim::getInstance()->request();
  	$objDatos = json_decode($jsonmessage->getBody());

	$placa = $objDatos->placa;
	$marca = $objDatos->marca;
	$modelo = $objDatos->modelo;
	$cilindrada = $objDatos->cilindrada;
	$motor = $objDatos->motor;
	$combustible = $objDatos->combustible;
	$capacidad = $objDatos->capacidad;
	$num_puertas = $objDatos->num_puertas;
	$tipo = $objDatos->tipo;

	try {
		$conex = getConex();
		$result = $conex->prepare("UPDATE bus SET placa='$placa',marca='$marca',modelo='$modelo',cilindrada='$cilindrada',motor='$motor',combustible='$combustible',capacidad='$capacidad',num_puertas='$num_puertas',tipo='$tipo' WHERE id='$id'");

		$result->execute();
		$conex = null;

		$app->response->headers->set('Content-type','application/json');
		$app->response->status(200);
		$app->response->body(json_encode(array('id'=>$id,'error'=>'success')));

	}catch(PDOException $e) {
		echo "Error: ".$e->getMessage();
	}
})->conditions(array('id'=>'[0-9]{1,11}'));

$app->delete('/bus/:id',function($id) use($app) {
	try {
		$conex = getConex();
		$result = $conex->prepare("DELETE FROM bus WHERE id='$id'");

		$result->execute();
		$conex = null;

		$app->response->headers->set('Content-type','application/json');
		$app->response->status(200);
		$app->response->body(json_encode(array('id'=>$id,'error'=>'success')));

	} catch(PDOException $e) {
		echo 'Error: '.$e->getMessage();
	}
})->conditions(array('id'=>'[0-9]{1,11}'));
