#require File.dirname(_FILE_) + '/..test_helper'
require 'salva_controller_test'
require 'prizetype_controller'

# Re-raise errorscaught by the controller.
#class Address_Controller; def rescue_action(e) raise e end; end

class Prizetype_ControllerTest < SalvaControllerTest
  fixtures  :prizetypes

  def initialize(*args) #This is an ugly  hack, but  it works
    super
    @mycontroller = PrizetypeController.new
    @myfixtures =  {
      :name => "Nobel", :id =>1
          }
    @mybadfixtures= { :name =>nil, :id =>nil}
    @class = Prizetype
  end

end