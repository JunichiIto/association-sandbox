require 'spec_helper'

describe CommentsController do
  describe 'GET new' do
    before :each do
      @post = Post.create(text: 'こんにちは、伊藤です。')
    end
    specify 'comment has post' do
      get :new, post_id: @post
      expect(assigns(:comment).post).to eq @post
    end
  end
  describe 'GET edit' do
    before :each do
      @post = Post.create(text: 'こんにちは、伊藤です。')
      @comment = @post.comments.create(text: '山田です。伊藤さん、こんにちは！')
      @other_post = Post.create(text: 'こんにちは、鈴木です。')
    end
    context 'invalid post_id' do
      it 'raises ActiveRecord::RecordNotFound' do
        expect{get :edit, id: @comment, post_id: @other_post}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end