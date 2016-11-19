(function(angular) {

	'use strict';
	angular.module('pasajesModule').factory('pasajesService',['$resource',
		function($resource) {
			return $resource('rest/v1/pasajes/:id', {
				id: '@id'
			}, {
				update: {
					method: 'PUT'
				}
			});
		}
	]);

})(window.angular);
