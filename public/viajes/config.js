(function(angular){
	'use strict';

	angular.module('viajesModule').config(['$routeProvider',
		function($routeProvider) {
			$routeProvider.
				when('/viajes',{
					templateUrl: 'public/viajes/views/viajes.view.html'
				}).
				when('/registrar/viajes',{
					templateUrl: 'public/viajes/views/list-viajes.view.html'
				}).
				when('/editar/viaje/:id',{
					templateUrl: 'public/viajes/views/edit-viajes.view.html'
				});
		}
	]);

})(window.angular);
