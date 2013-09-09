ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    div :class => "blank_slate_container", :id => "dashboard_default_message" do
    end

    columns do
      column do
        panel "Usuarios registrados recientemente" do 
          ul do
            User.order("created_at DESC").limit(10).all.map do |record|
              li link_to(record.to_s, admin_user_path(record))
            end
          end
        end
      end
      column do
        panel "Becas registradas recientemente" do
          ul do
            Schoolarship.order("created_at DESC").limit(10).all.map do |record|
              li link_to(record.name_and_institution_abbrev, admin_schoolarship_path(record))
            end
          end
        end
      end
      column do
        panel "Instituciones registradas recientemente" do
          ul do
            Institution.order("created_at DESC").limit(10).all.map do |record|
              li link_to(record.to_s, admin_institution_path(record))
            end
          end
        end
      end
    end
  end # content
end
