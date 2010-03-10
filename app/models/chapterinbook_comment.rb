class ChapterinbookComment < ActiveRecord::Base

  validates_presence_of :chapterinbook_id, :message => "Proporcione el chapterinbook_id"

  validates_numericality_of :id, :allow_nil => true, :greater_than =>0, :only_integer => true
  validates_numericality_of :user_id, :chapterinbook_id, :greater_than =>0 , :only_integer => true


  validates_uniqueness_of :user_id, :scope => [:chapterinbook_id]

  belongs_to :chapterinbook
  belongs_to :user

  validates_associated :chapterinbook

end
