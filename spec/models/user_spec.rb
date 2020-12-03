require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it "nickname, email, password, password_confirmation, family_name,
          first_name, family_name_reading, first_name_reading, birthday
          が全て存在すれば登録できる" do
        expect(@user).to be_valid
      end
      it "passwordが半角英数字混合であれば登録できる" do
        @user.password = "a123456789"
        @user.password_confirmation = "a123456789"
        expect(@user).to be_valid
      end
      it "passwordが6文字以上であれば登録できる" do
        @user.password = "09876b"
        @user.password_confirmation = "09876b"
        expect(@user).to be_valid
      end
      it "family_nameとfirst_nameが全角（漢字・ひらがな・カタカナ）であれば登録できる" do
        @user.family_name = "田むラ"
        @user.first_name = "一ふミ"
        expect(@user).to be_valid
      end
      it "family_name_readingとfirst_name_readingが全角カタカナであれば登録できる" do
        @user.family_name_reading = "タムラ"
        @user.first_name_reading = "ヒフミ"
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it "nicknameが空だと登録できない" do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it "emailが空では登録できない" do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "重複したemailが存在する場合登録できない" do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it "emailに@が含まれていないと登録できない" do
        @user.email = "test.example"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it "passwordが空では登録できない" do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it "passwordが5文字以下であれば登録できない" do
        @user.password = "a1234"
        @user.password_confirmation = "a1234"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it "passwordが数字だけでは登録できない" do
        @user.password = "111111"
        @user.password_confirmation = "111111"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password include both letters and numbers")
      end
      it "passwordが英語だけでは登録できない" do
        @user.password = "aaaaaa"
        @user.password_confirmation = "aaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password include both letters and numbers")
      end
      it "passwordが全角英数字混合では登録できない" do
        @user.password = "ａａａ１１１"
        @user.password_confirmation = "ａａａ１１１"
        binding.pry
        @user.valid?
        expect(@user.errors.full_messages).to include("Password include both letters and numbers")
      end
      it "passwordが存在してもpassword_confirmationが空では登録できない" do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "passwordとpassword_confirmationが一致していないときは登録できない" do
        @user.password_confirmation = "bbb111"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "family_nameが空だと登録できない" do
        @user.family_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank", 
                                                      "Family name is invalid. Input full-width characters.")
      end
      it "family_nameが半角カタカナだと登録できない" do
        @user.family_name = "ｽｽﾞｷ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name is invalid. Input full-width characters.")
      end
      it "family_nameが英数字だと登録できない" do
        @user.family_name = "SUZUKI"
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name is invalid. Input full-width characters.")
      end
      it "first_nameが空だと登録できない" do
        @user.first_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank", 
                                                      "First name is invalid. Input full-width characters.")
      end
      it "first_nameが半角カタカナだと登録できない" do
        @user.first_name = "ﾊﾅｺ"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid. Input full-width characters.")
      end
      it "first_nameが英数字だと登録できない" do
        @user.first_name = "HANAKO"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid. Input full-width characters.")
      end
      it "family_name_readingが空だと登録できない" do
        @user.family_name_reading = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name reading can't be blank",
                                                      "Family name reading is invalid. Input full-width katakana characters.")
      end
      it "family_name_readingが全角ひらがなだと登録できない" do
        @user.family_name_reading = "すずき"
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name reading is invalid. Input full-width katakana characters.")
      end
      it "family_name_readingが半角カタカナだと登録できない" do
        @user.family_name_reading = "ｽｽﾞｷ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name reading is invalid. Input full-width katakana characters.")
      end
      it "first_name_readingが空だと登録できない" do
        @user.first_name_reading = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("First name reading can't be blank",
                                                      "First name reading is invalid. Input full-width katakana characters.")
      end
      it "first_name_readingが全角ひらがなだと登録できない" do
        @user.first_name_reading = "はなこ"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name reading is invalid. Input full-width katakana characters.")
      end
      it "first_name_readingが半角カタカナだと登録できない" do
        @user.first_name_reading = "ﾊﾅｺ"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name reading is invalid. Input full-width katakana characters.")
      end
      it "birthdayが空だと登録できない" do
        @user.birthday = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
