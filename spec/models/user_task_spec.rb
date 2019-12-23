require 'rails_helper'

RSpec.describe UserTask, type: :model do
  # Association test
  # ensure an UserTask record belongs to a single User record
  it { should belong_to(:user) }
  # Validation test
  # ensure column description is present before saving
  it { should validate_presence_of(:description) }
end
