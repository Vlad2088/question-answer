require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should have_many(:answer) }

  it { should validate_presence_of(:title) } 
  it { should validate_presence_of(:body) }
  
end
