class Schoolarship < ActiveRecord::Base
  validates_presence_of :name
  validates_numericality_of :id, :institution_id, :allow_nil => true, :greater_than =>0, :only_integer => true
  validates_numericality_of :institution_id, :allow_nil => true, :only_integer => true

  validates_uniqueness_of :name, :scope => [:institution_id]

  belongs_to :institution
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'

  validates_associated :institution

  default_scope :order => 'name ASC'

  def name_and_institution_abbrev
     institution.nil? ? name : [name, institution.abbrev].join(' - ')
  end
  
  has_many :user_schoolarships
end

