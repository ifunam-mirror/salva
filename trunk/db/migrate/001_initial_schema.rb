class InitialSchema < ActiveRecord::Migration
  def self.up
    ActiveRecord::Schema.define() do

      create_table "acadvisits", :force => true do |t|
        t.column "user_id", :integer, :null => false
        t.column "institution_id", :integer, :null => false
        t.column "country_id", :integer, :null => false
        t.column "acadvisittype_id", :integer, :null => false
        t.column "name", :text, :null => false
        t.column "startyear", :integer, :null => false
        t.column "startmonth", :integer
        t.column "endyear", :integer
        t.column "endmonth", :integer
        t.column "place", :text
        t.column "goals", :text
        t.column "other", :text
        t.column "visitor_id", :integer
      end

      create_table "acadvisittypes", :force => true do |t|
        t.column "name", :text, :null => false
      end

      add_index "acadvisittypes", ["name"], :name => "acadvisittypes_name_key", :unique => true

      create_table "activities", :force => true do |t|
        t.column "user_id", :integer, :null => false
        t.column "activitytype_id", :integer, :null => false
        t.column "title", :text, :null => false
      end

      create_table "activitiesinstitutions", :id => false, :force => true do |t|
        t.column "activities_id", :integer, :null => false
        t.column "institution_id", :integer, :null => false
      end

      create_table "activitygroups", :force => true do |t|
        t.column "name", :text, :null => false
      end

      add_index "activitygroups", ["name"], :name => "activitygroups_name_key", :unique => true

      create_table "activitytypes", :force => true do |t|
        t.column "name", :text, :null => false
        t.column "abbrev", :text
        t.column "activitygroup_id", :integer, :null => false
        t.column "moduser_id", :integer
      end

      add_index "activitytypes", ["abbrev"], :name => "activitytypes_abbrev_key", :unique => true
      add_index "activitytypes", ["name"], :name => "activitytypes_name_key", :unique => true

      create_table "addresses", :force => true do |t|
        t.column "user_id", :integer, :null => false
        t.column "addresstype_id", :integer, :null => false
        t.column "addr", :text, :null => false
        t.column "pobox", :text
        t.column "country_id", :integer, :null => false
        t.column "state_id", :integer
        t.column "city_id", :integer
        t.column "zipcode", :integer
        t.column "phone", :text
        t.column "fax", :text
        t.column "movil", :text
        t.column "other", :text
        t.column "is_postaddress", :boolean, :default => false, :null => false
        t.column "moduser_id", :integer
        t.column "created_on", :datetime
        t.column "updated_on", :datetime
      end

      add_index "addresses", ["user_id", "addresstype_id"], :name => "addresses_user_id_key", :unique => true

      create_table "addresstypes", :force => true do |t|
        t.column "name", :text, :null => false
      end

      add_index "addresstypes", ["name"], :name => "addresstypes_name_key", :unique => true

      create_table "adscriptions", :force => true do |t|
        t.column "name", :text, :null => false
        t.column "abbrev", :text
        t.column "descr", :text
        t.column "institution_id", :integer, :null => false
        t.column "administrative_id", :text
      end

      add_index "adscriptions", ["abbrev"], :name => "adscriptions_abbrev_key", :unique => true
      add_index "adscriptions", ["name"], :name => "adscriptions_name_key", :unique => true

      create_table "adviceactivity", :force => true do |t|
        t.column "name", :text, :null => false
        t.column "moduser_id", :integer
      end

      add_index "adviceactivity", ["name"], :name => "adviceactivity_name_key", :unique => true

      create_table "articles", :force => true do |t|
        t.column "title", :text, :null => false
        t.column "pages", :text
        t.column "year", :integer, :null => false
        t.column "month", :integer
        t.column "vol", :text
        t.column "num", :text
        t.column "authors", :text
        t.column "url", :text
        t.column "pacsnum", :text
        t.column "articlestatus_id", :integer, :null => false
        t.column "journal_id", :integer, :null => false
        t.column "moduser_id", :integer
        t.column "other", :text
      end

      add_index "articles", ["title", "year", "journal_id"], :name => "articles_title_key", :unique => true

      create_table "articlesfiles", :force => true do |t|
        t.column "filename", :text, :null => false
        t.column "articles_id", :integer, :null => false
        t.column "filedescr", :text
        t.column "content", :binary, :null => false
        t.column "creationtime", :datetime, :null => false
        t.column "lastmodiftime", :datetime, :null => false
        t.column "moduser_id", :integer
        t.column "created_on", :datetime
        t.column "updated_on", :datetime
      end

      add_index "articlesfiles", ["filename", "articles_id"], :name => "articlesfiles_articles_id_key", :unique => true
      add_index "articlesfiles", ["articles_id"], :name => "articlesfiles_articles_idx"
      add_index "articlesfiles", ["filename"], :name => "articlesfiles_filename_idx"

      create_table "articleslog", :force => true do |t|
        t.column "article_id", :integer, :null => false
        t.column "old_articlestatus_id", :integer, :null => false
        t.column "changedate", :date, :null => false
        t.column "moduser_id", :integer
        t.column "created_on", :datetime
        t.column "updated_on", :datetime
      end

      create_table "articlestatuses", :force => true do |t|
        t.column "name", :string, :limit => 50, :null => false
      end

      add_index "articlestatuses", ["name"], :name => "articlestatuses_name_key", :unique => true

      create_table "attendeetype", :force => true do |t|
        t.column "name", :text, :null => false
      end

      add_index "attendeetype", ["name"], :name => "attendeetype_name_key", :unique => true

      create_table "bookedition_comments", :force => true do |t|
        t.column "user_id", :integer, :null => false
        t.column "bookedition_id", :integer, :null => false
        t.column "comment", :text
      end

      create_table "bookedition_publishers", :force => true do |t|
        t.column "bookedition_id", :integer, :null => false
        t.column "publisher_id", :integer
      end

      add_index "bookedition_publishers", ["bookedition_id", "publisher_id"], :name => "bookedition_publishers_bookedition_id_key", :unique => true

      create_table "bookedition_roleinbooks", :force => true do |t|
        t.column "user_id", :integer, :null => false
        t.column "bookedition_id", :integer, :null => false
        t.column "roleinbook_id", :integer, :null => false
      end

      create_table "bookeditions", :force => true do |t|
        t.column "book_id", :integer, :null => false
        t.column "edition_id", :integer, :null => false
        t.column "pages", :integer
        t.column "isbn", :text
        t.column "publisher_id", :integer
        t.column "mediatype_id", :integer, :null => false
        t.column "editionstatus_id", :integer
        t.column "month", :integer
        t.column "year", :integer
        t.column "other", :text
        t.column "moduser_id", :integer
      end

      add_index "bookeditions", ["book_id", "edition_id", "editionstatus_id"], :name => "bookeditions_book_id_key", :unique => true

      create_table "books", :force => true do |t|
        t.column "title", :text, :null => false
        t.column "author", :text, :null => false
        t.column "booklink", :text
        t.column "country_id", :integer, :null => false
        t.column "booktype_id", :integer, :null => false
        t.column "volume_id", :integer
        t.column "orig_language_id", :integer
        t.column "trans_language_id", :integer
        t.column "numcites", :integer
        t.column "moduser_id", :integer
      end

      create_table "booksfiles", :force => true do |t|
        t.column "filename", :text, :null => false
        t.column "books_id", :integer, :null => false
        t.column "filedescr", :text
        t.column "content", :binary, :null => false
        t.column "creationtime", :datetime, :null => false
        t.column "lastmodiftime", :datetime, :null => false
        t.column "moduser_id", :integer
        t.column "created_on", :datetime
        t.column "updated_on", :datetime
      end

      add_index "booksfiles", ["filename", "books_id"], :name => "booksfiles_books_id_key", :unique => true
      add_index "booksfiles", ["books_id"], :name => "booksfiles_books_idx"
      add_index "booksfiles", ["filename"], :name => "booksfiles_filename_idx"

      create_table "booktypes", :force => true do |t|
        t.column "name", :text, :null => false
      end

      add_index "booktypes", ["name"], :name => "booktypes_name_key", :unique => true

      create_table "careers", :force => true do |t|
        t.column "name", :text, :null => false
        t.column "abbrev", :text
        t.column "moduser_id", :integer
      end

      add_index "careers", ["name"], :name => "careers_name_key", :unique => true

      create_table "chapterinbook_comments", :force => true do |t|
        t.column "user_id", :integer, :null => false
        t.column "chapterinbook_id", :integer, :null => false
        t.column "comment", :text
      end

      create_table "chapterinbook_roleinbooks", :force => true do |t|
        t.column "user_id", :integer, :null => false
        t.column "chapterinbook_id", :integer, :null => false
        t.column "roleinbook_id", :integer, :null => false
      end

      create_table "chapterinbooks", :force => true do |t|
        t.column "bookedition_id", :integer, :null => false
        t.column "chapter", :text, :null => false
        t.column "pages", :text
        t.column "numcites", :integer
        t.column "moduser_id", :integer
      end

      add_index "chapterinbooks", ["bookedition_id", "chapter"], :name => "chapterinbooks_bookedition_id_key", :unique => true
      add_index "chapterinbooks", ["chapter"], :name => "chapterinbooks_chapter_idx"

      create_table "chapterinbooksfiles", :force => true do |t|
        t.column "filename", :text, :null => false
        t.column "chapterinbook_id", :integer, :null => false
        t.column "filedescr", :text
        t.column "content", :binary, :null => false
        t.column "creationtime", :datetime, :null => false
        t.column "lastmodiftime", :datetime, :null => false
        t.column "moduser_id", :integer
        t.column "created_on", :datetime
        t.column "updated_on", :datetime
      end

      add_index "chapterinbooksfiles", ["filename", "chapterinbook_id"], :name => "chapterinbooksfiles_chapterinbook_id_key", :unique => true
      add_index "chapterinbooksfiles", ["chapterinbook_id"], :name => "chapterinbooksfiles_chapterinbooks_idx"
      add_index "chapterinbooksfiles", ["filename"], :name => "chapterinbooksfiles_filename_idx"

      create_table "cities", :force => true do |t|
        t.column "state_id", :integer, :null => false
        t.column "name", :text, :null => false
        t.column "moduser_id", :integer
      end

      add_index "cities", ["state_id", "name"], :name => "cities_state_id_key", :unique => true

      create_table "citizenmodalities", :force => true do |t|
        t.column "name", :text, :null => false
      end

      add_index "citizenmodalities", ["name"], :name => "citizenmodalities_name_key", :unique => true

      create_table "citizens", :force => true do |t|
        t.column "user_id", :integer, :null => false
        t.column "citizen_country_id", :integer, :null => false
        t.column "migratorystatus_id", :integer, :null => false
        t.column "citizenmodality_id", :integer, :null => false
        t.column "moduser_id", :integer
        t.column "created_on", :datetime
        t.column "updated_on", :datetime
      end

      add_index "citizens", ["user_id", "citizen_country_id"], :name => "citizens_user_id_key", :unique => true

      create_table "conferenceinstitutions", :id => false, :force => true do |t|
        t.column "conference_id", :integer, :null => false
        t.column "institution_id", :integer, :null => false
      end

      create_table "conferences", :force => true do |t|
        t.column "name", :text, :null => false
        t.column "url", :text
        t.column "month", :integer
        t.column "year", :integer, :null => false
        t.column "conferencetype_id", :integer, :null => false
        t.column "country_id", :integer, :null => false
        t.column "conferencescope_id", :integer, :null => false
        t.column "location", :text
        t.column "moduser_id", :integer, :null => false
      end

      add_index "conferences", ["name", "year", "country_id"], :name => "conferences_name_key", :unique => true

      create_table "conferencescope", :force => true do |t|
        t.column "name", :text, :null => false
      end

      add_index "conferencescope", ["name"], :name => "conferencescope_name_key", :unique => true

      create_table "conferencetalks", :force => true do |t|
        t.column "conference_id", :integer, :null => false
        t.column "talktype_id", :integer, :null => false
        t.column "talkacceptance_id", :integer, :null => false
        t.column "modality_id", :integer, :null => false
        t.column "title", :text, :null => false
        t.column "authors", :text, :null => false
        t.column "abstract", :text
      end

      add_index "conferencetalks", ["conference_id", "title", "authors"], :name => "conferencetalks_conference_id_key", :unique => true

      create_table "conferencetalksfiles", :force => true do |t|
        t.column "filename", :text, :null => false
        t.column "conferencetalks_id", :integer, :null => false
        t.column "filedescr", :text
        t.column "content", :binary, :null => false
        t.column "creationtime", :datetime, :null => false
        t.column "lastmodiftime", :datetime, :null => false
        t.column "moduser_id", :integer
        t.column "created_on", :datetime
        t.column "updated_on", :datetime
      end

      add_index "conferencetalksfiles", ["filename", "conferencetalks_id"], :name => "conferencetalksfiles_conferencetalks_id_key", :unique => true
      add_index "conferencetalksfiles", ["conferencetalks_id"], :name => "conferencetalksfiles_conferencetalks_idx"
      add_index "conferencetalksfiles", ["filename"], :name => "conferencetalksfiles_filename_idx"

      create_table "conferencetypes", :force => true do |t|
        t.column "name", :text, :null => false
      end

      add_index "conferencetypes", ["name"], :name => "conferencetypes_name_key", :unique => true

      create_table "contracttypes", :force => true do |t|
        t.column "name", :text, :null => false
      end

      add_index "contracttypes", ["name"], :name => "contracttypes_name_key", :unique => true

      create_table "countries", :force => true do |t|
        t.column "name", :text, :null => false
        t.column "citizen", :text, :null => false
        t.column "code", :string, :limit => 3, :null => false
      end

      add_index "countries", ["code"], :name => "countries_code_key", :unique => true
      add_index "countries", ["name"], :name => "countries_name_key", :unique => true

      create_table "coursegroup", :force => true do |t|
        t.column "name", :text
        t.column "coursegrouptype_id", :integer, :null => false
        t.column "startyear", :integer, :null => false
        t.column "startmonth", :integer
        t.column "endyear", :integer
        t.column "endmonth", :integer
        t.column "totalhours", :integer
      end

      add_index "coursegroup", ["name"], :name => "coursegroup_name_key", :unique => true

      create_table "coursegrouptype", :force => true do |t|
        t.column "name", :text, :null => false
      end

      add_index "coursegrouptype", ["name"], :name => "coursegrouptype_name_key", :unique => true

      create_table "courses", :force => true do |t|
        t.column "title", :text, :null => false
        t.column "coursetype_id", :integer, :null => false
        t.column "degrees_id", :integer
        t.column "hours", :integer
      end

      add_index "courses", ["title", "coursetype_id", "degrees_id"], :name => "courses_title_key", :unique => true

      create_table "coursesduration", :force => true do |t|
        t.column "name", :text, :null => false
        t.column "days", :integer, :null => false
      end

      add_index "coursesduration", ["name"], :name => "coursesduration_name_key", :unique => true

      create_table "coursetype", :force => true do |t|
        t.column "name", :text, :null => false
      end

      add_index "coursetype", ["name"], :name => "coursetype_name_key", :unique => true

      create_table "credentials", :force => true do |t|
        t.column "name", :text
        t.column "abbrev", :text
        t.column "moduser_id", :integer
      end

      add_index "credentials", ["name"], :name => "credentials_name_key", :unique => true

      create_table "degrees", :force => true do |t|
        t.column "name", :text, :null => false
      end

      add_index "degrees", ["name"], :name => "degrees_name_key", :unique => true

      create_table "editions", :force => true do |t|
        t.column "name", :text, :null => false
      end

      add_index "editions", ["name"], :name => "editions_name_key", :unique => true

      create_table "editionstatuses", :force => true do |t|
        t.column "name", :text, :null => false
      end

      add_index "editionstatuses", ["name"], :name => "editionstatuses_name_key", :unique => true

      create_table "externaluserlevels", :force => true do |t|
        t.column "name", :text, :null => false
      end

      add_index "externaluserlevels", ["name"], :name => "externaluserlevels_name_key", :unique => true

      create_table "externalusers", :force => true do |t|
        t.column "firstname", :text, :null => false
        t.column "lastname1", :text, :null => false
        t.column "lastname2", :text
        t.column "institution_id", :integer
        t.column "externaluserlevel_id", :integer
        t.column "degrees_id", :integer
      end

      add_index "externalusers", ["firstname"], :name => "externalusers_firstname_idx"
      add_index "externalusers", ["firstname", "lastname1", "lastname2"], :name => "externalusers_firstname_lastname1_lastname2_idx"
      add_index "externalusers", ["lastname1"], :name => "externalusers_lastname1_idx"
      add_index "externalusers", ["lastname2"], :name => "externalusers_lastname2_idx"

      create_table "file_articles", :force => true do |t|
        t.column "article_id", :integer, :null => false
        t.column "filename", :text, :null => false
        t.column "filedescr", :text
        t.column "content", :binary, :null => false
        t.column "creationtime", :datetime, :null => false
        t.column "lastmodiftime", :datetime, :null => false
        t.column "moduser_id", :integer
        t.column "created_on", :datetime
        t.column "updated_on", :datetime
      end

      add_index "file_articles", ["article_id", "filename"], :name => "file_articles_article_id_key", :unique => true

      create_table "filesprojects", :force => true do |t|
        t.column "project_id", :integer, :null => false
        t.column "filename", :text, :null => false
        t.column "filedescr", :text
        t.column "content", :binary, :null => false
        t.column "creationtime", :datetime, :null => false
        t.column "lastmodiftime", :datetime, :null => false
        t.column "moduser_id", :integer
        t.column "created_on", :datetime
        t.column "updated_on", :datetime
      end

      add_index "filesprojects", ["project_id", "filename"], :name => "filesprojects_project_id_key", :unique => true

      create_table "genericworkgroups", :force => true do |t|
        t.column "name", :text, :null => false
      end

      add_index "genericworkgroups", ["name"], :name => "genericworkgroups_name_key", :unique => true

      create_table "genericworks", :force => true do |t|
        t.column "authors", :text, :null => false
        t.column "title", :text, :null => false
        t.column "genericworktypes_id", :integer, :null => false
        t.column "genericworkstatus_id", :integer, :null => false
        t.column "institution_id", :integer
        t.column "publisher_id", :integer
        t.column "reference", :text
        t.column "vol", :text
        t.column "pages", :text
        t.column "year", :integer, :null => false
        t.column "month", :integer
        t.column "isbn_issn", :text
        t.column "numcites", :integer
        t.column "other", :text
        t.column "moduser_id", :integer
      end

      create_table "genericworksfiles", :force => true do |t|
        t.column "filename", :text, :null => false
        t.column "genericworks_id", :integer, :null => false
        t.column "filedescr", :text
        t.column "content", :binary, :null => false
        t.column "creationtime", :datetime, :null => false
        t.column "lastmodiftime", :datetime, :null => false
        t.column "moduser_id", :integer
        t.column "created_on", :datetime
        t.column "updated_on", :datetime
      end

      add_index "genericworksfiles", ["filename"], :name => "genericworksfiles_filename_idx"
      add_index "genericworksfiles", ["filename", "genericworks_id"], :name => "genericworksfiles_genericworks_id_key", :unique => true
      add_index "genericworksfiles", ["genericworks_id"], :name => "genericworksfiles_genericworks_idx"

      create_table "genericworkstatus", :force => true do |t|
        t.column "name", :text, :null => false
      end

      add_index "genericworkstatus", ["name"], :name => "genericworkstatus_name_key", :unique => true

      create_table "genericworktypes", :force => true do |t|
        t.column "name", :text, :null => false
        t.column "abbrev", :text
        t.column "genericworkgroup_id", :integer, :null => false
        t.column "moduser_id", :integer
      end

      add_index "genericworktypes", ["abbrev"], :name => "genericworktypes_abbrev_key", :unique => true
      add_index "genericworktypes", ["name"], :name => "genericworktypes_name_key", :unique => true

      create_table "grants", :force => true do |t|
        t.column "title", :text, :null => false
        t.column "institution_id", :integer, :null => false
        t.column "moduser_id", :integer
      end

      add_index "grants", ["title", "institution_id"], :name => "grants_title_key", :unique => true

      create_table "groupmodalities", :force => true do |t|
        t.column "name", :text, :null => false
      end

      add_index "groupmodalities", ["name"], :name => "groupmodalities_name_key", :unique => true

      create_table "groups", :force => true do |t|
        t.column "name", :text, :null => false
        t.column "descr", :text
        t.column "created_on", :datetime
        t.column "updated_on", :datetime
      end

      add_index "groups", ["name"], :name => "groups_name_key", :unique => true

      create_table "groups_permissions", :force => true do |t|
        t.column "group_id", :integer, :null => false
        t.column "permission_id", :integer, :null => false
      end

      add_index "groups_permissions", ["group_id", "permission_id"], :name => "gp_map_idx"
      add_index "groups_permissions", ["group_id", "permission_id"], :name => "groups_permissions_group_id_key", :unique => true

      create_table "identifications", :force => true do |t|
        t.column "name", :text, :null => false
      end

      add_index "identifications", ["name"], :name => "identifications_name_key", :unique => true

      create_table "indivadvice", :force => true do |t|
        t.column "user_is_internal", :boolean
        t.column "user_id", :integer, :null => false
        t.column "externaluser_id", :integer
        t.column "internaluser_id", :integer
        t.column "institution_id", :integer
        t.column "indivadvicetarget_id", :integer, :null => false
        t.column "indivadviceprogram_id", :integer
        t.column "degrees_id", :integer
        t.column "year", :integer, :null => false
        t.column "month", :integer
        t.column "hours", :integer, :null => false
        t.column "other", :text
      end

      create_table "indivadviceprogram", :force => true do |t|
        t.column "name", :text, :null => false
        t.column "moduser_id", :integer
      end

      add_index "indivadviceprogram", ["name"], :name => "indivadviceprogram_name_key", :unique => true

      create_table "indivadvicetarget", :force => true do |t|
        t.column "name", :text, :null => false
        t.column "moduser_id", :integer
      end

      add_index "indivadvicetarget", ["name"], :name => "indivadvicetarget_name_key", :unique => true

      create_table "instadvice", :force => true do |t|
        t.column "title", :text, :null => false
        t.column "acadprogram", :text
        t.column "user_id", :integer, :null => false
        t.column "institution_id", :integer, :null => false
        t.column "instadvicetarget_id", :integer, :null => false
        t.column "degrees_id", :integer
        t.column "other", :text
        t.column "year", :integer, :null => false
        t.column "month", :integer
      end

      create_table "instadviceactivity", :force => true do |t|
        t.column "instadvice_id", :integer, :null => false
        t.column "adviceactivity_id", :integer, :null => false
        t.column "duration", :text
      end

      add_index "instadviceactivity", ["instadvice_id", "adviceactivity_id"], :name => "instadviceactivity_instadvice_id_key", :unique => true

      create_table "instadvicetarget", :force => true do |t|
        t.column "name", :text, :null => false
        t.column "moduser_id", :integer
      end

      add_index "instadvicetarget", ["name"], :name => "instadvicetarget_name_key", :unique => true

      create_table "institution_sectors", :force => true do |t|
        t.column "institution_id", :integer, :null => false
        t.column "sector_id", :integer, :null => false
        t.column "moduser_id", :integer
      end

      add_index "institution_sectors", ["institution_id", "sector_id"], :name => "institution_sectors_institution_id_key", :unique => true

      create_table "institutioncareers", :force => true do |t|
        t.column "institution_id", :integer, :null => false
        t.column "degree_id", :integer, :null => false
        t.column "career_id", :integer, :null => false
        t.column "url", :text
        t.column "other", :text
        t.column "moduser_id", :integer
      end

      add_index "institutioncareers", ["institution_id", "career_id"], :name => "institutioncareers_institution_id_key", :unique => true

      create_table "institutions", :force => true do |t|
        t.column "institutiontype_id", :integer, :null => false
        t.column "name", :text, :null => false
        t.column "url", :text
        t.column "abbrev", :text
        t.column "institution_id", :integer
        t.column "institutiontitle_id", :integer, :null => false
        t.column "addr", :text
        t.column "country_id", :integer, :null => false
        t.column "state_id", :integer
        t.column "city_id", :integer
        t.column "zipcode", :text
        t.column "phone", :text
        t.column "fax", :text
        t.column "administrative_key", :text
        t.column "other", :text
        t.column "moduser_id", :integer
        t.column "created_on", :datetime
        t.column "updated_on", :datetime
      end

      add_index "institutions", ["name", "country_id", "state_id"], :name => "institutions_name_key", :unique => true

      create_table "institutiontitles", :force => true do |t|
        t.column "name", :text, :null => false
      end

      add_index "institutiontitles", ["name"], :name => "institutiontitles_name_key", :unique => true

      create_table "institutiontypes", :force => true do |t|
        t.column "name", :text, :null => false
      end

      add_index "institutiontypes", ["name"], :name => "institutiontypes_name_key", :unique => true

      create_table "jobpositioncategories", :force => true do |t|
        t.column "jobpositiontype_id", :integer, :null => false
        t.column "roleinjobposition_id", :integer, :null => false
        t.column "jobpositionlevel_id", :integer, :null => false
        t.column "administrative_key", :text
      end

      add_index "jobpositioncategories", ["jobpositiontype_id", "roleinjobposition_id", "jobpositionlevel_id"], :name => "jobpositioncategories_jobpositiontype_id_key", :unique => true

      create_table "jobpositionlevels", :force => true do |t|
        t.column "name", :text, :null => false
      end

      add_index "jobpositionlevels", ["name"], :name => "jobpositionlevels_name_key", :unique => true

      create_table "jobpositions", :force => true do |t|
        t.column "user_id", :integer, :null => false
        t.column "jobpositioncategory_id", :integer
        t.column "contracttype_id", :integer
        t.column "institution_id", :integer, :null => false
        t.column "descr", :text
        t.column "startmonth", :integer
        t.column "startyear", :integer, :null => false
        t.column "endmonth", :integer
        t.column "endyear", :integer
        t.column "moduser_id", :integer
        t.column "created_on", :datetime
        t.column "updated_on", :datetime
      end

      create_table "jobpositiontypes", :force => true do |t|
        t.column "name", :text, :null => false
      end

      add_index "jobpositiontypes", ["name"], :name => "jobpositiontypes_name_key", :unique => true

      create_table "journal_publicationcategories", :force => true do |t|
        t.column "journal_id", :integer, :null => false
        t.column "publicationcategory_id", :integer, :null => false
        t.column "moduser_id", :integer
      end

      add_index "journal_publicationcategories", ["journal_id", "publicationcategory_id"], :name => "journal_publicationcategories_journal_id_key", :unique => true

      create_table "journals", :force => true do |t|
        t.column "name", :text, :null => false
        t.column "issn", :text
        t.column "url", :text
        t.column "abbrev", :text
        t.column "other", :text
        t.column "totalcites", :integer
        t.column "impactfactor", :float
        t.column "immediacy", :text
        t.column "dateupdate", :date
        t.column "journaltype_id", :integer, :null => false
        t.column "mediatype_id", :integer, :null => false
        t.column "publisher_id", :integer, :null => false
        t.column "country_id", :integer, :null => false
        t.column "moduser_id", :integer
      end

      add_index "journals", ["issn"], :name => "journals_issn_key", :unique => true

      create_table "journaltypes", :force => true do |t|
        t.column "name", :string, :limit => 50, :null => false
      end

      add_index "journaltypes", ["name"], :name => "journaltypes_name_key", :unique => true

      create_table "languages", :force => true do |t|
        t.column "name", :text, :null => false
        t.column "moduser_id", :integer
      end

      add_index "languages", ["name"], :name => "languages_name_key", :unique => true

      create_table "maritalstatuses", :force => true do |t|
        t.column "name", :text, :null => false
      end

      add_index "maritalstatuses", ["name"], :name => "maritalstatuses_name_key", :unique => true

      create_table "mediatypes", :force => true do |t|
        t.column "name", :text, :null => false
      end

      add_index "mediatypes", ["name"], :name => "mediatypes_name_key", :unique => true

      create_table "memberships", :force => true do |t|
        t.column "user_id", :integer, :null => false
        t.column "institution_id", :integer, :null => false
        t.column "descr", :text
        t.column "startyear", :integer
        t.column "endyear", :integer
        t.column "moduser_id", :integer
        t.column "created_on", :datetime
        t.column "updated_on", :datetime
      end

      create_table "menus", :force => true do |t|
        t.column "label", :text, :null => false
        t.column "parent_menu_id", :integer
        t.column "group_id", :integer, :null => false
        t.column "ordering", :integer, :null => false
        t.column "iconopen", :text
        t.column "iconclosed", :text
        t.column "iconpath", :text
        t.column "style", :text
        t.column "action", :text
        t.column "target", :text
        t.column "expanded", :boolean, :default => false, :null => false
      end

      add_index "menus", ["label", "parent_menu_id"], :name => "menus_label_key", :unique => true

      create_table "migratorystatuses", :force => true do |t|
        t.column "name", :text, :null => false
      end

      add_index "migratorystatuses", ["name"], :name => "migratorystatuses_name_key", :unique => true

      create_table "modalities", :force => true do |t|
        t.column "name", :text, :null => false
      end

      add_index "modalities", ["name"], :name => "modalities_name_key", :unique => true

      create_table "newspaper_articles", :force => true do |t|
        t.column "title", :text, :null => false
        t.column "authors", :text, :null => false
        t.column "newspaper_id", :integer, :null => false
        t.column "newsdate", :date, :null => false
        t.column "pages", :text
        t.column "url", :text
      end

      add_index "newspaper_articles", ["title", "newspaper_id", "newsdate"], :name => "newspaper_articles_title_key", :unique => true

      create_table "newspaper_articleslog", :force => true do |t|
        t.column "newspaperarticle_id", :integer, :null => false
        t.column "old_articlestatus_id", :integer, :null => false
        t.column "changedate", :date, :null => false
        t.column "moduser_id", :integer
        t.column "created_on", :datetime
        t.column "updated_on", :datetime
      end

      create_table "newspapers", :force => true do |t|
        t.column "name", :text, :null => false
        t.column "url", :text
        t.column "moduser_id", :integer
      end

      add_index "newspapers", ["name"], :name => "newspapers_name_key", :unique => true

      create_table "organ", :force => true do |t|
        t.column "name", :text, :null => false
        t.column "abbrev", :text
        t.column "organtype_id", :integer, :null => false
        t.column "institution_id", :integer, :null => false
        t.column "moduser_id", :integer
      end

      add_index "organ", ["abbrev"], :name => "organ_abbrev_key", :unique => true
      add_index "organ", ["name"], :name => "organ_name_key", :unique => true

      create_table "organtype", :force => true do |t|
        t.column "name", :text, :null => false
      end

      add_index "organtype", ["name"], :name => "organtype_name_key", :unique => true

      create_table "peopleids", :force => true do |t|
        t.column "user_id", :integer, :null => false
        t.column "identification_id", :integer, :null => false
        t.column "descr", :text, :null => false
        t.column "citizen_country_id", :integer, :null => false
        t.column "moduser_id", :integer
        t.column "created_on", :datetime
        t.column "updated_on", :datetime
      end

      add_index "peopleids", ["user_id", "identification_id", "citizen_country_id"], :name => "peopleids_user_id_key", :unique => true

      create_table "permissions", :force => true do |t|
        t.column "name", :text, :null => false
        t.column "descr", :text
        t.column "created_on", :datetime
        t.column "updated_on", :datetime
      end

      create_table "personals", :id => false, :force => true do |t|
        t.column "user_id", :integer, :null => false
        t.column "firstname", :text, :null => false
        t.column "lastname1", :text, :null => false
        t.column "lastname2", :text
        t.column "sex", :boolean, :null => false
        t.column "maritalstatus_id", :integer, :null => false
        t.column "dateofbirth", :date, :null => false
        t.column "birth_country_id", :integer, :null => false
        t.column "birth_state_id", :integer
        t.column "birth_city_id", :integer
        t.column "photo_filename", :text
        t.column "photo_content_type", :text
        t.column "photo", :binary
        t.column "other", :text
        t.column "moduser_id", :integer
        t.column "created_on", :datetime
        t.column "updated_on", :datetime
      end

      add_index "personals", ["firstname"], :name => "personals_firstname_idx"
      add_index "personals", ["dateofbirth"], :name => "personals_firstname_lastname1_lastname2_idx", :unique => true
      add_index "personals", ["lastname1"], :name => "personals_lastname1_idx"
      add_index "personals", ["lastname2"], :name => "personals_lastname2_idx"

      create_table "plan", :force => true do |t|
        t.column "user_id", :integer, :null => false
        t.column "plan", :text, :null => false
        t.column "extendedinfo", :binary
        t.column "year", :integer, :null => false
      end

      create_table "prizes", :force => true do |t|
        t.column "title", :text, :null => false
        t.column "prizetypes_id", :integer, :null => false
        t.column "institution_id", :integer, :null => false
        t.column "moduser_id", :integer
      end

      add_index "prizes", ["title", "institution_id"], :name => "prizes_title_key", :unique => true

      create_table "prizetypes", :force => true do |t|
        t.column "name", :text, :null => false
      end

      add_index "prizetypes", ["name"], :name => "prizetypes_name_key", :unique => true

      create_table "professionaltitles", :force => true do |t|
        t.column "schooling_id", :integer, :null => false
        t.column "titlemodalities_id", :integer, :null => false
        t.column "professionalid", :text
        t.column "year", :integer
        t.column "thesistitle", :text
        t.column "moduser_id", :integer
      end

      add_index "professionaltitles", ["schooling_id"], :name => "professionaltitles_schooling_id_key", :unique => true

      create_table "projectfinancingsource", :force => true do |t|
        t.column "project_id", :integer, :null => false
        t.column "financingsource_id", :integer, :null => false
        t.column "amount", :integer, :null => false
        t.column "other", :text
      end

      add_index "projectfinancingsource", ["project_id", "financingsource_id"], :name => "projectfinancingsource_project_id_key", :unique => true

      create_table "projectinstitutions", :force => true do |t|
        t.column "project_id", :integer, :null => false
        t.column "institution_id", :integer, :null => false
        t.column "other", :text
      end

      add_index "projectinstitutions", ["project_id", "institution_id"], :name => "projectinstitutions_project_id_key", :unique => true

      create_table "projectresearchareas", :force => true do |t|
        t.column "project_id", :integer, :null => false
        t.column "researchareas_id", :integer, :null => false
        t.column "other", :text
      end

      add_index "projectresearchareas", ["project_id", "researchareas_id"], :name => "projectresearchareas_project_id_key", :unique => true

      create_table "projectresearchlines", :force => true do |t|
        t.column "project_id", :integer, :null => false
        t.column "researchlines_id", :integer, :null => false
        t.column "other", :text
      end

      add_index "projectresearchlines", ["project_id", "researchlines_id"], :name => "projectresearchlines_project_id_key", :unique => true

      create_table "projects", :force => true do |t|
        t.column "title", :text, :null => false
        t.column "description", :text, :null => false
        t.column "projectstype_id", :integer, :null => false
        t.column "projectstatus_id", :integer, :null => false
        t.column "parentproject_id", :integer
        t.column "subject", :text
        t.column "summary", :text
        t.column "abbrev", :text
        t.column "goals", :text
        t.column "notes", :text
        t.column "startyear", :integer, :null => false
        t.column "startmonth", :integer
        t.column "endyear", :integer
        t.column "endmonth", :integer
        t.column "url", :text
        t.column "other", :text
        t.column "moduser_id", :integer
      end

      add_index "projects", ["description"], :name => "projects_description_idx"
      add_index "projects", ["title"], :name => "projects_title_idx"
      add_index "projects", ["title"], :name => "projects_title_key", :unique => true

      create_table "projectsacadvisits", :force => true do |t|
        t.column "project_id", :integer, :null => false
        t.column "acadvisits_id", :integer, :null => false
      end

      add_index "projectsacadvisits", ["project_id", "acadvisits_id"], :name => "projectsacadvisits_project_id_key", :unique => true

      create_table "projectsarticles", :force => true do |t|
        t.column "project_id", :integer, :null => false
        t.column "article_id", :integer, :null => false
      end

      add_index "projectsarticles", ["project_id", "article_id"], :name => "projectsarticles_project_id_key", :unique => true

      create_table "projectsbooks", :force => true do |t|
        t.column "project_id", :integer, :null => false
        t.column "books_id", :integer, :null => false
      end

      add_index "projectsbooks", ["project_id", "books_id"], :name => "projectsbooks_project_id_key", :unique => true

      create_table "projectschapterinbooks", :force => true do |t|
        t.column "project_id", :integer, :null => false
        t.column "chapterinbook_id", :integer, :null => false
      end

      add_index "projectschapterinbooks", ["project_id", "chapterinbook_id"], :name => "projectschapterinbooks_project_id_key", :unique => true

      create_table "projectsconferencetalks", :force => true do |t|
        t.column "project_id", :integer, :null => false
        t.column "conferencetalks_id", :integer, :null => false
      end

      add_index "projectsconferencetalks", ["project_id", "conferencetalks_id"], :name => "projectsconferencetalks_project_id_key", :unique => true

      create_table "projectsgenericworks", :force => true do |t|
        t.column "project_id", :integer, :null => false
        t.column "genericworks_id", :integer, :null => false
      end

      add_index "projectsgenericworks", ["project_id", "genericworks_id"], :name => "projectsgenericworks_project_id_key", :unique => true

      create_table "projectslog", :force => true do |t|
        t.column "project_id", :integer, :null => false
        t.column "old_projectstatus_id", :integer, :null => false
        t.column "year", :integer, :null => false
        t.column "month", :integer
        t.column "moduser_id", :integer
        t.column "created_on", :datetime
        t.column "updated_on", :datetime
      end

      create_table "projectstatus", :force => true do |t|
        t.column "name", :text, :null => false
      end

      add_index "projectstatus", ["name"], :name => "projectstatus_name_key", :unique => true

      create_table "projectsthesis", :force => true do |t|
        t.column "project_id", :integer, :null => false
        t.column "thesis_id", :integer, :null => false
      end

      add_index "projectsthesis", ["project_id", "thesis_id"], :name => "projectsthesis_project_id_key", :unique => true

      create_table "projectstype", :force => true do |t|
        t.column "name", :text, :null => false
      end

      add_index "projectstype", ["name"], :name => "projectstype_name_key", :unique => true

      create_table "publicationcategories", :force => true do |t|
        t.column "name", :string, :limit => 50, :null => false
        t.column "descr", :text
        t.column "moduser_id", :integer
      end

      add_index "publicationcategories", ["name"], :name => "publicationcategories_name_key", :unique => true

      create_table "publishers", :force => true do |t|
        t.column "name", :text, :null => false
        t.column "descr", :text
        t.column "url", :text
        t.column "moduser_id", :integer
      end

      add_index "publishers", ["name"], :name => "publishers_name_key", :unique => true

      create_table "pubtorefereed", :force => true do |t|
        t.column "name", :text, :null => false
      end

      add_index "pubtorefereed", ["name"], :name => "pubtorefereed_name_key", :unique => true

      create_table "refereedpubs", :force => true do |t|
        t.column "title", :text, :null => false
        t.column "pubtorefereed_id", :integer, :null => false
        t.column "institution_id", :integer, :null => false
        t.column "moduser_id", :integer
      end

      create_table "researchareas", :force => true do |t|
        t.column "name", :text, :null => false
        t.column "description", :text
        t.column "moduser_id", :integer
      end

      add_index "researchareas", ["name"], :name => "researchareas_name_key", :unique => true

      create_table "researchgroupmodalities", :force => true do |t|
        t.column "groupmodality_id", :integer
        t.column "researchgroup_id", :integer, :null => false
        t.column "adscription_id", :integer
      end

      create_table "researchgroups", :force => true do |t|
        t.column "name", :text, :null => false
        t.column "descr", :text
        t.column "moduser_id", :integer
      end

      add_index "researchgroups", ["name"], :name => "researchgroups_name_key", :unique => true

      create_table "researchlines", :force => true do |t|
        t.column "name", :text, :null => false
        t.column "description", :text
        t.column "moduser_id", :integer
      end

      add_index "researchlines", ["name"], :name => "researchlines_name_key", :unique => true

      create_table "roleinbooks", :force => true do |t|
        t.column "name", :text, :null => false
      end

      add_index "roleinbooks", ["name"], :name => "roleinbooks_name_key", :unique => true

      create_table "roleincourse", :force => true do |t|
        t.column "name", :text, :null => false
      end

      add_index "roleincourse", ["name"], :name => "roleincourse_name_key", :unique => true

      create_table "roleindissertation", :force => true do |t|
        t.column "name", :text, :null => false
      end

      add_index "roleindissertation", ["name"], :name => "roleindissertation_name_key", :unique => true

      create_table "roleinjobpositions", :force => true do |t|
        t.column "name", :text, :null => false
      end

      add_index "roleinjobpositions", ["name"], :name => "roleinjobpositions_name_key", :unique => true

      create_table "roleinjournals", :force => true do |t|
        t.column "name", :text, :null => false
      end

      add_index "roleinjournals", ["name"], :name => "roleinjournals_name_key", :unique => true

      create_table "roleinorgan", :force => true do |t|
        t.column "name", :text, :null => false
        t.column "moduser_id", :integer
      end

      add_index "roleinorgan", ["name"], :name => "roleinorgan_name_key", :unique => true

      create_table "roleinproject", :force => true do |t|
        t.column "name", :text, :null => false
      end

      add_index "roleinproject", ["name"], :name => "roleinproject_name_key", :unique => true

      create_table "roleinthesis", :force => true do |t|
        t.column "name", :text, :null => false
      end

      add_index "roleinthesis", ["name"], :name => "roleinthesis_name_key", :unique => true

      create_table "schoolings", :force => true do |t|
        t.column "user_id", :integer, :null => false
        t.column "institutioncareer_id", :integer, :null => false
        t.column "credential_id", :integer, :null => false
        t.column "studentid", :text
        t.column "startyear", :integer, :null => false
        t.column "endyear", :integer
        t.column "titleholder", :boolean, :default => false, :null => false
        t.column "credits", :integer
        t.column "other", :text
        t.column "moduser_id", :integer
      end

      add_index "schoolings", ["user_id", "institutioncareer_id"], :name => "schoolings_user_id_key", :unique => true

      create_table "sectors", :force => true do |t|
        t.column "name", :text, :null => false
        t.column "moduser_id", :integer
      end

      add_index "sectors", ["name"], :name => "sectors_name_key", :unique => true

      create_table "selfevaluation", :force => true do |t|
        t.column "user_id", :integer, :null => false
        t.column "plan", :text, :null => false
        t.column "year", :integer, :null => false
      end

      create_table "sessions", :force => true do |t|
        t.column "session_id", :string
        t.column "data", :text
        t.column "updated_at", :datetime
      end

      add_index "sessions", ["session_id"], :name => "sessions_session_id_index"

      create_table "skilltypes", :force => true do |t|
        t.column "name", :text, :null => false
        t.column "moduser_id", :integer
      end

      add_index "skilltypes", ["name"], :name => "skilltypes_name_key", :unique => true

      create_table "sponsorsacadvisits", :force => true do |t|
        t.column "acadvisit_id", :integer, :null => false
        t.column "institution_id", :integer, :null => false
        t.column "amount", :integer, :null => false
      end

      create_table "states", :force => true do |t|
        t.column "country_id", :integer, :null => false
        t.column "name", :text, :null => false
        t.column "code", :text
        t.column "moduser_id", :integer
      end

      add_index "states", ["name"], :name => "states_name_key", :unique => true

      create_table "stimuluslevels", :force => true do |t|
        t.column "name", :text, :null => false
        t.column "stimulustype_id", :integer, :null => false
      end

      add_index "stimuluslevels", ["name", "stimulustype_id"], :name => "stimuluslevels_name_key", :unique => true

      create_table "stimuluslogs", :force => true do |t|
        t.column "stimulus_id", :integer, :null => false
        t.column "old_stimulusstatus_id", :integer, :null => false
        t.column "changedate", :date, :null => false
        t.column "moduser_id", :integer
        t.column "created_on", :datetime
        t.column "updated_on", :datetime
      end

      create_table "stimulusstatus", :force => true do |t|
        t.column "name", :string, :limit => 50, :null => false
      end

      add_index "stimulusstatus", ["name"], :name => "stimulusstatus_name_key", :unique => true

      create_table "stimulustypes", :force => true do |t|
        t.column "name", :text, :null => false
        t.column "descr", :text
        t.column "institution_id", :integer, :null => false
      end

      add_index "stimulustypes", ["name"], :name => "stimulustypes_name_key", :unique => true

      create_table "studentsthesis", :force => true do |t|
        t.column "thesis_id", :integer, :null => false
        t.column "user_is_internal", :boolean
        t.column "externaluser_id", :integer
        t.column "internaluser_id", :integer
      end

      add_index "studentsthesis", ["thesis_id", "internaluser_id"], :name => "studentsthesis_thesis_id_key", :unique => true
      add_index "studentsthesis", ["thesis_id", "externaluser_id"], :name => "studentsthesis_thesis_id_key1", :unique => true

      create_table "talkacceptance", :force => true do |t|
        t.column "name", :text, :null => false
      end

      add_index "talkacceptance", ["name"], :name => "talkacceptance_name_key", :unique => true

      create_table "talktype", :force => true do |t|
        t.column "name", :text, :null => false
      end

      add_index "talktype", ["name"], :name => "talktype_name_key", :unique => true

      create_table "techproductfinancingsource", :force => true do |t|
        t.column "techproduct_id", :integer, :null => false
        t.column "financingsource_id", :integer, :null => false
        t.column "amount", :integer, :null => false
        t.column "other", :text
      end

      add_index "techproductfinancingsource", ["techproduct_id", "financingsource_id"], :name => "techproductfinancingsource_techproduct_id_key", :unique => true

      create_table "techproducts", :force => true do |t|
        t.column "techproducttype_id", :integer
        t.column "title", :text, :null => false
        t.column "authors", :text, :null => false
        t.column "descr", :text
        t.column "institution_id", :integer
        t.column "moduser_id", :integer
      end

      create_table "techproductstatus", :force => true do |t|
        t.column "name", :text, :null => false
      end

      add_index "techproductstatus", ["name"], :name => "techproductstatus_name_key", :unique => true

      create_table "techproducttypes", :force => true do |t|
        t.column "name", :text, :null => false
        t.column "moduser_id", :integer
      end

      create_table "techproductversions", :force => true do |t|
        t.column "techproduct_id", :integer
        t.column "techproductstatus_id", :integer, :null => false
        t.column "release", :text, :null => false
        t.column "descr", :text
        t.column "year", :integer, :null => false
        t.column "month", :integer
        t.column "isbn", :text
        t.column "other", :text
      end

      create_table "thesis", :force => true do |t|
        t.column "title", :text, :null => false
        t.column "institution_id", :integer, :null => false
        t.column "degree_id", :integer, :null => false
        t.column "thesisstatus_id", :integer, :null => false
        t.column "thesismodality_id", :integer, :null => false
        t.column "career_id", :integer, :null => false
        t.column "year", :integer, :null => false
        t.column "month", :integer
        t.column "moduser_id", :integer
      end

      add_index "thesis", ["title", "degree_id", "year"], :name => "thesis_title_key", :unique => true

      create_table "thesislog", :force => true do |t|
        t.column "thesis_id", :integer, :null => false
        t.column "old_thesisstatus_id", :integer, :null => false
        t.column "year", :integer, :null => false
        t.column "month", :integer
        t.column "moduser_id", :integer
        t.column "created_on", :datetime
        t.column "updated_on", :datetime
      end

      create_table "thesismodality", :force => true do |t|
        t.column "name", :text, :null => false
      end

      add_index "thesismodality", ["name"], :name => "thesismodality_name_key", :unique => true

      create_table "thesisstatus", :force => true do |t|
        t.column "name", :text, :null => false
      end

      add_index "thesisstatus", ["name"], :name => "thesisstatus_name_key", :unique => true

      create_table "titlemodalities", :force => true do |t|
        t.column "name", :string, :limit => 30, :null => false
      end

      add_index "titlemodalities", ["name"], :name => "titlemodalities_name_key", :unique => true

      create_table "user_articles", :force => true do |t|
        t.column "user_id", :integer, :null => false
        t.column "article_id", :integer, :null => false
        t.column "ismainauthor", :boolean, :default => true, :null => false
        t.column "other", :text
        t.column "created_on", :datetime
        t.column "updated_on", :datetime
      end

      create_table "user_groups", :force => true do |t|
        t.column "user_id", :integer, :null => false
        t.column "group_id", :integer, :default => 1, :null => false
        t.column "created_on", :datetime
        t.column "updated_on", :datetime
      end

      create_table "user_journals", :force => true do |t|
        t.column "user_id", :integer, :null => false
        t.column "journal_id", :integer, :null => false
        t.column "roleinjournal_id", :integer, :null => false
        t.column "startyear", :integer, :null => false
        t.column "startmonth", :integer
        t.column "endyear", :integer
        t.column "endmonth", :integer
        t.column "numcites", :integer
        t.column "other", :text
        t.column "created_on", :datetime
        t.column "updated_on", :datetime
      end

      create_table "useractivities", :force => true do |t|
        t.column "user_id", :integer, :null => false
        t.column "userrole_id", :integer
        t.column "activities_id", :integer, :null => false
        t.column "startyear", :integer, :null => false
        t.column "startmonth", :integer
        t.column "endyear", :integer
        t.column "endmonth", :integer
        t.column "other", :text
      end

      create_table "useradscriptions", :force => true do |t|
        t.column "jobposition_id", :integer, :null => false
        t.column "adscription_id", :integer, :null => false
        t.column "name", :text
        t.column "descr", :text
        t.column "startmonth", :integer
        t.column "startyear", :integer, :null => false
        t.column "endmonth", :integer
        t.column "endyear", :integer
      end

      create_table "userconferencerole", :force => true do |t|
        t.column "userconference_id", :integer, :null => false
        t.column "attendeetype_id", :integer, :null => false
        t.column "conferencetalk_id", :integer
        t.column "comments", :text
      end

      add_index "userconferencerole", ["userconference_id", "attendeetype_id", "conferencetalk_id"], :name => "userconferencerole_userconference_id_key", :unique => true

      create_table "userconferences", :force => true do |t|
        t.column "conference_id", :integer, :null => false
        t.column "user_id", :integer, :null => false
      end

      add_index "userconferences", ["conference_id", "user_id"], :name => "userconferences_user_id_key", :unique => true

      create_table "usercourses", :force => true do |t|
        t.column "user_id", :integer, :null => false
        t.column "courses_id", :integer
        t.column "coursegroup_id", :integer
        t.column "roleincourse_id", :integer, :null => false
        t.column "institution_id", :integer
        t.column "country_id", :integer, :null => false
        t.column "coursesduration_id", :integer, :null => false
        t.column "modality_id", :integer, :null => false
        t.column "hoursxweek", :integer
        t.column "year", :integer, :null => false
        t.column "month", :integer
        t.column "location", :text
        t.column "acadprogram", :text
        t.column "other", :text
      end

      create_table "usercredits", :force => true do |t|
        t.column "user_id", :integer
        t.column "internalusergive_id", :integer
        t.column "externalusergive_id", :integer
        t.column "usergive_is_internal", :boolean
        t.column "other", :text
        t.column "year", :integer, :null => false
        t.column "month", :integer
      end

      create_table "usercreditsarticles", :force => true do |t|
        t.column "usercredits_id", :integer, :null => false
        t.column "articles_id", :integer, :null => false
      end

      add_index "usercreditsarticles", ["usercredits_id", "articles_id"], :name => "usercreditsarticles_usercredits_id_key", :unique => true

      create_table "usercreditsbooks", :force => true do |t|
        t.column "usercredits_id", :integer, :null => false
        t.column "books_id", :integer, :null => false
      end

      add_index "usercreditsbooks", ["usercredits_id", "books_id"], :name => "usercreditsbooks_usercredits_id_key", :unique => true

      create_table "usercreditschapterinbooks", :force => true do |t|
        t.column "usercredits_id", :integer, :null => false
        t.column "chapterinbooks_id", :integer, :null => false
      end

      add_index "usercreditschapterinbooks", ["usercredits_id", "chapterinbooks_id"], :name => "usercreditschapterinbooks_usercredits_id_key", :unique => true

      create_table "usercreditsconferencetalks", :force => true do |t|
        t.column "usercredits_id", :integer, :null => false
        t.column "conferencetalks_id", :integer, :null => false
      end

      add_index "usercreditsconferencetalks", ["usercredits_id", "conferencetalks_id"], :name => "usercreditsconferencetalks_usercredits_id_key", :unique => true

      create_table "usercreditsgenericworks", :force => true do |t|
        t.column "usercredits_id", :integer, :null => false
        t.column "genericworks_id", :integer, :null => false
      end

      add_index "usercreditsgenericworks", ["usercredits_id", "genericworks_id"], :name => "usercreditsgenericworks_usercredits_id_key", :unique => true

      create_table "userdissthesis", :force => true do |t|
        t.column "user_id", :integer
        t.column "thesis_id", :integer, :null => false
        t.column "roleindissertation_id", :integer, :null => false
        t.column "year", :integer, :null => false
        t.column "month", :integer
      end

      add_index "userdissthesis", ["user_id", "thesis_id", "roleindissertation_id"], :name => "userdissthesis_user_id_key", :unique => true

      create_table "usergenericworks", :force => true do |t|
        t.column "genericwork_id", :integer, :null => false
        t.column "user_is_internal", :boolean
        t.column "externaluser_id", :integer
        t.column "internaluser_id", :integer
        t.column "userrole_id", :integer, :null => false
      end

      add_index "usergenericworks", ["genericwork_id", "internaluser_id"], :name => "usergenericworks_genericwork_id_key", :unique => true
      add_index "usergenericworks", ["genericwork_id", "externaluser_id"], :name => "usergenericworks_genericwork_id_key1", :unique => true

      create_table "usergenericworkslog", :force => true do |t|
        t.column "usergenericworks_id", :integer, :null => false
        t.column "old_genericworkstatus_id", :integer, :null => false
        t.column "changedate", :date, :null => false
        t.column "moduser_id", :integer
        t.column "created_on", :datetime
        t.column "updated_on", :datetime
      end

      create_table "usergrants", :force => true do |t|
        t.column "grants_id", :integer, :null => false
        t.column "user_id", :integer, :null => false
        t.column "description", :text
        t.column "startyear", :integer, :null => false
        t.column "startmonth", :integer
        t.column "endyear", :integer
        t.column "endmonth", :integer
      end

      add_index "usergrants", ["grants_id", "user_id", "startyear", "startmonth"], :name => "usergrants_grants_id_key", :unique => true

      create_table "userlanguages", :force => true do |t|
        t.column "user_id", :integer, :null => false
        t.column "languages_id", :integer, :null => false
        t.column "spokenpercentage", :integer
        t.column "writtenpercentaje", :integer
        t.column "comment", :text
      end

      create_table "usernewspaper_articles", :force => true do |t|
        t.column "user_id", :integer, :null => false
        t.column "newspaperarticle_id", :integer, :null => false
        t.column "ismainauthor", :boolean, :default => true, :null => false
        t.column "other", :text
        t.column "created_on", :datetime
        t.column "updated_on", :datetime
      end

      create_table "userorgan", :force => true do |t|
        t.column "user_id", :integer, :null => false
        t.column "organ_id", :integer, :null => false
        t.column "roleinorgan_id", :integer, :null => false
        t.column "startyear", :integer, :null => false
        t.column "startmonth", :integer
        t.column "endyear", :integer
        t.column "endmonth", :integer
      end

      create_table "userprizes", :force => true do |t|
        t.column "year", :integer, :null => false
        t.column "prize_id", :integer, :null => false
        t.column "user_id", :integer, :null => false
      end

      add_index "userprizes", ["year", "prize_id", "user_id"], :name => "userprizes_prize_id_key", :unique => true

      create_table "userprojects", :force => true do |t|
        t.column "projects_id", :integer, :null => false
        t.column "user_is_internal", :boolean
        t.column "externaluser_id", :integer
        t.column "internaluser_id", :integer
        t.column "roleinproject_id", :integer, :null => false
      end

      add_index "userprojects", ["projects_id", "internaluser_id"], :name => "userprojects_projects_id_key", :unique => true
      add_index "userprojects", ["projects_id", "externaluser_id"], :name => "userprojects_projects_id_key1", :unique => true

      create_table "userrefereedpubs", :force => true do |t|
        t.column "refereedpubs_id", :integer, :null => false
        t.column "user_is_internal", :boolean
        t.column "externaluser_id", :integer
        t.column "internaluser_id", :integer
      end

      add_index "userrefereedpubs", ["refereedpubs_id", "externaluser_id", "internaluser_id"], :name => "userrefereedpubs_refereedpubs_id_key", :unique => true

      create_table "userresearchgroups", :force => true do |t|
        t.column "researchgroup_id", :integer, :null => false
        t.column "year", :integer, :null => false
        t.column "user_is_internal", :boolean
        t.column "externaluser_id", :integer
        t.column "internaluser_id", :integer
        t.column "moduser_id", :integer
      end

      add_index "userresearchgroups", ["researchgroup_id", "internaluser_id"], :name => "userresearchgroups_researchgroup_id_key", :unique => true
      add_index "userresearchgroups", ["researchgroup_id", "externaluser_id"], :name => "userresearchgroups_researchgroup_id_key1", :unique => true

      create_table "userresearchlines", :force => true do |t|
        t.column "user_id", :integer, :null => false
        t.column "researchlines_id", :integer, :null => false
      end

      create_table "userrole", :force => true do |t|
        t.column "name", :text, :null => false
        t.column "moduser_id", :integer
      end

      add_index "userrole", ["name"], :name => "userrole_name_key", :unique => true

      create_table "users", :force => true do |t|
        t.column "login", :text, :null => false
        t.column "passwd", :text, :null => false
        t.column "salt", :text
        t.column "userstatus_id", :integer, :default => 1, :null => false
        t.column "email", :text
        t.column "homepage", :text
        t.column "blog", :text
        t.column "calendar", :text
        t.column "pkcs7", :text
        t.column "token", :text
        t.column "token_expiry", :datetime
        t.column "created_on", :datetime
        t.column "updated_on", :datetime
      end

      add_index "users", ["id"], :name => "users_id_idx"
      add_index "users", ["login"], :name => "users_login_key", :unique => true
      add_index "users", ["login"], :name => "users_name_idx"

      create_table "userskills", :force => true do |t|
        t.column "user_id", :integer, :null => false
        t.column "skilltype_id", :integer, :null => false
        t.column "descr", :text
      end

      create_table "userstatuses", :force => true do |t|
        t.column "name", :text, :null => false
        t.column "created_on", :datetime
        t.column "updated_on", :datetime
      end

      add_index "userstatuses", ["name"], :name => "userstatuses_name_key", :unique => true

      create_table "userstimulus", :force => true do |t|
        t.column "user_id", :integer, :null => false
        t.column "stimuluslevel_id", :integer
        t.column "startmonth", :integer
        t.column "startyear", :integer, :null => false
        t.column "endmonth", :integer
        t.column "endyear", :integer
      end

      create_table "usertechproducts", :force => true do |t|
        t.column "techproduct_id", :integer, :null => false
        t.column "user_is_internal", :boolean
        t.column "externaluser_id", :integer
        t.column "internaluser_id", :integer
        t.column "userrole_id", :integer
      end

      add_index "usertechproducts", ["techproduct_id", "internaluser_id"], :name => "usertechproducts_techproduct_id_key", :unique => true
      add_index "usertechproducts", ["techproduct_id", "externaluser_id"], :name => "usertechproducts_techproduct_id_key1", :unique => true

      create_table "userthesis", :force => true do |t|
        t.column "thesis_id", :integer, :null => false
        t.column "roleinthesis_id", :integer, :null => false
        t.column "user_is_internal", :boolean
        t.column "externaluser_id", :integer
        t.column "internaluser_id", :integer
      end

      add_index "userthesis", ["thesis_id", "externaluser_id", "internaluser_id"], :name => "userthesis_thesis_id_key", :unique => true

      create_table "volumes", :force => true do |t|
        t.column "name", :text, :null => false
      end
      
      add_index "volumes", ["name"], :name => "volumes_name_key", :unique => true
    end
  end

  def self.down
  end
end
