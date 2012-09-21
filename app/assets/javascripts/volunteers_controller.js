function VolunteersCtrl($scope, $http) {
    $http.get('/volunteers.json').success(function(data){
        $scope.volunteers = data;
        console.log(data);
    });
}

