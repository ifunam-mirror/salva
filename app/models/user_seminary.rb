class UserSeminary < ActiveRecord::Base
  attr_accessible :roleinseminary_id, :user_id, :seminary_id
  validates_numericality_of :id, :allow_nil => true, :greater_than =>0, :only_integer => true
  validates_numericality_of :user_id, :roleinseminary_id,  :greater_than =>0,:only_integer => true
  validates_presence_of :roleinseminary_id
  validates_uniqueness_of :user_id, :scope => [:seminary_id, :roleinseminary_id]

  belongs_to :seminary
  belongs_to :roleinseminary
  belongs_to :user

  validates_associated :seminary
  validates_associated :roleinseminary

  scope :user_id_not_eq, lambda { |user_id| select('DISTINCT(seminary_id) as seminary_id').where(["user_seminaries.user_id !=  ?", user_id]) }
  scope :user_id_eq, lambda { |user_id| select('DISTINCT(seminary_id) as seminary_id').where :user_id => user_id }

  def author_with_role
    [user.author_name, "(#{roleinseminary.name})"].join(' ')
  end
end
