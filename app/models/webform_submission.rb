class WebformSubmission < ActiveRecord::Base
  self.table_name = "webform_submissions"
  attr_accessible :nid, :sid, :submitted, :is_draft

  belongs_to :volunteer, :foreign_key => 'id'
end
