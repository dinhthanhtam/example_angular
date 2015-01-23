mainApp.controller('BookIndexCtrl', function ($scope, $http) {
  $scope.title = "Loading books...";

  function loadBooks() {
    $http.get('/books.json').
      success(function(data, status, headers, config) {
        $scope.books = data;
      }).
      error(function(data, status, headers, config) {
        // log error
      });
    $scope.title = "Books"
  }

  loadBooks();

  $scope.editItem = function (item) {
    $scope.new_book = {
        id: item.id,
        title: item.title,
        author: item.author
    };
  }

  $scope.updateItem = function (item) {
    //Defining $http service for updating a person
    $http({
        method: 'PUT',
        url: '/books/' + item.id,
        data: JSON.stringify(item),
        headers: { 'Content-Type': 'application/JSON' }
    }).
    success(function (data) {
        //Showing Success message
        $scope.status = "The Book Updated Successfully!!!";
        //Loading people to the $scope
        GetPersons();
        //Displaying save button
        $scope.DisplaySave = true;
        //Hiding Update button
        $scope.DisplayUpdate = false;
    })
    .error(function (error) {
        //Showing error message
        $scope.status = 'Unable to update a Book: ' + error.message;
    });
  }
});