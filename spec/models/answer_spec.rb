require 'rails_helper'

RSpec.describe Answer, type: :model do

  let(:answer) { create :answer }

  it { should belong_to(:question) }

  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:question_id) }
  it { should validate_presence_of(:user_id) }

  it "make_best sould true if false" do
    answer.make_best
    answer.best == true
  end


end
