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


angular.element(document).ready(function() {
	angular.bootstrap(document, [mainApplicationModuleName]);
});
