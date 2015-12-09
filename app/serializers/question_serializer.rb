class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :created_at, :updated_at, :short_title
  attributes :id
  has_many :answers

  def short_title
    object.title.truncate(10)
  end
end
