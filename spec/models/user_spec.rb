require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  context "ユーザ登録ができる場合" do
    it "必須項目が入っているとユーザが登録できる" do
      expect(@user).to be_valid
    end
  end

  context "ユーザ登録ができない場合" do
    it "nicknameが空だとユーザ登録ができない" do
      @user.nickname = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end
    it "emailが空だとユーザ登録ができない" do
      @user.email = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it "Emailに「@」がない場合登録できない" do
      @user.email = "test.test"
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
    end
    it "既に登録されたEmailを入力すると登録できない" do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Email has already been taken")
    end
    it "passwordが空だとユーザ登録ができない" do
      @user.password = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it "passwordが5文字以下の場合ユーザ登録ができない" do
      @user.password = "123ab"
      @user.password_confirmation = "123ab"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
    it "passwordが半角英語のみだとユーザ登録できない" do
      @user.password = "abcdef"
      @user.password_confirmation = "abcdef"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password Include both letters and numbers")
    end
    it "passwordが半角数字のみだとユーザ登録できない" do
      @user.password = "123456"
      @user.password_confirmation = "123456"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password Include both letters and numbers")
    end
    it "確認用passwordが入力されていないとユーザ登録ができない" do
      @user.password = "123456ab"
      @user.password_confirmation = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it "確認用passwordがpassword不一致だとユーザ登録ができない" do
      @user.password_confirmation = "123456"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it "生年月日が空だとユーザ登録ができない" do
      @user.birth_date = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Birth date can't be blank")
    end
    it "名字が空だとユーザ登録ができない" do
      @user.last_name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank", "Last name Full-width characters")
    end
    it "名字が半角だとユーザ登録できない" do
      @user.last_name = "test"
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name Full-width characters")
    end
    it "名前が空だとユーザ登録ができない" do
      @user.first_name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank", "First name Full-width characters")
    end
    it "名前が半角だとユーザ登録できない" do
      @user.first_name = "test"
      @user.valid?
      expect(@user.errors.full_messages).to include("First name Full-width characters")
    end
    it "名字（読み）が空だとユーザ登録ができない" do
      @user.last_reading_name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Last reading name can't be blank", "Last reading name Full-width katakana characters")
    end
    it "名字（読み）がカタカナ以外だとユーザ登録ができない" do
      @user.last_reading_name = "漢字"
      @user.valid?
      expect(@user.errors.full_messages).to include("Last reading name Full-width katakana characters")
    end
    it "名前（読み）が空だとユーザ登録ができない" do
      @user.first_reading_name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("First reading name can't be blank", "First reading name Full-width katakana characters")
    end
    it "名前（読み）がカタカナ以外だとユーザ登録ができない" do
      @user.first_reading_name = "漢字"
      @user.valid?
      expect(@user.errors.full_messages).to include("First reading name Full-width katakana characters")
    end
  end
end
