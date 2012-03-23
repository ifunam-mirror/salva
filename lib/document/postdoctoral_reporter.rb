# encoding: utf-8
require 'spreadsheet'
require 'tempfile'
include Spreadsheet
Spreadsheet.client_encoding = 'UTF-8'
class PostdoctoralReporter
  def initialize(collection)
    @records = collection
    @workbook = Spreadsheet::Workbook.new
    @row = 0
    @col = 0
  end
  
  def to_xls
    add_worksheet
    add_column_names
    add_records
    @workbook.write(temp_file_name)
    File.open(temp_file_name).read
  end
  
  def add_worksheet(name='Investigadores posdoctorales')
    @worksheet = @workbook.create_worksheet :name => name
  end
  
  def add_column_names
      [ 'Departamento', 'Nombre', 'Edad', 'Ubicación', 'Correo electrónico', 'Teléfono', 
        'Académico Responsable', 'Fecha de ingreso al instituto', 'Fecha de conclusión', 
        'Becas'].each do |column_name|
        @worksheet[@row,@col] = column_name
        @col += 1
      end
      @row += 1
      @worksheet.row(0).default_format = Spreadsheet::Format.new(:color => :black, :weight => :bold, :size => 12)
  end
  
  def add_records
    @records.each do |record|
      @worksheet[@row,0] = record.adscription_name 
      @worksheet[@row,1] = record.fullname_or_email
      @worksheet[@row,2] = record.person.age
      
      unless record.address.nil?
        @worksheet[@row,3] = record.address.location
        @worksheet[@row,4] = record.address.phone
      end
      
      @worksheet[@row,5] = record.email
      @worksheet[@row,6] = record.user_incharge_fullname
      
      unless record.jobposition_as_postdoctoral.nil?
        @worksheet[@row,7] = I18n.l(record.jobposition_as_postdoctoral.start_date, :format => :default)
        @worksheet[@row,8] = I18n.l(record.jobposition_as_postdoctoral.end_date, :format => :default) unless record.jobposition_as_postdoctoral.end_date.nil?
      end
      
      if record.user_schoolarships.size > 0
          column = 9
          record.user_schoolarships_as_posdoctoral.all.each do |user_schoolarship|
            schoolarship = "Tipo de beca: #{user_schoolarship.schoolarship.name_and_institution_abbrev}\n"
            schoolarship += "Fecha de inicio: " + (user_schoolarship.start_date.nil? ? "-\n" : "#{I18n.l(user_schoolarship.start_date, :format => :default)}\n")
            schoolarship += "Fecha de término: " + (user_schoolarship.end_date.nil? ? '-' : I18n.l(user_schoolarship.end_date, :format => :default))
            @worksheet[@row,column] = schoolarship
            column += 1
          end
      end
      @row += 1
    end
  end    

  def temp_file_name
    @temp_file_name ||= Tempfile.new('postdoctoral_report_', File.join(Rails.root.to_s, 'tmp')).path + '.xls'
  end
end
