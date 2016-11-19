(function(angular) {

	'use strict';
	angular.module('choferModule').factory('choferService',['$resource',
		function($resource) {
			return $resource('rest/v1/chofer/:id', {
				id: '@id'
			}, {
				update: {
					method: 'PUT'
				}
			});
		}
	]);

})(window.angular);
