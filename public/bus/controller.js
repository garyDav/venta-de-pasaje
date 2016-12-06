(function(angular){
	'use strict';
	angular.module('busModule').controller('busCtrl',['$scope','busService','funcionesService','upload','$location','$routeParams',
		function($scope,busService,funcionesService,upload,$location,$routeParams) {
			$scope.mensaje = '';
			console.log('Entra a busCtrl');
			
			$scope.find = function() {
				var obj = busService.query();
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
			$scope.findOne = function() {
				var obj = busService.get({id: $routeParams.id});
				obj.$promise.then(
					function(response) {
						$scope.one_data = response;
						console.log($scope.one_data);
					}
				);
			};

			$scope.save = function(newObj) {
				var img = '';
				var msg = '';
				upload.saveImg($scope.file).then(function(response) {
					console.log(response);
					if(response) {
						img = response.src;
						msg = response.msg;
						newObj.img = img;

						var obj = new busService(newObj);
						obj.$save(function(response) {
							var newData = {
								id: response.id,
								img: newObj.img,
								placa: newObj.placa,
								marca: newObj.marca,
								num: newObj.num,
								color: newObj.color,
								capacidad: newObj.capacidad,
								tipo: newObj.tipo,
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
				$scope.new = {};
			}
			$scope.editSave = function(editObj) {
				var obj = new busService(editObj);
				console.log(editObj);
				obj.$update(function(response) {
					console.log(response);
				});
			};
			$scope.editCancel = function() {
				//console.log('Entra editCancel');
				$scope.one_data = {};
				$location.path('/bus');
			};
			$scope.cancel = function() {
				$scope.new = {};
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
				$location.path('editar/bus/'+id);
			}

		}
	]);

})(window.angular);