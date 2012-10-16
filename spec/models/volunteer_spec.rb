require 'spec_helper'


def create_a_volunteer
  Volunteer.create(:name => "FirstName_1 LastName_1", :email => "Person_1@example.com", :id => 1 )
end

def create_a_valid_password
  "t"*11
end

def create_a_second_valid_volunteer
  Volunteer.create(:name => "FirstName_2 LastName_2", :email => "Person_2@example.com", :id => 2)
end

describe "Volunteer" do
  before(:all) do
    2.times { FactoryGirl.create(:ws_first_name) }
    2.times { FactoryGirl.create(:ws_last_name) }
    2.times { FactoryGirl.create(:ws_email) }
  end

  after(:all) do
    WebformSubmittedData.delete_all
  end

  describe "company" do
    before(:each) do
      FactoryGirl.create(:ws_company)
      create_a_volunteer
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
      create_a_volunteer
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
      create_a_volunteer
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
      create_a_volunteer()
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
      create_a_volunteer()
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
      create_a_volunteer
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
      create_a_volunteer
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
      create_a_volunteer


      create_a_second_valid_volunteer

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
      create_a_volunteer
      FactoryGirl.create(:ws_open_source_projects_yes, sid: 1)

      create_a_second_valid_volunteer
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
      create_a_volunteer
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

  #describe "we should have a password for a user to log in" do
  #  before do
  #    @volunteer = create_a_volunteer
  #  end
  #
  #  it "define interface" do
  #    subject { @volunteer }
  #    @volunteer.should respond_to(:email)
  #    @volunteer.should respond_to(:password)
  #    @volunteer.should respond_to(:password_digest)
  #    @volunteer.should respond_to(:password_confirmation)
  #  end
  #
  #  it "verify that user with password is valid" do
  #    @volunteer.should be_valid()
  #  end
  #
  #  describe "when password is not present" do
  #    before { @volunteer.password = @volunteer.password_confirmation = " " }
  #    it { @volunteer.should_not be_valid }
  #  end
  #
  #  describe "when password doesn't match confirmation" do
  #    before { @volunteer.password_confirmation = "mismatch" }
  #    it { @volunteer.should_not be_valid }
  #  end
  #
  #  describe "when password confirmation is nil" do
  #    before { @volunteer.password_confirmation = nil }
  #    it { @volunteer.should_not be_valid }
  #  end
  #end
  #
  #describe "creation of user should fail without password" do
  #  before { @volunteer = Volunteer.new(email: "user@example.com") }
  #
  #  it "should fail if it doesn't quack like a duck" do
  #    @volunteer.should_not be_valid()
  #  end
  #end
  #
  #describe "make sure that password is long enough" do
  #  before { @volunteer = Volunteer.new(password: "t"*9) }
  #
  #
  #  it "should fail if the password isn't long enough" do
  #    @volunteer.should_not be_valid()
  #  end
  #end
  #
  #describe "Volunteer email validation" do
  #  before do
  #    @volunteer = create_a_volunteer
  #  end
  #
  #  describe "when email format is invalid" do
  #    it "should be invalid" do
  #      addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
  #      addresses.each do |invalid_address|
  #        @volunteer.email = invalid_address
  #        @volunteer.should_not be_valid
  #      end
  #    end
  #  end
  #
  #  describe "when email format is valid" do
  #    it "should be valid" do
  #      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
  #      addresses.each do |valid_address|
  #        @volunteer.email = valid_address
  #        @volunteer.should be_valid
  #      end
  #    end
  #  end
  #end
  #
  #describe "Volunteer with duplicate email must not be saved" do
  #  before do
  #    @volunteer = create_a_volunteer
  #  end
  #
  #  it "should fail when trying to validate a volunteer with an email address is already taken" do
  #      user_with_same_email = @volunteer.dup
  #      user_with_same_email.save
  #      user_with_same_email.should_not be_valid
  #  end
  #end
  #
  #describe "check that password_digest is set after creation" do
  #  before do
  #    @volunteer = create_a_volunteer
  #  end
  #
  #  it "should be populated after creation" do
  #
  #    assert(@volunteer.password_digest.length != 0)
  #  end
  #end
  #
  #describe "verify that authentication works" do
  #  before do
  #    @volunteer = create_a_volunteer
  #    @volunteer.save
  #  end
  #
  #  it "should be able to validate volunteer is the same using password" do
  #    volunteer_for_validation_errors = @volunteer.valid?
  #    volunteer_for_validation_errors.errors.each_full{|msg| puts msg }
  #    volunteer = Volunteer.find_by_email(@volunteer.email)
  #    is_authenticated = volunteer.authenticate(create_a_valid_password)
  #    assert(is_authenticated)
  #  end
  #
  #end
end

