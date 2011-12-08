class UserResearchline < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :researchline_id, :user_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :user_id, :scope => [:researchline_id]

  belongs_to :researchline
  accepts_nested_attributes_for :researchline

  belongs_to :user
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'

  def as_text
     researchline.as_text
  end
end

