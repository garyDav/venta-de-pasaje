(function(angular) {

	'use strict';
	angular.module('viajesModule').factory('viajesService',['$resource',
		function($resource) {
			return $resource('rest/v1/viajes/:id', {
				id: '@id'
			}, {
				update: {
					method: 'PUT'
				}
			});
		}
	]);

})(window.angular);
