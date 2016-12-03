(function(angular){
	'use strict';
	angular.module('reportesModule').controller('reportesCtrl',['$scope','funcionesService','$http',
		function($scope,funcionesService,$http) {
			console.log('Enter function controller reportes');
			$scope.save = function(newObj) {
				if(newObj.fecha.length > 10)
					newObj.fecha = funcionesService.convertCadFecha(newObj.fecha);
				console.log(newObj);
				$http.post('rest/v1/reportes',newObj).
				success(function(response){
					if(response[0].error == 'No se encontraron ventas en esa fecha') {
						$scope.mensaje = response[0].error;
					} else {
						$scope.mensaje = '';
						$scope.data = response;
						var doc = new jsPDF();
						doc.text(20,20,'TEST Message!!');
						doc.addPage();
						doc.text(20,20,'TEST Page 2');
						doc.save('Test.pdf');
						console.log($scope.data);
					}
				}).
				error(function(msg, code){
					deferred.reject(msg);
				});
			};
		}
	]);

})(window.angular);
