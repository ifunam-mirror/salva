class SuperScaffoldController < ApplicationController
  def initialize
    @hash_name    = ActiveSupport::Inflector.tableize(@model).singularize.to_sym
    @columns      = @model.column_names - %w(user_id created_at updated_at moduser_id)
    @find_options = { }
  end

  def index
    @columns << 'id'
    @collection = @model.paginate({ :select => @columns.compact.join(','), 
                                    :page => params[:page] || 1,:per_page => 5
                                   }.merge(@find_options))
    respond_to do |format|
      format.js { render :action => 'index.rjs' }
      format.html { render :action => 'index' }
    #  format.xml { render :xml => @collection }
    end
  end

  def show
    @record = @model.find(params[:id])
    respond_to do |format|
      format.js { render :action => 'show.rjs'}
      format.html { render :action => 'show'}
    end
  end

  def new
    @record = @model.new
    respond_to do |format|
      format.js { render :action => 'new.rjs' }
      format.html { render :action => 'new'}
      format.xml  { render :xml => @record }
    end
  end

  def edit
    @record = @model.find(params[:id])
    respond_to do |format|
      format.js { render :action => 'edit.rjs'}
      format.html { render :action => 'edit'}
    end
  end

  def create
    @record = @model.new(params[@hash_name])
    respond_to do |format|
      if @record.save
        format.js { responds_to_parent { render :action => 'create.rjs'} }
        format.html { redirect_to :action => :index }
        format.xml  { render :xml => @record, :status => :created, :location => @record }
      else
        format.js { responds_to_parent { render :action => 'errors.rjs' } }
        format.html { redirect_to :action => :new }
        format.xml  { render :xml => @record.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @record = @model.find(params[:id])
    respond_to do |format|
      if @record.update_attributes(params[@hash_name])
        format.js { responds_to_parent { render :action => 'update.rjs' } }
        format.html { redirect_to :action => :index }
        format.xml { head :ok }
      else
        format.js { responds_to_parent { render :action => 'errors.rjs' } }
        format.html { redirect_to :action => :edit }
        format.xml { render :xml => @record.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @record = @model.find(params[:id])
    @record.destroy
    respond_to do |format|
      format.js { render :action => 'destroy.rjs' }
      format.html { redirect_to  :action => :index }
    end
  end

  def destroy_all
    @collection = params[:id].collect { |id| @model.find(id) }
    respond_to do |format|
      format.js { render :partial => 'destroy_id.rjs',  :collection => @collection }
    end
    @model.delete(@collection.collect {|record| record.id })
  end
end
