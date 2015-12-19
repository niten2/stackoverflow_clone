class SearchController < ApplicationController
  # authorize_resource class: SearchQuery
  authorize_resource class: SearchController
  before_action :sphinx, only: [:search]
  # skip_authorization_check
  # skip_authorize_resource

  def find
  end

  def search
    # binding.pry
    # respond_with(@resultes = sphinx.try(:search, @search_query.query))
    # binding.pry
    # respond_with @resultes = sphinx
    respond_with @resultes

    # @resultes = ThinkingSphinx.search query, classes: index_type
  end

private

  # def set_search_query
  #   @search_query = SearchQuery.new(search_query_params)
  # end

  def sphinx
    # binding.pry

    # index_type = nil if index_type.nil?

    @resultes = ThinkingSphinx.search query, classes: [index_type]

    # indexes = %w(question answer comment user)
    # @search_query = SearchQuery.new(search_query_params)
    # @sphinx_index  = ThinkingSphinx.try(:search, @search_query.query)


    # @sphinx_index ||= if indexes.include?(@search_query.index_type)
    #                     Kernel.const_get(@search_query.index_type.capitalize)
    #                   else
    #                     ThinkingSphinx
    #                   end
  end

  def search_query_params
    params.require(:search_query).permit(:query, :index_type)
  end

  def index_type
    index_type = params[:search_query][:index_type]
    if index_type == "nil"
      nil
    else

      # condition.singularize.constantize.search(safe_query)
      # Kernel.const_get(index_type)
      index_type.singularize.constantize
    end
  end

  def query
    params[:search_query][:query]
  end

end
