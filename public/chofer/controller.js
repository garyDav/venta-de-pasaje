(function(angular){
	'use strict';
	angular.module('choferModule').controller('choferCtrl',['$scope','choferService',
		function($scope,choferService) {
			$scope.mensaje = '';
			console.log('Entra a choferCtrl');
			
			$scope.find = function() {
				var obj = choferService.query();
				obj.$promise.then(function(response){
					$scope.data = response;
					console.log(response);
				},function(response){
					console.log(response);
				});
			}

			$scope.save = function(newD) {
				var obj = new choferService(newD);
				obj.$save(function(response) {
					var newData = {
						id: response.id,
						ci: newD.ci,
						nombre: newD.nombre,
						apellido: newD.apellido,
						categoria: newD.categoria,
						descripcion: newD.descripcion,
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
					var obj = new choferService({id:id});
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
