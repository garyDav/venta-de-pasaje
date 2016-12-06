(function(angular){
	'use strict';
	angular.module('choferModule').controller('choferCtrl',['$scope','choferService','funcionesService','upload',
		function($scope,choferService,funcionesService,upload) {
			$scope.mensaje = '';
			console.log('Entra a choferCtrl');
			
			$scope.find = function() {
				var obj = choferService.query();
				obj.$promise.then(function(response){
					response.forEach(function(element,index,array) {
						element.fecha = funcionesService.timeVerbal(element.fecha);
						element.fecha_nac = funcionesService.fecha(element.fecha_nac);
					});

					$scope.data = response;
					console.log(response);
				},function(response){
					console.log(response);
				});
			}

			$scope.save = function(newObj) {
				var img = '';
				var msg = '';
				upload.saveImg($scope.file).then(function(response) {
					console.log(response);
					if(response) {
						img = response.src;
						msg = response.msg;
						newObj.img = img;

						newObj.fecha_nac = funcionesService.convertCadFecha(newObj.fecha_nac);
						var obj = new choferService(newObj);
						obj.$save(function(response) {
							var newData = {
								id: response.id,
								ci: newObj.ci,
								nombre: newObj.nombre,
								apellido: newObj.apellido,
								categoria: newObj.categoria,
								descripcion: newObj.descripcion,
								celular: newObj.celular,
								fecha_nac: funcionesService.fecha(newObj.fecha_nac),
								img: newObj.img,
								fecha: funcionesService.timeVerbal(response.fecha)
							};
							console.log(response);
							if( response.error == 'success' ) {
								$scope.mensaje = 'Registro insertado correctamente e '+msg;
								$scope.data.push(newData);
							} else {
								$scope.mensaje = response.error;
							}
							console.log($scope.data);
						},function(response) {
							console.log(response);
						});
						console.log(newObj);
					}
				});
				$scope.newObj = {};
			}
			$scope.cancel = function() {
				$scope.newObj = {};
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
