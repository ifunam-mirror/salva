class Journal < ActiveRecord::Base
  validates_presence_of :name, :mediatype_id, :country_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :mediatype_id, :country_id, :greater_than => 0, :only_integer => true
  validates_numericality_of :publisher_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :name, :scope => [:issn, :country_id, :mediatype_id]

  belongs_to :mediatype
  belongs_to :publisher, :inverse_of => :journals
  belongs_to :country
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'

  validates_associated :mediatype
  validates_associated :publisher
  validates_associated :country

  has_many :user_journals, :inverse_of => :journal
  has_many :articles, :inverse_of => :journal
  has_many :user_refereed_journals, :inverse_of => :journal
  has_many :users, :through => :user_refereed_journals, :inverse_of => :journals

  attr_accessible :name, :mediatype_id, :country_id, :issn, :abbrev, :url, :other, :is_verified, :impact_index, :publisher_id, :has_open_access

  default_scope :order => 'name ASC'
end
