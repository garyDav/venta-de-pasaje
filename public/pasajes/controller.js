(function(angular){
	'use strict';
	angular.module('pasajesModule').controller('pasajesCtrl',['$scope','pasajesService','clienteService','funcionesService','viajesService',
		function($scope,pasajesService,clienteService,funcionesService,viajesService) {
			$scope.mensaje = '';
			console.log('Entra a pasajesCtrl');
			
			var initSelect = function() {
				$("#1").prop("checked", "");
				$("#2").prop("checked", "");
				$("#3").prop("checked", "");
				$("#4").prop("checked", "");
				$("#5").prop("checked", "");
				$("#6").prop("checked", "");
				$("#7").prop("checked", "");
				$("#8").prop("checked", "");
				$("#9").prop("checked", "");
				$("#10").prop("checked", "");
				$("#11").prop("checked", "");
				$("#12").prop("checked", "");
				$("#13").prop("checked", "");
				$("#14").prop("checked", "");
				$("#15").prop("checked", "");
				$("#16").prop("checked", "");
				$("#17").prop("checked", "");
				$("#18").prop("checked", "");
				$("#19").prop("checked", "");
				$("#20").prop("checked", "");
				$("#21").prop("checked", "");
				$("#22").prop("checked", "");
				$("#23").prop("checked", "");
				$("#24").prop("checked", "");
				$("#25").prop("checked", "");
				$("#26").prop("checked", "");
				$("#27").prop("checked", "");
				$("#28").prop("checked", "");
				$("#29").prop("checked", "");
				$("#30").prop("checked", "");
				$("#31").prop("checked", "");
				$("#32").prop("checked", "");
				$("#33").prop("checked", "");
				$("#34").prop("checked", "");
				$("#35").prop("checked", "");
				$("#36").prop("checked", "");
				$("#37").prop("checked", "");
				$("#38").prop("checked", "");
				$("#39").prop("checked", "");
				$("#40").prop("checked", "");
				$("#41").prop("checked", "");
				$("#42").prop("checked", "");
				$("#43").prop("checked", "");
				$("#44").prop("checked", "");
				$("#45").prop("checked", "");
				$("#46").prop("checked", "");
			};

			$scope.cambioViaje = function(id) {
				initSelect();
				var obj = pasajesService.query();
				obj.$promise.then(function(response){
					response.forEach(function(element,index,array) {
						if(element.id_viaje == id) {
							switch(element.num_asiento) {
								case '1':
									$("#1").prop("checked", "checked");
									break;
								case '2':
									$("#2").prop("checked", "checked");
									break;
								case '3':
									$("#3").prop("checked", "checked");
									break;
								case '4':
									$("#4").prop("checked", "checked");
									break;
								case '5':
									$("#5").prop("checked", "checked");
									break;
								case '6':
									$("#6").prop("checked", "checked");
									break;
								case '7':
									$("#7").prop("checked", "checked");
									break;
								case '8':
									$("#8").prop("checked", "checked");
									break;
								case '9':
									$("#9").prop("checked", "checked");
									break;
								case '10':
									$("#10").prop("checked", "checked");
									break;
								case '11':
									$("#11").prop("checked", "checked");
									break;
								case '12':
									$("#12").prop("checked", "checked");
									break;
								case '13':
									$("#13").prop("checked", "checked");
									break;
								case '14':
									$("#14").prop("checked", "checked");
									break;
								case '15':
									$("#15").prop("checked", "checked");
									break;
								case '16':
									$("#16").prop("checked", "checked");
									break;
								case '17':
									$("#17").prop("checked", "checked");
									break;
								case '18':
									$("#18").prop("checked", "checked");
									break;
								case '19':
									$("#19").prop("checked", "checked");
									break;
								case '20':
									$("#20").prop("checked", "checked");
									break;
								case '21':
									$("#21").prop("checked", "checked");
									break;
								case '22':
									$("#22").prop("checked", "checked");
									break;
								case '23':
									$("#23").prop("checked", "checked");
									break;
								case '24':
									$("#24").prop("checked", "checked");
									break;
								case '25':
									$("#25").prop("checked", "checked");
									break;
								case '26':
									$("#26").prop("checked", "checked");
									break;
								case '27':
									$("#27").prop("checked", "checked");
									break;
								case '28':
									$("#28").prop("checked", "checked");
									break;
								case '29':
									$("#29").prop("checked", "checked");
									break;
								case '30':
									$("#30").prop("checked", "checked");
									break;
								case '31':
									$("#31").prop("checked", "checked");
									break;
								case '32':
									$("#32").prop("checked", "checked");
									break;
								case '33':
									$("#33").prop("checked", "checked");
									break;
								case '34':
									$("#34").prop("checked", "checked");
									break;
								case '35':
									$("#35").prop("checked", "checked");
									break;
								case '36':
									$("#36").prop("checked", "checked");
									break;
								case '37':
									$("#37").prop("checked", "checked");
									break;
								case '38':
									$("#38").prop("checked", "checked");
									break;
								case '39':
									$("#39").prop("checked", "checked");
									break;
								case '40':
									$("#40").prop("checked", "checked");
									break;
								case '41':
									$("#41").prop("checked", "checked");
									break;
								case '42':
									$("#42").prop("checked", "checked");
									break;
								case '43':
									$("#43").prop("checked", "checked");
									break;
								case '44':
									$("#44").prop("checked", "checked");
									break;
								case '45':
									$("#45").prop("checked", "checked");
									break;
								case '46':
									$("#46").prop("checked", "checked");
									break;
							}
						}
						
					});
				},function(response){
					console.log(response);
				});
				console.log('cambio mi select: '+id);
			};

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
					if( response.error == 'success' ) {
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
						$scope.mensaje = 'Registro insertado correctamente';
						$scope.data.push(newData);
					} else {
						$scope.mensaje = response.error;
					}
				},function(response) {
					console.log(response);
				});
				$scope.new = {};
			}
			$scope.cancel = function() {
				$scope.new = {};
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
			};
			$scope.imprimir = function(id) {
				var obj = pasajesService.get({id: id});
				obj.$promise.then(
					function(response) {
						$scope.one_data = response;
						console.log($scope.one_data);
						$scope.one_data.fecha = funcionesService.timeVerbal($scope.one_data.fecha);

						var doc = new jsPDF('p','pt','letter');

						var img = new Image();
						img.src = 'material/img/imprimir.jpg';
						doc.addImage(img, 'jpg', 20, 20, 68, 50);
						doc.setFontSize(22);
						doc.text(300, 35, 'Reporte de pasaje', null, null, 'center');
						doc.text(300, 58, 'Transportes Andes Bus', null, null, 'center');

						var x = 50;
						doc.setFontSize(14);
						doc.setFont("helvetica");
						doc.setFontType("bold");
						doc.text(80-x, 100, 'Nombre: ');
						doc.text(80-x, 130, 'Apellido: ');
						doc.text(80-x, 160, 'Asiento: ');
						doc.text(400-x, 100, 'Ubicacion: ');
						doc.text(400-x, 130, 'Precio: ');
						doc.text(400-x, 160, 'Fecha: ');

						doc.setFont("times");
						doc.setFontType("normal");
						doc.text(145-x, 100, $scope.one_data.nombre);
						doc.text(145-x, 130, $scope.one_data.apellido);
						doc.text(142-x, 160, $scope.one_data.num_asiento);
						doc.text(478-x, 100, $scope.one_data.ubicacion);
						doc.text(450-x, 130, $scope.one_data.precio);
						doc.text(450-x, 160, $scope.one_data.fecha);

						doc.save($scope.one_data.fecha);
					}
				);
			};

		}
	]);

})(window.angular);
