class WelcomesController < ApplicationController
  skip_authorization_check
  skip_authorize_resource

  def index
  end

end
