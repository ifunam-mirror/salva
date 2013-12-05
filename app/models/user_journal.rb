class UserJournal < ActiveRecord::Base
  attr_accessible :journal_id, :roleinjournal_id, :startyear, :startmonth, :endyear, :endmonth

  validates_presence_of :journal_id, :roleinjournal_id, :startyear

  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :user_id, :journal_id, :roleinjournal_id, :startyear, :greater_than => 0, :only_integer => true
  validates_numericality_of :startmonth, :endyear, :endmonth, :allow_nil => true, :greater_than => 0, :only_integer => true

  belongs_to :user
  belongs_to :journal
  belongs_to :roleinjournal
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'
  
  default_scope :order => 'endyear DESC, endmonth DESC, startyear DESC, startmonth DESC'

  def to_s
    [(journal_id.nil? ? "Journal no registrado" : journal.name), "#{roleinjournal.name}: #{user.author_name}", start_date, end_date].compact.join(', ')
  end
end
