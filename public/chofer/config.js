(function(angular){
	'use strict';

	angular.module('choferModule').config(['$routeProvider',
		function($routeProvider) {
			$routeProvider.
				when('/registrar/choferes',{
					templateUrl: 'public/chofer/views/list-chofer.view.html'
				}).
				when('/editar/chofer/:id',{
					templateUrl: 'public/chofer/views/edit-chofer.view.html'
				});
		}
	]);

})(window.angular);