class UserConferencetalk < ActiveRecord::Base
  attr_accessible :roleinconferencetalk_id, :conferencetalk_id, :user_id

  validates_numericality_of :id, :allow_nil => true,:greater_than => 0, :only_integer => true
  validates_presence_of :roleinconferencetalk_id
  validates_numericality_of :user_id, :roleinconferencetalk_id, :greater_than =>0 , :only_integer => true

  belongs_to :conferencetalk
  belongs_to :roleinconferencetalk
  belongs_to :user
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'

  def author_with_role
    "#{user.author_name} (#{roleinconferencetalk.name})"
  end
end
