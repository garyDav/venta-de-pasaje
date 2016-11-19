(function(angular){
	'use strict';

	angular.module('clienteModule').config(['$routeProvider',
		function($routeProvider) {
			$routeProvider.
				when('/clientes',{
					templateUrl: 'public/cliente/views/list-cliente.view.html'
				}).
				when('/clientes/:id',{
					templateUrl: 'public/cliente/views/edit-cliente.view.html'
				});
		}
	]);

})(window.angular);
