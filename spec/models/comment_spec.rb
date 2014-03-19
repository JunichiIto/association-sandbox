require 'spec_helper'

describe Comment do
  describe 'association' do
    before :each do
      @post = Post.create(text: 'こんにちは、伊藤です。')
    end
    context 'not associated' do
      it 'does not have post' do
        expect(Comment.new.post).to be_nil
      end
      it 'does not have post_id' do
        expect(Comment.new.post_id).to be_nil
      end
    end
    context 'associated' do
      it 'has post' do
        expect(@post.comments.build.post).to eq @post
      end
      it 'has post_id' do
        expect(@post.comments.build.post_id).to eq @post.id
      end
    end
  end
end
