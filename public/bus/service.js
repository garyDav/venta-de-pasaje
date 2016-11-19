(function(angular) {

	'use strict';
	angular.module('busModule').factory('busService',['$resource',
		function($resource) {
			return $resource('rest/v1/bus/:id', {
				id: '@id'
			}, {
				update: {
					method: 'PUT'
				}
			});
		}
	]);

})(window.angular);
