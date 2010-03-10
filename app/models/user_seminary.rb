class UserSeminary < ActiveRecord::Base

  validates_numericality_of :id, :allow_nil => true, :greater_than =>0, :only_integer => true
  validates_numericality_of :user_id, :roleinseminary_id,  :greater_than =>0,:only_integer => true
  validates_presence_of :roleinseminary_id
  validates_uniqueness_of :user_id, :scope => [:seminary_id, :roleinseminary_id]

  belongs_to :seminary
  belongs_to :roleinseminary
  belongs_to :user

  validates_associated :seminary
  validates_associated :roleinseminary
end
