(function(angular){
	'use strict';
	angular.module('mainModule').controller('mainCtrl',['$scope','usuarioService','loginService','sessionService','$rootScope','$location',
		function($scope,usuarioService,loginService,sessionService,$rootScope,$location) {
			$scope.mensaje = '';
			$scope.msglogin = '';

			/*$scope.c_user = false;
			$scope.c_admin = false;*/

			$scope.create = function(user) {
				if(user.tipo == 'daniel') {
					user.tipo = 'admin';
					var usuario = new usuarioService(user);
				} else {
					user.tipo = 'user';
					var usuario = new usuarioService(user);
				}
				usuario.$save(function(response) {
					console.log(response);
					if( response.error == 'success' )
						$scope.mensaje = 'Usuario registrado exitosamente';
					else
						$scope.mensaje = response.error;
				},function(error) {
					console.log(error);
				});

				//console.log(user);
				loginService.login(user);
			};
			$scope.ingresar = function(user) {
				loginService.login(user,$scope);
			};
			$scope.logout = function() {
				loginService.logout();
			};

			$scope.navViajes = function() {
				$location.path('/viajes');
			};
			$scope.navBuses = function() {
				$location.path('/buses');
			};

			$scope.navRegChoferes = function() {
				$location.path('/registrar/choferes');
			};
			$scope.navRegBuses = function() {
				$location.path('/registrar/buses');
			};
			$scope.navRegViajes = function() {
				$location.path('/registrar/viajes');
			};
			$scope.navRegClientes = function() {
				$location.path('/registrar/clientes');
			};
			$scope.navRegPasajes = function() {
				$location.path('/registrar/pasajes');
			};
			$scope.navReportes = function() {
				$location.path('/reportes');
			};
		}
	]);

})(window.angular);