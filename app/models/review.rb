class Review < ActiveRecord::Base
  validates_presence_of :authors, :title, :published_on, :reviewed_work_title, :year
  validates_numericality_of :year, :greater_than => (Date.today.year - 100), :less_than_or_equal_to => (Date.today.year + 1), :only_integer => true
  validates_uniqueness_of :title, :scope => [:user_id, :authors, :title, :year]
  normalize_attributes :published_on, :reviewed_work_title, :reviewed_work_publication

  belongs_to :user
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'

  default_scope :order => 'year DESC, month DESC, authors ASC, title ASC, reviewed_work_title ASC, published_on ASC'

  def as_text
    reviewed_work_publication = reviewed_work_publication.to_s.strip.empty?
    [ authors, title, "#{I18n.t(:reviewed_work_title)}: #{reviewed_work_title}", normalized_reviewed_work_publication,
      "#{I18n.t(:published_on)}: #{published_on}", date ].compact.join(', ')
  end

  def normalized_reviewed_work_publication
    unless reviewed_work_publication.to_s.strip.empty?
      "#{I18n.t(:reviewed_work_publication)}: #{reviewed_work_publication}"
    end
  end
end
