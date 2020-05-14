require 'rails_helper'
describe Comment do
  describe '#create' do
    it "コメントが存在した場合投稿できる" do
      user = create(:user)
      post = create(:post, user_id: user.id)
      comment = build(:comment, text: "aaa", user_id: user.id, post_id: post.id)
      comment.valid?
      expect(comment).to be_valid
    end
    it "コメントが存在しない場合投稿できない" do
      user = create(:user)
      post = create(:post, user_id: user.id)
      comment = build(:comment, text: "", user_id: user.id, post_id: post.id)
      comment.valid?
      expect(comment.errors[:text]).to include("を入力してください")
    end
    it "コメントが５００文字以内の場合は投稿できる" do
      user = create(:user)
      post = create(:post, user_id: user.id)
      comment = build(:comment, text: "aaa", user_id: user.id, post_id: post.id)
      comment.valid?
      expect(comment).to be_valid
    end
    it "コメントが501文字以上の場合は投稿できない" do
      user = create(:user)
      post = create(:post, user_id: user.id)
      comment = build(:comment, user_id: user.id, post_id: post.id)
      comment.valid?
      expect(comment.errors[:text]).to include("入力は500文字までです。")
    end
  end
end