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
    click_link 'New Comment'
    fill_in 'Text', with: '山田です。こんにちは！'
    click_button 'Create Comment'
    expect(page).to have_content 'こんにちは、伊藤です。'
    expect(page).to have_content '山田です。こんにちは！'

    # コメントの投稿(二人目)
    click_link 'New Comment'
    fill_in 'Text', with: '鈴木です。こんにちは！'
    click_button 'Create Comment'
    expect(page).to have_content 'こんにちは、伊藤です。'
    expect(page).to have_content '山田です。こんにちは！'
    expect(page).to have_content '鈴木です。こんにちは！'

    # 新しい親記事の投稿
    visit root_path
    click_link 'New Post'
    fill_in 'Text', with: 'こんばんは、伊藤です。'
    click_button 'Create Post'
    expect(page).to have_content 'こんばんは、伊藤です。'
    expect(page).to have_content 'コメントがありません。'

    # 新しい親記事へのコメント
    click_link 'New Comment'
    fill_in 'Text', with: '山田です。こんばんは！'
    click_button 'Create Comment'
    expect(page).to have_content 'こんばんは、伊藤です。'
    expect(page).to have_content '山田です。こんばんは！'

    # コメントの編集
    click_link '山田です。こんばんは！'
    fill_in 'Text', with: '山田です。こんばんは！！！'
    click_button 'Update Comment'
    expect(page).to have_content '山田です。こんばんは！！！'

    # コメントの削除
    click_link '山田です。こんばんは！！！'
    click_link 'Destroy'
    expect(page).to_not have_content '山田です。こんばんは！！！'
  end
end