(function(angular){
	'use strict';

	angular.module('clienteModule').config(['$routeProvider',
		function($routeProvider) {
			$routeProvider.
				when('/registrar/clientes',{
					templateUrl: 'public/cliente/views/list-cliente.view.html'
				}).
				when('/editar/cliente/:id',{
					templateUrl: 'public/cliente/views/edit-cliente.view.html'
				});
		}
	]);

})(window.angular);
