(function(angular) {

	'use strict';
	angular.module('mainModule').factory('usuarioService',['$resource',
		function($resource) {
			return $resource('rest/v1/user/:id', {
				id: '@id'
			}, {
				update: {
					method: 'PUT'
				}
			});
		}
	]);

	angular.module('mainModule').factory('loginService',function ($http,$location,sessionService,$rootScope) {
		return {
			login: function(user,scope) {
				var $promise = $http.post('rest/v1/login',user);
				$promise.then(function(res){
					console.log(res);
					var uid = res.data.error;
					if(uid == 'success') {
						sessionService.set('user',res.data.tipo);
						if(res.data.tipo == 'user') {
							$rootScope.c_user = true;
							$location.path('/user');
						}
						if(res.data.tipo == 'admin') {
							$rootScope.c_admin = true;
							$location.path('/admin');
						}
					} else {
						scope.msgtxt = 'Error Information';
						$location.path('/usuario');
					}
				});
			},
			logout: function() {
				sessionService.destroy('user');
				$rootScope.c_admin = false;
				$rootScope.c_user = false;

				$location.path('/');
			}
		};
	});

	angular.module('mainModule').factory('sessionService',function ($http) {
		return {
			set: function(key,value) {
				return localStorage.setItem(key,value);
			},
			get: function(key) {
				return localStorage.getItem(key);
			},
			destroy: function(key) {
				return localStorage.removeItem(key);
			}
		};
	});


})(window.angular);
