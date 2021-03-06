require 'spec_helper'

feature 'Post and comments' do
  scenario 'post and comments' do
    # 親記事の投稿
    visit root_path
    click_link 'New Post'
    fill_in 'Text', with: 'こんにちは、伊藤です。'
    click_button 'Create Post'
    expect(page).to have_content 'こんにちは、伊藤です。'
    expect(page).to have_content 'コメントがありません。'

    # コメントの投稿(一人目)
    fill_in 'Text', with: '山田です。こんにちは！'
    click_button 'Create Comment'
    expect(page).to have_content 'こんにちは、伊藤です。'
    expect(page).to have_content '山田です。こんにちは！'

    # コメントの投稿(二人目)
    fill_in 'Text', with: '鈴木です。こんにちは！'
    click_button 'Create Comment'
    expect(page).to have_content 'こんにちは、伊藤です。'
    expect(page).to have_content '山田です。こんにちは！'
    expect(page).to have_content '鈴木です。こんにちは！'

    # 新しい親記事の投稿
    click_link 'Back'
    click_link 'New Post'

    ## わざと空テキストを送信
    click_button 'Create Post'
    expect(page).to have_content "Text can't be blank"

    fill_in 'Text', with: 'こんばんは、伊藤です。'
    click_button 'Create Post'
    expect(page).to have_content 'こんばんは、伊藤です。'
    expect(page).to have_content 'コメントがありません。'

    # 新しい親記事へのコメント
    ## わざと空テキストを送信
    click_button 'Create Comment'
    expect(page).to have_content "Text can't be blank"
    expect(page).to have_content 'コメントがありません。'

    fill_in 'Text', with: '山田です。こんばんは！'
    click_button 'Create Comment'
    expect(page).to have_content 'こんばんは、伊藤です。'
    expect(page).to have_content '山田です。こんばんは！'

    # コメントの削除
    click_link '[Destroy]'
    expect(page).to have_content 'コメントがありません。'
  end

  scenario 'update post' do
    visit root_path
    click_link 'New Post'
    fill_in 'Text', with: 'こんにちは、伊藤です。'
    click_button 'Create Post'
    expect(page).to have_content 'こんにちは、伊藤です。'

    click_link 'Back'
    click_link 'Edit'
    fill_in 'Text', with: 'こんにちは、伊藤です！！'
    click_button 'Update Post'
    expect(page).to have_content 'こんにちは、伊藤です！！'
  end

  scenario 'delete post' do
    visit root_path
    click_link 'New Post'
    fill_in 'Text', with: 'こんにちは、伊藤です。'
    click_button 'Create Post'
    expect(page).to have_content 'こんにちは、伊藤です。'

    click_link 'Back'
    click_link 'Destroy'
    expect(page).to_not have_content 'こんにちは、伊藤です！！'
  end
end