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

})(window.angular);
