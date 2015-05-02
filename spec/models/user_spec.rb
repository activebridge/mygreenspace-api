require 'spec_helper'

describe User, 'Validations' do
  subject { FactoryGirl.build(:user) }

  before do
    allow_any_instance_of(User).to receive(:signed_via_email?).and_return(true)
  end

  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_uniqueness_of(:email) }
end

describe User, 'Associations' do
  it { should have_many(:spaces) }
end
