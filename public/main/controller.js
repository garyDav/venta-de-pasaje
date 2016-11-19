(function(angular){
	'use strict';
	angular.module('mainModule').controller('mainCtrl',['$scope','usuarioService','loginService','sessionService','$rootScope',
		function($scope,usuarioService,loginService,sessionService,$rootScope) {
			$scope.mensaje = '';
			$scope.msglogin = '';

			/*$scope.c_user = false;
			$scope.c_admin = false;*/

			$scope.create = function(user) {
				if(user.tipo == 'pasaje_admin') {
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

				console.log(user);
				loginService.login(user);
			};
			$scope.ingresar = function(user) {
				console.log(user);
				loginService.login(user,$scope);
			};
			$scope.logout = function() {
				console.log('entra logout');
				loginService.logout();
			};

			

			
		}
	]);

})(window.angular);