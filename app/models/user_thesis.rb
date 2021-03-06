class UserThesis < ActiveRecord::Base
  attr_accessible :roleinthesis_id, :user_id, :thesis_id
  validates_presence_of  :roleinthesis_id
  validates_numericality_of :id, :user_id, :thesis_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :roleinthesis_id, :greater_than => 0, :only_integer => true

  belongs_to :user
  belongs_to :thesis
  belongs_to :roleinthesis
  belongs_to :registered_by, :class_name => 'User', :foreign_key => 'registered_by_id'
  belongs_to :modified_by, :class_name => 'User', :foreign_key => 'modified_by_id'

  scope :finished, joins(:thesis).where(:thesis => { :thesisstatus_id => 3}).order("theses.end_date DESC, theses.start_date DESC, theses.authors ASC, theses.title ASC")
  scope :between_years, lambda { |start_year, end_year| joins(:thesis).where("theses.startyear >=? OR theses.endyear <= ?", start_year, end_year)}
  scope :user_id_not_eq, lambda { |user_id| select('DISTINCT(thesis_id) as thesis_id').where(["user_theses.user_id !=  ?", user_id]) }
  scope :user_id_eq, lambda { |user_id| select('DISTINCT(thesis_id) as thesis_id').where :user_id => user_id }

  def to_s
    [user.fullname_or_email, "(#{roleinthesis.name})"].join(' ')
  end
end

