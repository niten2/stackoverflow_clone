class SearchQuery
  include ActiveAttr::Model

  attribute :query
  attribute :index_type
  validates :index_type, inclusion: {in: [nil, 'question', 'answer', 'comment']}

end
