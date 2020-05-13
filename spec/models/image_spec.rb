require 'rails_helper'
describe Image do
  describe 'posts#create' do
    it "imageが存在する場合は投稿できる" do
      user = create(:user)
      post = create(:post, user_id: user.id)
      comment = create(:comment, text: "aaa", user_id: user.id, post_id: post.id)
      image = build(:image, comment_id: comment.id, post_id: post.id)
      image.valid?
      expect(image).to be_valid
    end
    it "imageが存在しない場合は投稿できない" do
      user = create(:user)
      post = create(:post, user_id: user.id)
      comment = create(:comment, text: "aaa", user_id: user.id, post_id: post.id)
      image = build(:image, image: "", comment_id: comment.id, post_id: post.id)
      image.valid?
      expect(image.errors[:image]).to include("を入力してください")
    end
  end
end