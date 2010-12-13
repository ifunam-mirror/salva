class Document < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :documenttype_id, :scope => [:user_id]
  belongs_to :user
  belongs_to :documenttype
  belongs_to :approved_by, :class_name => 'User'

  default_scope :order => 'documenttypes.start_date DESC, documenttypes.end_date DESC', :joins => :documenttype
  scope :annual_reports, joins(:documenttype).where("documenttypes.name LIKE 'Informe anual de actividades%'")
  scope :annual_plan, joins(:documenttype).where("documenttypes.name LIKE 'Plan de trabajo%'")

  before_create :file_path

  def url
    File.expand_path(file).gsub(File.expand_path(Rails.root.to_s+'/public'), '')
  end

  def file_path
    path = Rails.root.to_s + '/public/uploads'
    unless documenttype.name.match(/^Informe anual de actividades/).nil?
      path += '/annual_reports/' + documenttype.year.to_s
    end
    system "mkdir -p #{path}" unless File.exist? path      
    self.file = path + "/#{user.login}.pdf"
  end  
end
