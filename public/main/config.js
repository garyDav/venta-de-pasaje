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
				/*when('/admin',{
					resolve: {
						"check":function($location,sessionService) {
							if(sessionService.get('user') != 'admin')
								$location.path('/usuario');
						}
					},
					templateUrl: 'public/main/views/admin.view.html'
				}).
				when('/menu',{
					templateUrl: 'public/main/views/menu.view.html'
				}).
				when('/user',{
					resolve: {
						"check":function($location,sessionService) {
							if(sessionService.get('user') != 'user')
								$location.path('/usuario');
						}
					},
					templateUrl: 'public/main/views/user.view.html'
				}).*/
				otherwise({
					redirectTo: '/'
				});
		}
	]);

})(window.angular);