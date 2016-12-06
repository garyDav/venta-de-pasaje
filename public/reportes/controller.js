(function(angular){
	'use strict';
	angular.module('reportesModule').controller('reportesCtrl',['$scope','funcionesService','$http',
		function($scope,funcionesService,$http) {
			console.log('Enter function controller reportes');
			$scope.save = function(newObj) {
				if(newObj.fecha.length > 10)
					newObj.fecha = funcionesService.convertCadFecha(newObj.fecha);
				$http.post('rest/v1/reportes',newObj).
				success(function(response){
					if(response[0].error == 'No se encontraron ventas en esa fecha') {
						$scope.mensaje = response[0].error;
					} else {
						$scope.mensaje = '';
						$scope.data = response;
						console.log($scope.data);
						var doc = new jsPDF('p','pt','letter');

						var y,rep;
						if( $scope.data.length > 4 ) {
							rep = $scope.data.length/5;
							if (rep % 1 != 0) {
								rep = Math.floor(rep)+1;
							}
						}
						doc.text(300, 35, 'Reporte por fecha', null, null, 'center');
						doc.text(300, 58, 'Transportes Andes Bus', null, null, 'center');
						var img = new Image();
						img.src = 'material/img/andes_bus.jpg';
						doc.addImage(img, 'JPEG', 20, 20, 68, 50);
						var final=5,cont=0,totV=0,totA=0;
						var x = 110;
						for (var i=0;i<rep;i++) {
							y = 50;
							if(i == rep-1) {
								final = $scope.data.length-(i*5);
							}
							for(var j=0;j<final;j++) {
								doc.setFont("helvetica");
								doc.setFontType("bold");
								doc.text(20, y+40, 'Datos del chocher');
								doc.text(20, y+55, 'CI: ');
								doc.text(20, y+70, 'Chofer: ');
								doc.text(20, y+90, 'Datos del cliente');
								doc.text(20, y+105, 'CI: ');
								doc.text(20, y+120, 'Nombre: ');
								doc.text(20, y+135, 'Apellido: ');

								doc.text(400-x, y+40, 'Numero bus: ');
								doc.text(400-x, y+55, 'Horario: ');
								doc.text(400-x, y+70, 'Origen: ');
								doc.text(400-x, y+85, 'Destino: ');
								doc.text(400-x, y+100, 'Precio: ');
								doc.text(400-x, y+115, 'Fecha: ');

								doc.setFont("times");
								doc.setFontType("normal");
								doc.text(45, y+55, $scope.data[cont].ci_chofer);
								doc.text(85, y+70, $scope.data[cont].nombre_chofer);

								doc.text(45, y+105, $scope.data[cont].ci_cliente);
								doc.text(95, y+120, $scope.data[cont].nombre_cliente);
								doc.text(95, y+135, $scope.data[cont].apellido_cliente);

								doc.text(500-x, y+40, $scope.data[cont].num_bus);
								doc.text(470-x, y+55, $scope.data[cont].horario);
								doc.text(470-x, y+70, $scope.data[cont].origen);
								doc.text(470-x, y+85, $scope.data[cont].destino);
								doc.text(470-x, y+100, $scope.data[cont].precio);
								doc.text(460-x, y+115, $scope.data[cont].fecha);
								totV += Number($scope.data[cont].precio);
								totA++;
								cont++;
								y += 140;
								//doc.line(20, 20, 60, 20); // horizontal line
							}
							if(i != rep-1) doc.addPage();
						}

						//Aqui viene los totales >:(
						doc.text(20, 770, 'Total monto Bs: '+totV);
						doc.text(200, 770, 'Pasajes vendidos: '+totA);
						doc.save(newObj.fecha);
					}
				}).
				error(function(msg, code){
					deferred.reject(msg);
				});
			};
		}
	]);

})(window.angular);
