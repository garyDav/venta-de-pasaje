(function(angular){
	'use strict';

	angular.module('pasajesModule').config(['$routeProvider',
		function($routeProvider) {
			$routeProvider.
				when('/pasajes',{
					templateUrl: 'public/pasajes/views/list-pasajes.view.html'
				}).
				when('/pasajes/:id',{
					templateUrl: 'public/pasajes/views/edit-pasajes.view.html'
				});
		}
	]);

})(window.angular);
