class SearchController < ApplicationController
  before_action :authenticate_user!
  before_action :set_search_query, only: [:search]
  authorize_resource class: SearchController

  def find
  end

  def search
    respond_with(@resultes = sphinx.try(:search, @search_query.query))
  end

private

  def set_search_query
    @search_query = SearchQuery.new(search_query_params)
  end

  def sphinx
    indexes = %w(question answer comment user)
    @sphinx_index ||= if indexes.include?(@search_query.index_type)
                        Kernel.const_get(@search_query.index_type.capitalize)
                      else
                        ThinkingSphinx
                      end
  end

  def search_query_params
    params.require(:search_query).permit(:query, :index_type)
  end

end
