require 'spec_helper'

describe CommentsController do
  before :each do
    @post = Post.create(text: 'こんにちは、伊藤です。')
    @comment = @post.comments.create(text: '山田です。伊藤さん、こんにちは！')
    @other_post = Post.create(text: 'こんにちは、鈴木です。')
  end
  describe 'DELETE destroy' do
    context 'invalid post_id' do
      it 'raises ActiveRecord::RecordNotFound' do
        expect{
          delete :destroy, id: @comment, post_id: @other_post
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end