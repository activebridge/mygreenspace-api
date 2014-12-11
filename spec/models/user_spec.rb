require 'spec_helper'

describe User, 'Validations' do
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
end

describe User, 'Associations' do
  it { should have_many(:spaces) }
end
