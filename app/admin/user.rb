ActiveAdmin.register User do

  index do
    column "Foto" do |user|
      image_tag(user.avatar, :alt => "Foto")
    end
    column :login
    column :email
    column :fullname_or_email, :sortable => false
    column :adscription_name, :sortable => false
    column :category_name, :sortable => false
    column :userstatus
    default_actions
  end

  filter :fullname, :as => :string
  filter :login
  filter :adscription, :collection => proc { Adscription.enabled.all }, :as => :select, :input_html => { :class => "chosen-select" } 
  filter :jobpositioncategory, :collection => proc { Jobpositioncategory.for_researching }, :as => :select, :input_html => { :class => "chosen-select" } 
  filter :schoolarship, :collection => proc { Schoolarship.posdoctoral_scholar.collect {|record|[ record.to_s,  record.id]} }, :as => :select, :input_html => { :class => "chosen-select" } 
  filter :userstatus, :input_html => { :class => "chosen-select" } 
  filter :jobposition_start_date_year, :collection => (Date.today.year - 100 .. Date.today.year + 1).to_a.reverse, :as => :select, :input_html => { :class => "chosen-select" } 
  filter :jobposition_end_date_year, :collection => (Date.today.year - 100 .. Date.today.year + 1).to_a.reverse, :as => :select, :input_html => { :class => "chosen-select" } 


  form do |f|
  f.inputs I18n.t("active_admin.user") do
      f.input :login, :as => :string, :input_html => {:style => 'width: 100px;' }
      f.input :email, :as => :string
      f.input :userstatus, :as => :radio
      f.input :password, :as => :password
      f.input :password_confirmation, :as => :password
      f.input :user_incharge, :collection => User.activated.collect {|record| [record.to_s, record.id] }, :as => :select, :input_html => {:class => "chosen-select"}

      f.inputs I18n.t("active_admin.user_group"), :for => [:user_group, f.object.user_group || UserGroup.new] do |ug_form|
        ug_form.input :group, :as => :radio
      end

      f.inputs I18n.t("active_admin.personal_info"), :for => [:person, f.object.person || Person.new] do |p_form|
        p_form.input :firstname, :as => :string
        p_form.input :lastname1, :as => :string
        p_form.input :lastname2, :as => :string
        p_form.input :title, :as => :string, :input_html => {:style => 'width: 100px;' }
        p_form.input :title_en, :as => :string, :input_html => {:style => 'width: 100px;' }
        p_form.input :dateofbirth
        p_form.input :gender
        p_form.input :maritalstatus, :as => :select, :input_html => { :class => "chosen-select" }
        p_form.input :country, :as => :select, :input_html => { :class => "chosen-select" }
        p_form.input :state, :as => :select, :input_html => { :class => "chosen-select" }
        p_form.input :city, :as => :select, :input_html => { :class => "chosen-select" }
      end

      f.object.user_identifications << UserIdentification.new if f.object.new_record?
      f.has_many :user_identifications do |item|
          item.input :idtype, :as => :select, :input_html => { :class => "chosen-select" }
          item.input :descr, :as => :string
      end

      f.inputs I18n.t("active_admin.professional_address"), :for => [:address, f.object.address || Address.new] do |a_form|
        a_form.input :location, :as => :string
        a_form.input :phone, :as => :string
        a_form.input :phone_extension, :as => :string, :input_html => {:style => 'width: 100px;' }
        a_form.input :fax, :as => :string
      end

      f.inputs I18n.t("active_admin.jobposition_and_adscription"), :for => [:jobposition, f.object.jobposition || Jobposition.new] do |p_form|
          p_form.input :jobpositioncategory, :collection => Jobpositioncategory.for_researching,  :as => :select, :input_html => { :class => "chosen-select" } 
          p_form.input :contracttype, :input_html => { :class => "chosen-select" } 
          p_form.input :institution
          p_form.input :start_date
          p_form.input :end_date
        p_form.inputs I18n.t("active_admin.adscription"), :for => [:user_adscription, p_form.object.user_adscription || UserAdscription.new] do |a_form|
          a_form.input :adscription, :collection => Adscription.enabled.all,  :as => :select, :input_html => { :class => "chosen-select" } 
        end

      end

      f.object.user_schoolarships << UserSchoolarship.new if f.object.new_record?
      f.has_many :user_schoolarships do |item|
        item.input :schoolarship, :collection => Schoolarship.posdoctoral_scholar.collect {|record|[ record.to_s,  record.id]}, :as => :select, :input_html => { :class => "chosen-select" } 
        item.input :start_date
        item.input :end_date
      end

      f.object.documents << Document.new if f.object.new_record?
      f.has_many :documents do |item|
        item.input :document_type, :collection => DocumentType.all, :as => :select, :input_html => { :class => "chosen-select" } 
        item.input :file
      end
    end
    f.buttons
  end
end
