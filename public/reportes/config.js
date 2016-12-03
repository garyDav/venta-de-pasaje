(function(angular){
	'use strict';

	angular.module('reportesModule').config(['$routeProvider',
		function($routeProvider) {
			$routeProvider.
				when('/reportes',{
					templateUrl: 'public/reportes/views/reporte.view.html'
				});
		}
	]);

})(window.angular);