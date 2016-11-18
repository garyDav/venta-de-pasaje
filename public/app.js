//Uso del modo strict de JavaScript
'use strict';

//Variable global mainApplicationModuleName donde carga el modulo principal
var mainApplicationModuleName = 'ventaPasajes';
var mainApplicationModule = angular.module(mainApplicationModuleName, ['ngResource','ngRoute','mainModule','LocalStorageModule','angular-loading-bar','ngAnimate']);

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
	var routespermission = ['/','/login','/admin','/user'];
	$rootScope.$on('$routeChangeStart',function() {
		if( routespermission.indexOf($location.path()) != -1 && loginService.isLogged() ) {
			if( sessionService.get('user') == 'admin' )
				$rootScope.c_admin = true;
			if( sessionService.get('user') == 'user' )
				$rootScope.c_user = true;
			console.log($rootScope.c_admin);
			console.log($rootScope.c_user);
		}
	});
});


angular.element(document).ready(function() {
	angular.bootstrap(document, [mainApplicationModuleName]);
});
