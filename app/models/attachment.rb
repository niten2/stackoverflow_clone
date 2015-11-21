class Attachment < ActiveRecord::Base

  belongs_to :question
  belongs_to :attachmentable

  mount_uploader :file, FileUploader

end
