require 'rails_helper'

describe QuestionsController do
  let(:other_user) { create :user }
  let(:user) { create :user }
  let(:object) { create :question, user: user }

  it_behaves_like "Vote"

end

describe AnswersController do
  let(:other_user) { create :user }
  let(:user) { create :user }
  let(:question) { create :question, user: user }
  let(:object) { create :answer, user: user }

  it_behaves_like "Vote"

end
