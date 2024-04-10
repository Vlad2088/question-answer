require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  it { should have_many(:questions).dependent(:destroy) }
  it { should have_many(:answers).dependent(:destroy) }
  
  describe 'author_of' do
    let(:user) { create(:user) }
    let(:question) { create(:question, user: user) }
    
    context 'The user is the author' do
      it { expect(user.author_of?(question)).to be_truthy } 
    end

    context 'The user is not the author' do
      let(:not_author) { create(:user) }

      it { expect(not_author.author_of?(question)).to be_falsey } 
    end
  end
end
