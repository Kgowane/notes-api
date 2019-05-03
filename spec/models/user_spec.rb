require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:notes) }
  it { validate_presence_of(:name) }
  it { validate_presence_of(:email) }
  it { validate_presence_of(:password_digest) }
end
