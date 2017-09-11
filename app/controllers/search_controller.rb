class SearchController < ApplicationController
  authorize_resource class: SearchController
  before_action :sphinx, only: [:search]

  def find
  end

  def search
    respond_with @resultes
  end

private
  def sphinx
    @resultes = ThinkingSphinx.search query, classes: [index_type]
  end

  def search_query_params
    params.require(:search_query).permit(:query, :index_type)
  end

  def index_type
    index_type = params[:search_query][:index_type]
    index_type == "nil" ? nil : index_type.singularize.constantize
  end

  def query
    params[:search_query][:query]
  end

end
