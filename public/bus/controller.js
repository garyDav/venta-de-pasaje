(function(angular){
	'use strict';
	angular.module('busModule').controller('busCtrl',['$scope','busService',
		function($scope,busService) {
			$scope.mensaje = '';
			console.log('Entra a busCtrl');
			
			$scope.find = function() {
				var obj = busService.query();
				obj.$promise.then(function(response){
					$scope.data = response;
					console.log(response);
				},function(response){
					console.log(response);
				});
			}

			$scope.save = function(newD) {
				var obj = new busService(newD);
				obj.$save(function(response) {
					if( response.error == 'success' ) {
						var newData = {
							id: response.id,
							placa: newD.placa,
							marca: newD.marca,
							modelo: newD.modelo,
							cilindrada: newD.cilindrada,
							motor: newD.motor,
							combustible: newD.combustible,
							capacidad: newD.capacidad,
							num_puertas: newD.num_puertas,
							tipo: newD.tipo,
							fecha: response.fecha
						};
						console.log(response);
						$scope.mensaje = 'Registro de bus guardado exitosamente.';
						$scope.data.push(newData);
					}
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
					var obj = new busService({id:id});
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
			$scope.edit = function(id) {
				console.log('Edit: '+id);
			}

		}
	]);

})(window.angular);