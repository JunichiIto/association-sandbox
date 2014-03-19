require 'spec_helper'

describe Post do
  describe 'association' do
    it "has comments" do
      expect(Post.new.comments.count).to eq 0
    end
    describe 'destroy comments' do
      before :each do
        @post = Post.create(text: 'こんにちは、伊藤です。')
        @post.comments.create(text: '山田です。伊藤さん、こんにちは！')
      end
      it 'destroys comments too' do
        expect{@post.destroy}.to change(Comment, :count).from(1).to(0)
      end
    end
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
