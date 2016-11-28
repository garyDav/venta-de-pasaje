(function(angular){
	'use strict';

	angular.module('pasajesModule').config(['$routeProvider',
		function($routeProvider) {
			$routeProvider.
				when('/registrar/pasajes',{
					templateUrl: 'public/pasajes/views/list-pasajes.view.html'
				}).
				when('/editar/pasaje/:id',{
					templateUrl: 'public/pasajes/views/edit-pasajes.view.html'
				});
		}
	]);

})(window.angular);
