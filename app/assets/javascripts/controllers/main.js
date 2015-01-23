window.mainApp = angular.module('mainApp', ['ngMessages']);

mainApp.config(['$httpProvider', function($httpProvider){
  var csrfToken = angular.element('meta[name=csrf-token]').attr('content');

  $httpProvider.defaults.headers.common.Accept = 'application/json';
  $httpProvider.defaults.headers.post['X-CSRF-Token'] = csrfToken;
}]);
