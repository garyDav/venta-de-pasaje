(function(angular){
	'use strict';
	angular.module('pasajesModule').controller('pasajesCtrl',['$scope','pasajesService',
		function($scope,pasajesService) {
			$scope.mensaje = '';
			console.log('Entra a pasajesCtrl');
			
			$scope.find = function() {
				var obj = pasajesService.query();
				obj.$promise.then(function(response){
					$scope.data = response;
					console.log(response);
				},function(response){
					console.log(response);
				});
			}

			$scope.save = function(newD) {
				var obj = new pasajesService(newD);
				obj.$save(function(response) {
					var newData = {
						id: response.id,
						id_viaje: newD.id_viaje,
						num_asiento: newD.num_asiento,
						fecha: response.fecha
					};
					console.log(response);
					$scope.mensaje = response.error;
					$scope.data.push(newData);
					console.log($scope.data);
				},function(response) {
					console.log(response);
				});
			}
			$scope.cancel = function() {
				$scope.data = {};
			}
			$scope.delete = function(id) {
				var remove = confirm('¿Está seguro de eliminar el registro?');
				if( remove ) {
					var obj = new pasajesService({id:id});
					obj.$remove(function(response) {
						console.log(response);
						for(var d in $scope.data) {
							if( $scope.data[d].id === id ) {
								$scope.data.splice(d,1);
							}
						}
					},
					function(response) {
						console.log(response);
					});
				}
			}

		}
	]);

})(window.angular);
