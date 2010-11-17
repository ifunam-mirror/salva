class UserSkill < ActiveRecord::Base
  validates_presence_of :skilltype_id, :skilltype_id
  validates_numericality_of :id, :allow_nil => true,  :greater_than => 0, :only_integer => true
  validates_numericality_of :user_id, :skilltype_id, :greater_than => 0, :only_integer => true

  belongs_to :skilltype
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'
  
  validates_associated :skilltype
  
  def as_vancouver
    [descr, 'Tipo de actividad: ' + skilltype.name].join(',')
  end
end
