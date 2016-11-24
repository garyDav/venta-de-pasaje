(function(angular){
	'use strict';
	angular.module('viajesModule').controller('viajesCtrl',['$scope','viajesService','choferService','busService','funcionesService',
		function($scope,viajesService,choferService,busService,funcionesService) {
			$scope.mensaje = '';
			console.log('Entra a viajesCtrl');
			
			$scope.find = function() {
				var obj = viajesService.query();
				obj.$promise.then(function(response){
					response.forEach(function(element,index,array) {
						element.fecha = funcionesService.timeVerbal(element.fecha);
					});
					$scope.data = response;
					console.log(response);
				},function(response){
					console.log(response);
				});
			}
			$scope.findChofer = function() {
				var obj = choferService.query();
				obj.$promise.then(function(response){
					$scope.dataChofer = response;
					console.log(response);
				},function(response){
					console.log(response);
				});
			};
			$scope.findBus = function() {
				var obj = busService.query();
				obj.$promise.then(function(response){
					$scope.dataBus = response;
					console.log(response);
				},function(response){
					console.log(response);
				});
			};
			$scope.save = function(newD) {
				var obj = new viajesService(newD);
				obj.$save(function(response) {
					console.log(response);
					var newData = {
						id: response.id,
						nameChofer: response.nameChofer,
						numBus: response.numBus,
						horario: newD.horario,
						origen: newD.origen,
						destino: newD.destino,
						fecha: funcionesService.timeVerbal(response.fecha)
					};
					if( response.error == 'success' ) {
						$scope.mensaje = 'Registro insertado correctamente';
						console.log(newData);
						$scope.data.push(newData);
					} else {
						$scope.mensaje = response.error;
					}
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