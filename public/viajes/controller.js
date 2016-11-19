(function(angular){
	'use strict';
	angular.module('viajesModule').controller('viajesCtrl',['$scope','viajesService',
		function($scope,viajesService) {
			$scope.mensaje = '';
			console.log('Entra a viajesCtrl');
			
			$scope.find = function() {
				var obj = viajesService.query();
				obj.$promise.then(function(response){
					$scope.data = response;
					console.log(response);
				},function(response){
					console.log(response);
				});
			}

			$scope.save = function(newD) {
				var obj = new viajesService(newD);
				obj.$save(function(response) {
					var newData = {
						id: response.id,
						id_chofer: newD.id_chofer,
						id_bus: newD.id_bus,
						horario: newD.horario,
						origen: newD.origen,
						destino: newD.destino,
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
					var obj = new viajesService({id:id});
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