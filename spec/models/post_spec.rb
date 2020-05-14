require 'rails_helper'
describe Post do
  describe '#create' do
    it "titleが２０文字以下の場合は投稿できる" do
      user = create(:user)
      post = build(:post, title: "aaaaaaaaaaaaaaaaaaaa", user_id: user.id)
      post.valid?
      expect(post).to be_valid
    end
    it "titleが２1文字以上の場合は投稿できない" do
      user = create(:user)
      post = build(:post, title: "aaaaaaaaaaaaaaaaaaaaa", user_id: user.id)
      post.valid?
      expect(post.errors[:title]).to include("入力は20文字までです。")
    end
    it "textが500文字以下の場合は投稿できる" do
      user = create(:user)
      post = build(:post, user_id: user.id)
      post.valid?
      expect(post).to be_valid
    end
    it "textが500文字以上の場合は投稿できない" do
      user = create(:user)
      post = build(:post, text: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", user_id: user.id)
      post.valid?
      expect(post.errors[:text]).to include("入力は500文字までです。")
    end
  end
end