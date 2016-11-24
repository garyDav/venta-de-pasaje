(function(angular){
	'use strict';
	angular.module('pasajesModule').controller('pasajesCtrl',['$scope','pasajesService','clienteService','funcionesService','viajesService',
		function($scope,pasajesService,clienteService,funcionesService,viajesService) {
			$scope.mensaje = '';
			console.log('Entra a pasajesCtrl');
			
			$scope.find = function() {
				var obj = pasajesService.query();
				obj.$promise.then(function(response){
					response.forEach(function(element,index,array) {
						element.fecha = funcionesService.timeVerbal(element.fecha);
					});
					$scope.data = response;
					console.log(response);
				},function(response){
					console.log(response);
				});
			};
			$scope.findCliente = function() {
				var obj = clienteService.query();
				obj.$promise.then(function(response){
					$scope.dataCliente = response;
					console.log(response);
				},function(response){
					console.log(response);
				});
			};
			$scope.findViaje = function() {
				var obj = viajesService.query();
				obj.$promise.then(function(response){
					$scope.dataViaje = response;
					console.log(response);
				},function(response){
					console.log(response);
				});
			};

			$scope.save = function(newD) {
				console.log(newD);
				var obj = new pasajesService(newD);
				obj.$save(function(response) {
					console.log(response);
					var newData = {
						id: response.id,
						nombre: response.nombre,
						apellido: response.apellido,
						horario: response.horario,
						num_asiento: newD.num_asiento,
						ubicacion: newD.ubicacion,
						precio: newD.precio,
						fecha: funcionesService.timeVerbal(response.fecha)
					};
					if( response.error == 'success' ) {
						$scope.mensaje = 'Registro insertado correctamente';
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
