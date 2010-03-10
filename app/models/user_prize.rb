class UserPrize < ActiveRecord::Base
  validates_presence_of  :year
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :user_id, :year,:greater_than => 0, :only_integer => true
  #validates_uniqueness_of :user_id, :scope => [:prize_id, :year]

  belongs_to :prize
  belongs_to :user

  validates_associated :prize
end
