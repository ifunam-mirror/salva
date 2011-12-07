class Proceeding < ActiveRecord::Base
  validates_presence_of :title
  validates_numericality_of :id, :publisher_id,  :allow_nil => true, :greater_than =>0, :only_integer => true
  validates_inclusion_of :isrefereed, :in => [true, false]

  belongs_to :conference
  accepts_nested_attributes_for :conference
  belongs_to :publisher
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :updated_by, :class_name => 'User'

  has_many :inproceedings
  has_many :user_proceedings
  default_scope order('title ASC')


  def as_text
    if title == conference.name
      [title, (publisher.nil? ? nil : publisher.name), year].compact.join(', ')
    else
      [title, (publisher.nil? ? nil : publisher.name), conference.name, year].compact.join(', ')
    end
  end
end
