require 'spec_helper'

describe Post do
  it "has comments" do
    expect(Post.new.comments.count).to eq 0
  end
end
