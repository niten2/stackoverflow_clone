class WelcomesController < ApplicationController

  skip_check_authorization
  skip_authorize_resource

  def index
  end

end
