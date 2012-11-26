class ThesisExamination < Thesis
  attr_accessible :title, :authors, :thesismodality_id, :thesisstatus_id,
                  :start_date, :end_date,
                  :thesis_jurors_attributes, :career_attributes,
                  :startyear, :endyear, :startmonth, :endmonth

  has_many :thesis_jurors, :foreign_key => 'thesis_id'
  has_many :users, :through => :thesis_jurors
  accepts_nested_attributes_for :thesis_jurors
  user_association_methods_for :thesis_jurors

  has_paper_trail

  # TODO: Verify if our scopes are working
  # scopes.delete :user_id_eq
  # scopes.delete :user_id_not_eq

  scope :user_id_eq, lambda { |user_id| joins(:thesis_jurors).where(:thesis_jurors => { :user_id => user_id }) }

  scope :user_id_not_eq, lambda { |user_id| 
    theses_without_user_sql = ThesisJuror.user_id_not_eq(user_id).to_sql
    theses_with_user_sql = ThesisJuror.user_id_eq(user_id).to_sql
    sql = "theses.id IN (#{theses_without_user_sql}) AND theses.id NOT IN (#{theses_with_user_sql})"
    where sql
  }

  scope :roleinjury_id_eq, lambda { |roleinjury_id| joins(:thesis_jurors).where(:thesis_jurors => { :roleinjury_id => roleinjury_id }) }
  search_methods :user_id_eq, :user_id_not_eq, :roleinjury_id_eq

  def users_and_roles
    thesis_jurors.collect {|record| record.to_s }.join(', ')
  end

end
