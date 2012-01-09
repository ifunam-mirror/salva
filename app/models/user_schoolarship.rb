class UserSchoolarship < ActiveRecord::Base
  validates_presence_of :schoolarship_id
  validates_numericality_of :schoolarship_id, :allow_nil => false,  :greater_than => 0, :only_integer => true
  validates_numericality_of :id, :allow_nil => true,  :greater_than => 0, :only_integer => true
  validates :amount, :numericality => { :allow_nil => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 400000 }

  belongs_to :schoolarship
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'

  default_scope :order => 'end_date DESC, start_date DESC'
  scope :by_start_year, lambda { |year| by_year(year, :field => :start_date) }
  scope :by_end_year, lambda { |year| by_year(year, :field => :end_date) }
  search_methods :by_start_year, :by_end_year

  def as_text
    [schoolarship.name_and_institution_abbrev, start_date, end_date].compact.join(', ')
  end
end
