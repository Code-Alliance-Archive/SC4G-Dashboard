  require 'spec_helper'

describe "Volunteer" do
  before(:all) do
    2.times {FactoryGirl.create(:ws_first_name)}
    2.times {FactoryGirl.create(:ws_last_name)}
    2.times {FactoryGirl.create(:ws_email)}
  end

  after(:all) do
    WebformSubmittedData.delete_all
  end

  describe "company" do
    before(:each) do
      FactoryGirl.create(:ws_company)
      Volunteer.create(:name => "FirstName_1 LastName_1", :email => "Person_1@example.com", :id => 1)
    end

    it "should return the amount of time the volunteer is willing to commit" do
      @volunteer = Volunteer.find(1)


      @volunteer.name.should == "FirstName_1 LastName_1"
      @volunteer.company_db.data.should == "Company_1"
      @volunteer.company.should == "Company_1"
    end
  end

  describe "time_to_commit" do
    before(:each) do
      FactoryGirl.create(:ws_time_to_commit_few_hours_week)
      Volunteer.create(:name => "FirstName_1 LastName_1", :email => "Person_1@example.com", :id => 1)
    end

    it "should return the amount of time the volunteer is willing to commit" do
      @volunteer = Volunteer.find(1)

      @volunteer.name.should == "FirstName_1 LastName_1"
      @volunteer.time_to_commit_db.data.should == "A_Few_Hours_per_Week"
      @volunteer.time_to_commit.should == "A Few Hours per Week"
    end
  end

  describe "time_submitted" do
    before(:each) do
      FactoryGirl.create(:ws_time_submitted, :submitted => 1311789532)
      Volunteer.create(:name => "FirstName_1 LastName_1", :email => "Person_1@example.com", :id => 1)
    end

    it "should return the time the volunteer submitted their info" do
      @volunteer = Volunteer.find(1)

      @volunteer.name.should == "FirstName_1 LastName_1"
      @volunteer.time_submitted.should == Time.at(1311789532).to_datetime
    end
  end

  describe "organizations_interested_in" do
    before(:each) do
      FactoryGirl.create(:ws_org_interested_in_Benetech)
      FactoryGirl.create(:ws_org_interested_in_FrontlineSMS)
      Volunteer.create(:name => "FirstName_1 LastName_1", :email => "Person_1@example.com", :id => 1)
    end

    it "should return array of organizations the volunteer is interested in" do
      @volunteer = Volunteer.find(1)

      @volunteer.name.should == "FirstName_1 LastName_1"
      @volunteer.orgs_interested_in.count.should == 2
      @volunteer.orgs_interested_in_db[0].data.should == "Benetech"
      @volunteer.orgs_interested_in_db[1].data.should == "FrontlineSMS"
      @volunteer.orgs_interested_in[0].should == "Benetech"
      @volunteer.orgs_interested_in_db[1].data.should == "FrontlineSMS"
    end
  end

  describe "causes_interested_in" do
    before(:each) do
      FactoryGirl.create(:ws_causes_interested_in_Healthcare)
      FactoryGirl.create(:ws_causes_interested_in_Disaster_Relief)
      Volunteer.create(:name => "FirstName_1 LastName_1", :email => "Person_1@example.com", :id => 1)
    end

    it "should return array of causes the volunteer is interested in" do
      @volunteer = Volunteer.find(1)

      @volunteer.name.should == "FirstName_1 LastName_1"
      @volunteer.causes_interested_in.count.should == 2
      @volunteer.causes_interested_in_db[0].data.should == "Healthcare"
      @volunteer.causes_interested_in[0].should == "Healthcare"
      @volunteer.causes_interested_in_db[1].data.should == "Disaster_Relief"
      @volunteer.causes_interested_in[1].should == "Disaster Relief"
    end
  end

  describe "languages_interested_in" do
    before(:each) do
      FactoryGirl.create(:ws_languages_interested_in_Ruby)
      FactoryGirl.create(:ws_languages_interested_in_Java_on_Android)
      Volunteer.create(:name => "FirstName_1 LastName_1", :email => "Person_1@example.com", :id => 1)
    end

    it "should return array of languages the volunteer is interested in" do
      @volunteer = Volunteer.find(1)

      @volunteer.name.should == "FirstName_1 LastName_1"
      @volunteer.languages_interested_in.count.should == 2
      @volunteer.languages_interested_in_db[0].data.should == "Ruby"
      @volunteer.languages_interested_in[0].should == "Ruby"
      @volunteer.languages_interested_in_db[1].data.should == "Java_on_Android"
      @volunteer.languages_interested_in[1].should == "Java on Android"
    end
  end

  describe "skills" do
    before(:each) do
      FactoryGirl.create(:ws_skills_Product_Management)
      FactoryGirl.create(:ws_skills_User_Interface_Design)
      Volunteer.create(:name => "FirstName_1 LastName_1", :email => "Person_1@example.com", :id => 1)
    end

    it "should return array of skills the volunteer is interested in" do
      @volunteer = Volunteer.find(1)

      @volunteer.name.should == "FirstName_1 LastName_1"
      @volunteer.skills.count.should == 2
      @volunteer.skills_db[0].data.should == "Product_Management"
      @volunteer.skills[0].should == "Product Management"
      @volunteer.skills_db[1].data.should == "User_Interface_Design"
      @volunteer.skills[1].should == "User Interface Design"
    end
  end

  describe "open_source_projects" do
    before(:each) do
      FactoryGirl.create(:ws_open_source_projects_yes, sid: 1)
      Volunteer.create(:name => "FirstName_1 LastName_1", :email => "Person_1@example.com", :id => 1)

      Volunteer.create(:name => "FirstName_2 LastName_2", :email => "Person_2@example.com", :id => 2)
      FactoryGirl.create(:ws_open_source_projects_no, sid: 2)
    end

    it "should return yes if volunteer has contributed to open source projects" do
      @volunteer = Volunteer.find(1)

      @volunteer.name.should == "FirstName_1 LastName_1"
      @volunteer.open_source_projects_db.data.should == "yes"
      @volunteer.open_source_projects.should == "yes"
    end

    it "should return no if volunteer has contributed to open source projects" do
      @volunteer = Volunteer.find(2)

      @volunteer.name.should == "FirstName_2 LastName_2"
      @volunteer.open_source_projects_db.data.should == "no"
      @volunteer.open_source_projects.should == "no"
    end
  end

  describe "open_source_projects?" do
    before(:each) do
      Volunteer.create(:name => "FirstName_1 LastName_1", :email => "Person_1@example.com", :id => 1)
      FactoryGirl.create(:ws_open_source_projects_yes, sid: 1)

      Volunteer.create(:name => "FirstName_2 LastName_2", :email => "Person_2@example.com", :id => 2)
      FactoryGirl.create(:ws_open_source_projects_no, sid: 2)
    end

    it "should return true if volunteer has contributed to open source projects" do
      @volunteer = Volunteer.find(1)

      @volunteer.name.should == "FirstName_1 LastName_1"
      @volunteer.open_source_projects?.should be_true
    end

    it "should return false if volunteer has contributed to open source projects" do
      @volunteer = Volunteer.find(2)

      @volunteer.name.should == "FirstName_2 LastName_2"
      @volunteer.open_source_projects?.should be_false
    end
  end

  describe 'nil attributes should return N/A' do

    before(:each) do
      Volunteer.create(:name => "FirstName_1 LastName_1", :email => "Person_1@example.com", :id => 1)
    end

    it "company organization should return N/A if nil" do
      @volunteer = Volunteer.find(1)

      @volunteer.company.should == "N/A"
    end

    it "organizations_interested_in should return N/A if nil" do
      @volunteer = Volunteer.find(1)

      @volunteer.orgs_interested_in[0].should == 'N/A'
    end

    it "causes_interested_in should return N/A if nil" do
      @volunteer = Volunteer.find(1)

      @volunteer.causes_interested_in[0].should == "N/A"
    end

    it "open_source_projects should return N/A if nil" do
      @volunteer = Volunteer.find(1)

      @volunteer.open_source_projects.should == "N/A"
    end
  end
end

