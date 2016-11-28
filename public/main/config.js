(function(angular){
	'use strict';

	angular.module('mainModule').config(['$routeProvider',
		function($routeProvider) {
			$routeProvider.
				when('/',{
					templateUrl: 'public/main/views/principal.view.html'
				}).
				when('/login',{
					templateUrl: 'public/main/views/login.view.html'
				}).
				otherwise({
					redirectTo: '/'
				});
		}
	]);

})(window.angular);