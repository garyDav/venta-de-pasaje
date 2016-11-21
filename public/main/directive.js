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
	}).directive('fileModel',['$parse',function($parse) {
		return {
			restrict: 'A',
			link: function(scope, iElement, iAttrs) {
				iElement.on('change',function(e) {
					$parse(iAttrs.fileModel).assign(scope,iElement[0].files[0]);
				});
			}
		};
	}]);


})(window.angular);