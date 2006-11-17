class Genericwork < ActiveRecord::Base
validates_presence_of :authors, :title, :genericworktype_id, :genericworkstatus_id, :year
validates_numericality_of :genericworktype_id, :genericworkstatus_id, :institution_id, :publisher_id
belongs_to :genericworktype
belongs_to :genericworkstatus
belongs_to :institution
belongs_to :publisher
end
