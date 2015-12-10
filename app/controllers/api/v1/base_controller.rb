class Api::V1::BaseController < ApplicationController
  check_authorization
  before_action :doorkeeper_authorize!

  respond_to :json

  rescue_from CanCan::AccessDenied do |exception|
    render json: {error: 'Вы не авторизованы'}
  end

  protected

  def current_ability
    @current_ability ||= Ability.new(current_resource_owner)
  end

  def current_resource_owner
    @current_resource_owner ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

end
