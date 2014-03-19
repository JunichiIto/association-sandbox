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
end