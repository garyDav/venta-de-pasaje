(function(angular){

	'use strict';
	angular.module('mainModule').directive('navDirective',function(){
		return {
			templateUrl: 'public/main/views/navegacion.view.html'
		};
	}).directive('footerDirective',function(){
		return {
			templateUrl: 'public/main/views/footer.view.html'
		};
	});


})(window.angular);