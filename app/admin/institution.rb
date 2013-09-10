ActiveAdmin.register Institution do
  #menu :parent => I18n.t("active_admin.catalogs")
  menu :parent => 'Catálogos'

  index do 
    column :id
    column :name
    column :abbrev
    column :institutiontype
    column :administrative_key
    default_actions
  end

  filter :name
  filter :abbrev
  filter :administrative_key
  filter :institutiontype
  filter :country

  form do |f|
    f.inputs do
      f.input :name, :as => :string
      f.input :url, :as => :string
      f.input :institutiontype, :as => :radio
      f.input :country
      f.input :institution, :as => :select, :collection => Institution.for_universities
    end
    f.buttons
  end
end
