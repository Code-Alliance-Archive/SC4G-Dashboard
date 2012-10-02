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

    $scope.criteria.orgs_interested_in = [{name: 'Benetech', search_value:'Benetech', checked:false},
        {name: 'Code for America', search_value:'Code_for_America', checked:false},
        {name: 'FrontlineSMS', search_value:'FrontlineSMS', checked:false},
        {name: 'The guardian project', search_value:'The_guardian_project', checked:false},
        {name: 'Mozilla Webmaker', search_value:'Mozilla_Webmaker', checked:false},
        {name: 'Amara(Universal subtitles)', search_value:'Amara(Universal subtitles)', checked:false},
        {name: 'Wikimedia foundation', search_value:'Wikimedia_foundation', checked:false}];

    $scope.criteria.causes_interested_in = [{name: 'Self Sufficiency for People with Disabilities', search_value:'Self_Sufficiency_for_People_with_Disabilities', checked:false},
        {name: 'Poverty Alleviation', search_value:'Poverty_Alleviation', checked:false},
        {name: 'Human Rights', search_value:'Human_Rights', checked:false},
        {name: 'Homelessness', search_value:'Homelessness', checked:false},
        {name: 'Healthcare', search_value:'Healthcare', checked:false},
        {name: 'Environmental and Species Conservation', search_value:'Environmental_and_Species_Conservation', checked:false},
        {name: 'Empowerment of Women', search_value:'Empowerment_of_Women', checked:false},
        {name: 'Education and Literacy', search_value:'Education_and_Literacy', checked:false},
        {name: 'Disaster Relief', search_value:'Disaster_Relief', checked:false},
        {name: 'Climate Change Mitigation', search_value:'Climate_Change_Mitigation', checked:false},
        {name: 'Civic Engagement', search_value:'Civic_Engagement', checked:false}];

    $scope.criteria.languages_interested_in = [{name: 'C', search_value:'C', checked:false},
        {name: 'C++', search_value:'C++', checked:false},
        {name: 'C#', search_value:'C#', checked:false},
        {name: 'HTML/CSS', search_value:'HTML/CSS', checked:false},
        {name: 'Java', search_value:'Java', checked:false},
        {name: 'Java on Android', search_value:'Java_on_Android', checked:false},
        {name: 'Javascript', search_value:'Javascript', checked:false},
        {name: 'Objective C', search_value:'Objective_C', checked:false},
        {name: 'Objective C on iPhone', search_value:'Objective_C_on_iPhone', checked:false},
        {name: 'Perl', search_value:'Perl', checked:false},
        {name: 'PHP', search_value:'PHP', checked:false},
        {name: 'Python', search_value:'Python', checked:false},
        {name: 'Ruby', search_value:'Ruby', checked:false},
        {name: 'Scala', search_value:'Scala', checked:false}];


    $scope.criteria.time_selected = "";
    $scope.criteria.time_to_commit = [{name: 'A few hours per week', search_value:'A_few_hours_per_week'},
        {name: 'A few hours per month', search_value:'A_few_hours_per_month'},
        {name: '0 to 8 hours', search_value:'0_to_8_hours'},
        {name: '8 to 20 hours', search_value:'8_to_20_hours'}];

    $scope.criteria.open_source_answer = "";
    $scope.criteria.open_source_projects = [{name: 'Yes', search_value:'yes'},
        {name: 'No', search_value:'no'},
        {name: 'Either', search_value:'either'}];


    $scope.reset = function(){
        var element = $scope.criteria;
        element.name = "";
        element.company = "";
        element.email = "";
        var skills = element.skills;
        for (var i = 0; i < skills.length; i++){
            skills[i].checked=false;
        }
        var orgs = element.orgs_interested_in;
        for (var i = 0; i < orgs.length; i++){
            orgs[i].checked=false;
        }
        var causes = element.causes_interested_in;
        for (var i = 0; i < causes.length; i++){
            causes[i].checked=false;
        }
        var languages = element.languages_interested_in;
        for (var i = 0; i < languages.length; i++){
            languages[i].checked=false;
        }
        element.time_selected = "";
        element.open_source_answer = "";
    }

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
        var orgs_interested_in = element.orgs_interested_in;
        var causes_interested_in = element.causes_interested_in;
        var languages_interested_in = element.languages_interested_in;
        var time_selected = element.time_selected;
        var open_source_projects = element.open_source_answer;

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
        if (time_selected != undefined && time_selected.length != 0) {
            url_string = url_string + '&time_to_commit=' + time_selected;
        }
        console.log(open_source_projects)

        if (open_source_projects != undefined && open_source_projects != 'either' && open_source_projects.length != 0) {
            url_string = url_string + '&open_source_projects=' + open_source_projects;
        }

        skill_length = skills.length;
        for (var i = 0; i < skills.length; i++){
            if (skills[i].checked == true) {
                url_string = url_string + '&skills[]=' + skills[i].search_value;
            }
        }

        org_length = orgs_interested_in.length;
        for (var i = 0; i < orgs_interested_in.length; i++){
            if (orgs_interested_in[i].checked == true) {
                url_string = url_string + '&orgs_interested_in[]=' + orgs_interested_in[i].search_value;
            }
        }

        cause_length = causes_interested_in.length;
        for (var i = 0; i < causes_interested_in.length; i++){
            if (causes_interested_in[i].checked == true) {
                url_string = url_string + '&causes_interested_in[]=' + causes_interested_in[i].search_value;
            }
        }

        language_length = languages_interested_in.length;
        for (var i = 0; i < languages_interested_in.length; i++){
            if (languages_interested_in[i].checked == true) {
                url_string = url_string + '&languages_interested_in[]=' + languages_interested_in[i].search_value;
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

    init();
}
