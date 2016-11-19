(function(angular) {

	'use strict';
	angular.module('viajesModule').factory('viajesService',['$resource',
		function($resource) {
			return $resource('rest/v1/viaje/:id', {
				id: '@id'
			}, {
				update: {
					method: 'PUT'
				}
			});
		}
	]);

})(window.angular);
