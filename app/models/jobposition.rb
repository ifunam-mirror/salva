class Jobposition < ActiveRecord::Base
  set_table_name "jobpositions"
  validates_presence_of :institution_id, :start_date
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :institution_id, :greater_than => 0, :only_integer => true
  validates_numericality_of :jobpositioncategory_id, :contracttype_id, :user_id, :allow_nil => true, :greater_than => 0, :only_integer => true

  belongs_to :jobpositioncategory
  belongs_to :contracttype
  belongs_to :institution
  belongs_to :user
  belongs_to :schoolarship
  belongs_to :registered_by, :class_name => 'User', :foreign_key => 'registered_by_id'
  belongs_to :modified_by, :class_name => 'User', :foreign_key => 'modified_by_id'

  has_many :user_adscriptions, :dependent => :destroy
  has_one :user_adscription, :dependent => :destroy
  accepts_nested_attributes_for :user_adscription, :allow_destroy => true

  validates_associated :jobpositioncategory
  validates_associated :contracttype
  validates_associated :institution

  scope :posdoc, :conditions => { :jobpositioncategory_id => 38 }
  scope :researcher, :conditions => { :jobpositioncategory_id => 1..37 }
  scope :by_start_year, lambda { |year| by_year(year, :field => :start_date) }
  scope :by_end_year, lambda { |year| by_year(year, :field => :end_date) }
  scope :at_external_institutions, joins(:institution).where("(institutions.institution_id != 1 OR institutions.institution_id IS NULL) AND jobpositions.institution_id = institutions.id ")
  scope :at_unam, joins(:institution).where("(institutions.institution_id = 1 OR institutions.id = 1) AND jobpositions.institution_id = institutions.id ")

  search_methods :by_start_year, :by_end_year
  def category_name
    jobpositioncategory.nil? ? nil : jobpositioncategory.name
  end

  def as_text
    [category_name, institution.name, start_date, end_date].compact.join(', ')
  end
end
