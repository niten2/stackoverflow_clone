require 'rails_helper'

RSpec.describe Attachment, type: :model do

  it { should belong_to :attachable }
  it { should belong_to :user }

end
