(function(angular){
	'use strict';

	angular.module('busModule').config(['$routeProvider',
		function($routeProvider) {
			$routeProvider.
				when('/buses',{
					templateUrl: 'public/bus/views/buses.view.html'
				}).
				when('/registrar/buses',{
					templateUrl: 'public/bus/views/list-bus.view.html'
				}).
				when('/editar/bus/:id',{
					templateUrl: 'public/bus/views/edit-bus.view.html'
				});
		}
	]);

})(window.angular);
