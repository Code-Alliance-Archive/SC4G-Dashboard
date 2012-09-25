class Volunteer < ActiveRecord::Base
  attr_accessible :email, :name, :id, :time_to_commit_db, :orgs_interested_in_db, :causes_interested_in_db, :languages_interested_in_db, :skills_db, :open_source_projects_db, :company_db, :company_db_attributes
  #scope :by_name, lambda {|name| {:conditions => ['name like ?' , name]}}
  scope :by_name, lambda { |name| where("name like ?", '%' + name.to_s + '%')}
  scope :by_email, lambda { |email| where("email like ?", '%' + email.to_s + '%')}
  scope :by_company, lambda { |company| select('volunteers.*').joins('inner join webform_submitted_data on volunteers.id=webform_submitted_data.sid').where("webform_submitted_data.cid = 17 AND webform_submitted_data.data like ?", '%' + company.to_s + '%')}
  scope :by_skills, lambda { |skill| select('volunteers.*').joins('inner join webform_submitted_data on volunteers.id=webform_submitted_data.sid').where("webform_submitted_data.cid = 14 AND webform_submitted_data.data like ?", skill.to_s)}



  has_one :company_db,
          :select => "data",
          :class_name => "WebformSubmittedData",
          :foreign_key => 'sid',
          :conditions => proc {"cid = 17 AND sid = '#{self.id}'"}

  has_one :time_to_commit_db,
          :select => "data",
          :class_name => "WebformSubmittedData",
          :foreign_key => 'sid',
          :conditions => proc {"cid = 19 AND sid = '#{self.id}'"}

  has_one :open_source_projects_db,
          :select => "data",
          :class_name => "WebformSubmittedData",
          :foreign_key => 'sid',
          :conditions => proc {"cid = 22 AND sid = '#{self.id}'"}

  has_many :orgs_interested_in_db,
          :select => "data",
          :class_name => "WebformSubmittedData",
          :foreign_key => 'sid',
          :conditions => proc {"cid = 18 AND sid = '#{self.id}'"}

  has_many :causes_interested_in_db,
           :select => "data",
           :class_name => "WebformSubmittedData",
           :foreign_key => 'sid',
           :conditions => proc {"cid = 11 AND sid = '#{self.id}'"}

  has_many :languages_interested_in_db,
           :select => "data",
           :class_name => "WebformSubmittedData",
           :foreign_key => 'sid',
           :conditions => proc {"cid = 13 AND sid = '#{self.id}'"}

  has_many :skills_db,
           :select => "data",
           :class_name => "WebformSubmittedData",
           :foreign_key => 'sid',
           :conditions => proc {"cid = 14 AND sid = '#{self.id}'"}

  accepts_nested_attributes_for :company_db

  def company
    if company_db.nil? || company_db.data.nil?
      company = 'N/A'
    else
      company = company_db.data
    end
    company
  end

  def time_to_commit
    if time_to_commit_db.nil? || time_to_commit_db.data.nil?
      value = 'N/A'
    else
      value = time_to_commit_db.data.gsub("_", " ")
    end
    value
  end

  def open_source_projects
    if open_source_projects_db.nil? || open_source_projects_db.data.nil?
      value = 'N/A'
    else
      value = open_source_projects_db.data
    end
    value
  end

  def open_source_projects?
    open_source_projects_db.data == "yes"
  end

  def orgs_interested_in
    orgs = []
    if orgs_interested_in_db.empty?
      orgs.push 'N/A'
    else
    orgs_interested_in_db.each do |p|
      orgs.push p.data.gsub("_", " ")
    end
    end
    orgs
  end

  def causes_interested_in
    causes = []
    if causes_interested_in_db.empty?
      causes.push 'N/A'
    end
    causes_interested_in_db.each do |p|
      causes.push p.data.gsub("_", " ")
    end
    causes
  end

  def languages_interested_in
    languages = []
    if languages_interested_in_db.empty?
      languages.push 'N/A'
    end
    languages_interested_in_db.each do |p|
      languages.push p.data.gsub("_", " ")
    end
    languages
  end

  def skills
    skills = []
    skills_db.each do |p|
      skills.push p.data.gsub("_", " ")
    end
    skills
  end

end




