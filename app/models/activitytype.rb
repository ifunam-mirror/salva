class Activitytype < ActiveRecord::Base
  validates_presence_of :name, :activitygroup_id

  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :activitygroup_id, :greater_than => 0, :only_integer => true

  validates_uniqueness_of  :name

  belongs_to :activitygroup
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'
  has_many :activities
end
