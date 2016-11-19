(function(angular) {

	'use strict';
	angular.module('clienteModule').factory('clienteService',['$resource',
		function($resource) {
			return $resource('rest/v1/cliente/:id', {
				id: '@id'
			}, {
				update: {
					method: 'PUT'
				}
			});
		}
	]);

})(window.angular);
