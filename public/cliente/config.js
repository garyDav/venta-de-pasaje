(function(angular){
	'use strict';

	angular.module('clienteModule').config(['$routeProvider',
		function($routeProvider) {
			$routeProvider.
				when('/cliente',{
					templateUrl: 'public/cliente/views/list-cliente.view.html'
				}).
				when('/cliente/:id',{
					templateUrl: 'public/cliente/views/edit-cliente.view.html'
				});
		}
	]);

})(window.angular);
