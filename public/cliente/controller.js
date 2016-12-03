(function(angular){
	'use strict';
	angular.module('clienteModule').controller('clienteCtrl',['$scope','clienteService','funcionesService',
		function($scope,clienteService,funcionesService) {
			$scope.mensaje = '';
			console.log('Entra a clienteCtrl');
			
			$scope.find = function() {
				var obj = clienteService.query();
				obj.$promise.then(function(response){
					response.forEach(function(element,index,array) {
						element.fecha_nac = funcionesService.fecha(element.fecha_nac);
						element.fecha = funcionesService.timeVerbal(element.fecha);
					});
					$scope.data = response;
					console.log(response);
				},function(response){
					console.log(response);
				});
			}

			$scope.save = function(newD) {
				newD.fecha_nac = funcionesService.convertCadFecha(newD.fecha_nac);
				var obj = new clienteService(newD);
				obj.$save(function(response) {
					if( response.error == 'success' ) {
						var newData = {
							id: response.id,
							ci: newD.ci,
							nombre: newD.nombre,
							apellido: newD.apellido,
							fecha_nac: funcionesService.fecha(newD.fecha_nac),
							fecha: funcionesService.timeVerbal(response.fecha)
						};
						$scope.mensaje = 'Registro insertado correctamente';
						$segurocope.data.push(newData);
					} else {
						$scope.mensaje = response.error;
					}
				},function(response) {
					console.log(response);
				});
			}
			$scope.cancel = function() {
				$scope.new = {};
			}
			$scope.delete = function(id) {
				var remove = confirm('¿Está seguro de eliminar el registro?');
				if( remove ) {
					var obj = new clienteService({id:id});
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