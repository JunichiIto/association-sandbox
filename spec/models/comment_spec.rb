require 'spec_helper'

describe Comment do
  describe 'association' do
    before :each do
      @post = Post.create(text: 'こんにちは、伊藤です。')
    end
    context 'not associated' do
      before :each do
        @comment = Comment.new(text: '山田です。伊藤さん、こんにちは！')
      end
      it 'does not have post' do
        expect(@comment.post).to be_nil
      end
      it 'does not have post_id' do
        expect(@comment.post_id).to be_nil
      end
      specify 'post does not have comments' do
        expect(@post.comments).to be_empty
      end
    end
    context 'associated' do
      before :each do
        @comment = @post.comments.build(text: '山田です。伊藤さん、こんにちは！')
      end
      it 'has post' do
        expect(@comment.post).to eq @post
      end
      it 'has post_id' do
        expect(@comment.post_id).to eq @post.id
      end
      specify 'post has a comment' do
        expect(@post.comments).to eq [@comment]
      end
    end
  end
end
