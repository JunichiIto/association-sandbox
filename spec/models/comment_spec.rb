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
      context 'use build' do
        before :each do
          @comment = @post.comments.build(text: '山田です。伊藤さん、こんにちは！')
        end
        it 'has post' do
          expect(@comment.post).to eq @post
        end
        it 'has post_id' do
          expect(@comment.post_id).to eq @post.id
        end
        it 'is not persisted' do
          expect(@comment).to_not be_persisted
        end
        specify 'post has a comment' do
          expect(@post.comments).to eq [@comment]
        end
      end
      context 'use create' do
        before :each do
          @comment = @post.comments.create(text: '山田です。伊藤さん、こんにちは！')
        end
        it 'has post' do
          expect(@comment.post).to eq @post
        end
        it 'has post_id' do
          expect(@comment.post_id).to eq @post.id
        end
        it 'is persisted' do
          expect(@comment).to be_persisted
        end
        specify 'post has a comment' do
          expect(@post.comments).to eq [@comment]
        end
      end
      context 'use @post.comments << @comment' do
        before :each do
          @comment = Comment.new(text: '山田です。伊藤さん、こんにちは！')
          @post.comments << @comment
        end
        it 'has post' do
          expect(@comment.post).to eq @post
        end
        it 'has post_id' do
          expect(@comment.post_id).to eq @post.id
        end
        it 'is persisted' do
          expect(@comment).to be_persisted
        end
        specify 'post has a comment' do
          expect(@post.comments).to eq [@comment]
        end
      end
      context 'use comment.post = @post' do
        before :each do
          @comment = Comment.new(text: '山田です。伊藤さん、こんにちは！')
          @comment.post = @post
        end
        it 'has post' do
          expect(@comment.post).to eq @post
        end
        it 'has post_id' do
          expect(@comment.post_id).to eq @post.id
        end
        context 'not saved' do
          specify 'post does not have comments' do
            expect(@post.comments).to be_empty
          end
        end
        context 'saved' do
          before :each do
            @comment.save
          end
          specify 'post has a comment' do
            expect(@post.comments).to eq [@comment]
          end
        end
      end
    end # end of context associated
  end # end of describe association
  describe 'validation' do
    describe 'text' do
      context 'with text' do
        it 'is valid' do
          expect(Comment.new(text: 'Hello')).to be_valid
        end
      end
      context 'without text' do
        it 'is invalid' do
          expect(Comment.new(text: nil)).to have(1).error_on(:text)
        end
      end
    end
  end
end
