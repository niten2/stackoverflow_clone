class SearchQuery

  include ActiveAttr::Model
  SEARCH_OPTIONS = %w(nil Questions Answers Comments Users)

  attribute :query
  attribute :index_type
  validates :index_type, inclusion: {in: SEARCH_OPTIONS}

end
