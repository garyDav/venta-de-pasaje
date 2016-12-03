//Uso del modo strict de JavaScript
'use strict';

//Variable global mainApplicationModuleName donde carga el modulo principal
var mainApplicationModuleName = 'ventaPasajes';
var mainApplicationModule = angular.module(mainApplicationModuleName, ['ngResource','ngRoute','mainModule','busModule','choferModule','clienteModule','pasajesModule','viajesModule','reportesModule','LocalStorageModule','angular-loading-bar','ngAnimate']);

mainApplicationModule.config(['$locationProvider',function($locationProvider) {
	$locationProvider.html5Mode(true);
}]);

mainApplicationModule.config(['localStorageServiceProvider',function(localStorageServiceProvider){
	localStorageServiceProvider.setPrefix('ventaPasajes');
}]);

mainApplicationModule.config(['cfpLoadingBarProvider', function(cfpLoadingBarProvider) {
    cfpLoadingBarProvider.includeSpinner = true;
}]);

mainApplicationModule.run(function($rootScope,$location,sessionService,loginService) {
	var routespermission = ['/','/reportes','/buses','/viajes','/login','/registrar/buses','/editar/bus/:id','/registrar/choferes','/editar/chofer/:id','/registrar/pasajes','/editar/pasaje/:id','/registrar/viajes','/editar/viaje/:id','/registrar/clientes','/editar/cliente/:id'];
	$rootScope.$on('$routeChangeStart',function() {
		if( routespermission.indexOf($location.path()) != -1 ) {
			if( $location.path() == '/registrar/buses' || $location.path() == '/editar/bus/:id' || $location.path() == '/registrar/choferes' || $location.path() == '/editar/chofer/:id' || $location.path() == '/registrar/pasajes' || $location.path() == '/editar/pasaje/:id' || $location.path() == '/registrar/viajes' || $location.path() == '/editar/viaje/:id' || $location.path() == '/registrar/clientes' || $location.path() == '/editar/cliente/:id' || $location.path() == '/reportes' )
				if( !loginService.isLogged() )
					$location.path('/');
			if( sessionService.get('user') == 'admin' )
				$rootScope.c_admin = true;
			if( sessionService.get('user') == 'user' )
				$rootScope.c_user = true;
			/*console.log($rootScope.c_admin);
			console.log($rootScope.c_user);*/
		}
	});
});


angular.element(document).ready(function() {
	angular.bootstrap(document, [mainApplicationModuleName]);
});
