class AnswerSerializer < ActiveModel::Serializer

  attributes :id, :content, :created_at, :updated_at

  has_many :comments
  has_many :attachments

end
