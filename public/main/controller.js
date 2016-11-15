(function(angular){
	'use strict';
	angular.module('mainModule').controller('mainCtrl',['$scope','usuarioService','loginService','sessionService','$rootScope',
		function($scope,usuarioService,loginService,sessionService,$rootScope) {
			$scope.mensaje = '';
			$scope.msgtxt = '';

			/*$scope.c_user = false;
			$scope.c_admin = false;*/

			$scope.create = function() {
				console.log(this.key);
				var user = {
					email: this.email,
					pass: this.pass
				};
				if(this.key == 'alvantin') {
					var usuario = new usuarioService({
						nombre : this.name,
						apellido : this.last_name,
						correo : this.email,
						contra : this.pass,
						celular: this.cell,
						tipo: 'admin'
					});
				} else {
					var usuario = new usuarioService({
						nombre : this.name,
						apellido : this.last_name,
						correo : this.email,
						contra : this.pass,
						celular: this.cell,
						tipo: 'user'
					});
				}
				usuario.$save(function(response) {
					console.log(response);
					$scope.mensaje = response.error;
				},function(error) {
					console.log(error);
				});

				console.log(user);
				loginService.login(user,$scope);

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