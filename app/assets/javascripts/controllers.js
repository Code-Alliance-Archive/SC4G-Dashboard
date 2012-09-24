function VolunteersListCtrl($scope, $http) {
    $scope.criteria = {};

    $scope.filter = function(){
        init();
    }

    function getParameters(){
        return {name:$scope.criteria.name, company:$scope.criteria.company};
    }

    function init(){
        $http({method:'GET', url:'volunteers.json', params:getParameters()})
            .success(
            function (data) {
                $scope.volunteers = data;
            }
        );
    }

    init();
}
