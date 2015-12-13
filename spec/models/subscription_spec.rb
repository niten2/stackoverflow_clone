require 'rails_helper'

describe Subscription do

  it { should belong_to(:user) }
  it { should belong_to(:question) }

end
