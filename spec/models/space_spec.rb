require 'spec_helper'

# describe Space, 'Validations' do
#   add test here
# end

describe Space, 'Associations' do
  it { should belong_to(:user) }
end
