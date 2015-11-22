FactoryGirl.define do
  factory :attachment do
    # file "#{Rails.root}/spec/spec_helper.rb"
    file { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'spec_helper.rb')) }
    # question
    association :attachable, factory: :question
  end

end
