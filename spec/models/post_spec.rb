require 'spec_helper'

describe Post do
  it "has comments" do
    expect(Post.new.comments.count).to eq 0
  end
  describe 'validation' do
    context 'with text' do
      it 'is valid' do
        expect(Post.new(text: 'Hello')).to be_valid
      end
    end
    context 'without text' do
      it 'is invalid' do
        expect(Post.new(text: nil)).to have(1).error_on(:text)
      end
    end
  end
end
