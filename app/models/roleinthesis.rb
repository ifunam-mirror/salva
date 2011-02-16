class Roleinthesis < ActiveRecord::Base
  validates_presence_of :name
  validates_numericality_of :id, :allow_nil => true, :greater_than =>0, :only_integer => true
  validates_uniqueness_of :name

  has_many :user_theses
  scope :no_author, where('id > 1')
  default_scope :order => 'name ASC'
end
