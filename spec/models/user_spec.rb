require 'rails_helper'

RSpec.describe User, type: :model do
  # Association test
  # ensure User model has a 1:m relationship with the UserTask model
  it { should have_many(:user_tasks).dependent(:destroy) }
  # Validation tests
  # ensure column name is present before saving
  it { should validate_presence_of(:name) }
end
