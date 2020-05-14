require 'rails_helper'
describe User do
  describe '#create' do
    it "nickname,email,password,password_confirmationが存在する場合は登録できる" do
      user = build(:user)
      user.valid?
      expect(user).to be_valid
    end
    it "nicknameが存在しない場合は登録できない" do
      user = build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end
    it "emailが存在しない場合は登録できない" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end
    it "passwordが存在しない場合は登録できない" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end
    it "passwordが存在してもpassword_confirmationが存在しない場合は登録できない" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end
    it "nicknameが１３文字以上の場合は登録できない" do
      user = build(:user, nickname: "1234567891000")
      user.valid?
      expect(user.errors[:nickname]).to include("は12文字以内で入力してください")
    end
    it "nicknameが１２文字以下の場合は登録できる" do
      user = build(:user, nickname: "123456789100")
      user.valid?
      expect(user).to be_valid
    end
    it "emailが重複した場合は登録できない" do
      user = create(:user, email: "aaa@aaa.com")
      another_user = build(:user, email: "aaa@aaa.com")
      another_user.valid?
      expect(another_user.errors[:email]).to include("はすでに存在します")
    end
    it "passwordが６文字以上の場合は登録できる" do
      user = build(:user, password: "000000",password_confirmation: "000000")
      user.valid?
      expect(user).to be_valid
    end
    it "passwordが５文字以下の場合は登録できない" do
      user = build(:user, password: "00000",password_confirmation: "00000")
      user.valid?
      expect(user.errors[:password]).to include("は6文字以上で入力してください")
    end
  end
end