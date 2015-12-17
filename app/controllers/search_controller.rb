class SearchController < ApplicationController
  skip_authorize_resource
  skip_authorization_check

  before_action :load_search_query, only: [:search]

  def find
  end

  def search
    # binding.pry
    respond_with(@result = sphinx_index.search(@search_query.q))
  end

  private

  def load_search_query
    @search_query = SearchQuery.new(search_query_params)
  end

  def sphinx_index
    indexes = %w(question answer comment user)
    @sphinx_index ||= if indexes.include?(@search_query.index_type)
                        Kernel.const_get(@search_query.index_type.capitalize)
                      else
                        ThinkingSphinx
                      end
  end

  def search_query_params
    params.require(:search_query).permit(:q, :index_type)
  end

end
