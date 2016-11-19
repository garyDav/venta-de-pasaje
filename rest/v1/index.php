<?php
//Libreria de Slim
require '../vendor/Slim/Slim.php';
//end Libreria.

\Slim\Slim::registerAutoloader();

$app = new \Slim\Slim();

session_start();

define('SPECIALCONSTANT',true);

//EntidadesRESTFULL
require 'models/connect.php';

require 'models/User.php';
require 'models/Bus.php';
require 'models/Chofer.php';
require 'models/Cliente.php';
require 'models/Pasaje.php';
require 'models/Viaje.php';
//end EntidadesRESTFULL

$app->run();



?>

