require 'rails_helper'

describe Vote do
  it { should belong_to :votable }
  it { should belong_to :user }
end
