require 'spec_helper'

describe Comment do
  describe 'association' do
    let!(:post) { Post.create(text: "新しいMacBook Proを買いました！") }
    context "not associated" do
      specify do
        Comment.new(text: "わー、いいなあ！")
        expect(post.comments).to be_empty
      end
    end
    describe "parent.children.create" do
      specify do
        comment = post.comments.create(text: "わー、いいなあ！")

        expect(post.comments).to eq [comment]
        expect(comment).to be_persisted
      end
    end
    describe "parent.children.build" do
      specify do
        comment = post.comments.build(text: "わー、いいなあ！")

        expect(post.comments).to eq [comment]
        expect(comment).to_not be_persisted
      end
    end
    describe "parent.children << child" do
      specify do
        comment = Comment.new(text: "わー、いいなあ！")
        expect(comment).to_not be_persisted

        post.comments << comment

        expect(post.comments).to eq [comment]
        expect(comment).to be_persisted
      end
    end
    describe "parent.children = children" do
      specify do
        comment_old = Comment.new(text: "やった、コメント1番乗り！！")
        post.comments << comment_old

        expect(post.comments).to eq [comment_old]
        expect(comment_old).to be_persisted

        comment_1 = Comment.new(text: "わー、いいなあ！")
        comment_2 = Comment.new(text: "うらやましすぎる！！")

        post.comments = [comment_1, comment_2]

        expect(post.comments).to eq [comment_1, comment_2]
        expect(comment_1).to be_persisted
        expect(comment_2).to be_persisted
        expect(comment_old).to be_destroyed
      end
    end
    describe "child.parent = parent" do
      specify do
        comment = Comment.new(text: "わー、いいなあ！")
        comment.post = post
        comment.save

        expect(post.comments).to eq [comment]
      end
    end
    describe "Child.new(parent: parent) / Child.create(parent: parent)" do
      specify do
        comment_1 = Comment.new(text: "わー、いいなあ！", post: post)
        comment_1.save

        comment_2 = Comment.create(text: "うらやましすぎる！！", post: post)

        expect(post.comments).to eq [comment_1, comment_2]
      end
    end
  end
  describe 'validation' do
    before :each do
      @post = Post.create(text: 'Hi.')
      @comment = Comment.new(text: 'Hello', post: @post)
    end
    context 'with text and post' do
      it 'is valid' do
        expect(@comment).to be_valid
      end
    end
    context 'without text' do
      it 'is invalid' do
        @comment.text = nil
        expect(@comment).to have(1).error_on(:text)
      end
    end
    context 'without post' do
      it 'is invalid' do
        @comment.post = nil
        expect(@comment).to have(1).error_on(:post)
      end
    end
  end
end
