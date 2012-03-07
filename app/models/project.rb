class Project < ActiveRecord::Base
  attr_accessible :name, :abbrev, :responsible, :descr, :projecttype_id, :startyear, :startmonth, :endyear, :endmonth,
                  :projectfinancingsources_attributes, :projectstatus_id, :user_projects_attributes

  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :projectstatus_id, :projectstatus_id, :startyear,:projecttype_id, :greater_than => 0, :only_integer => true
  validates_presence_of :name, :responsible, :descr, :projecttype_id, :projectstatus_id, :startyear

  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'
  belongs_to :projecttype
  belongs_to :projectstatus
  belongs_to :project

  has_many :user_projects
  has_many :users, :through => :user_projects
  accepts_nested_attributes_for :user_projects
  user_association_methods_for :user_projects

  has_many :projectfinancingsources
  has_many :institutions, :through => :projectfinancingsources
  accepts_nested_attributes_for :projectfinancingsources, :reject_if => proc { |attrs| attrs['institution_id'] == '0' }

  has_many :projectinstitutions
  has_many :projectresearchlines
  has_many :projectresearchareas
  has_many :projectarticles
  has_many :projectbooks
  has_many :projectchapterinbooks
  has_many :projectconferencetalks
  has_many :projectacadvisits
  has_many :projectgenericworks
  has_many :projecttheses

  has_paper_trail

  scope :user_id_eq, lambda { |user_id| joins(:user_projects).where(:user_projects => {:user_id => user_id}) }
  scope :user_id_not_eq, lambda { |user_id|  where("projects.id IN (#{UserProject.select('DISTINCT(project_id) as project_id').where(["user_projects.user_id !=  ?", user_id]).to_sql}) AND projects.id  NOT IN (#{UserProject.select('DISTINCT(project_id) as project_id').where(["user_projects.user_id =  ?", user_id]).to_sql})") }
  search_methods :user_id_eq, :user_id_not_eq

  def as_text
    [name, "Responsable: #{responsible}", "Tipo: #{projecttype.name}", "Status: #{projectstatus.name}", start_date, end_date].join(', ')
  end

end
