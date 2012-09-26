function VolunteersListCtrl($scope, $http) {

    <!--$scope.criteria.name -->
    <!--$scope.criteria.company -->
    <!--$scope.criteria.email -->
    $scope.criteria = {};
    $scope.criteria.skills = [{name: 'Project Management / Scrum Master', search_value:'Project_Management', checked:false},
                              {name: 'Software Development', search_value:'Software_Development', checked:false},
                              {name: 'User Interface Design', search_value:'User_Interface_Design', checked:false},
                              {name: 'Product Management', search_value:'Product_Management', checked:false},
                              {name: 'Community Management', search_value:'Community_Management', checked:false},
                              {name: 'Quality Assurance', search_value:'Quality_Assurance', checked:false},
                              {name: 'Systems Administration', search_value:'Systems_Administration', checked:false},
                              {name: 'Technical Documentation', search_value:'Technical_Documentation', checked:false},
                              {name: 'Technical Support', search_value:'Technical_Support', checked:false}];

    <!--skills[]="aaa"&skills[]="bbb"-->
    <!-- volunteers?utf8=✓&name=&email=&company=&commit=Filter&skills%5B%5D=Product_Management -->

    $scope.filter = function(){
        init();
    }

    function init(){
        $http({method:'GET', url:urlCreater($scope.criteria)})
            .success(
            function (data) {
                $scope.volunteers = data;
            }
        );
    }

    function urlCreater(element){
        var name1 = element.name;
        var company = element.company;
        var email = element.email;
        var skills = element.skills;
        console.log(skills[1].checked);
        url_string = new String('volunteers.json?name=');
        if (name1 != undefined){
            url_string = url_string + name1;
        }
        if (company != undefined ){
            url_string = url_string + '&company=' + company;
        }
        if (email != undefined ){
            url_string = url_string + '&email=' + email;
        }

        skill_length = skills.length;
        for (var i = 0; i < skills.length; i++){
            if (skills[i].checked == true) {
                url_string = url_string + '&skills[]=' + skills[i].search_value;
            }
        }

        return url_string;

    }

    function isChecked(elem, index, array){
        return elem.checked;
    }

    function mapElemToSearchValue(elem){
        return elem.search_value;
    }

    function getSkills(skills){
        return skills.filter(isChecked).map(mapElemToSearchValue);
    }

    function getParameters(criteria){
        console.log(getSkills(criteria.skills));
        return {name:criteria.name, company:criteria.company, 'skills[]':getSkills(criteria.skills)};
    }






    init();
}
