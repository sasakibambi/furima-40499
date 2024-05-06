require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザー新規登録' do
    it 'nicknameが空では登録できない' do
      # user = FactoryBot.build(:user)  # Userのインスタンス生成
      # user.nickname = ''  # nicknameの値を空にする
      # user.valid?
      # expect(user.errors.full_messages).to include "Nickname can't be blank"
      # expect以下にinclude以下が入っているかの確認
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Nickname can't be blank"
      # valid?〜errors.full_messages　エラーの内容を取得することができる
      # 保存がバリデーションにかからなければtrue
      #falseだった場合は@userに自動的にエラー文が付与される
    end
    it 'emailが空では登録できない' do
      # user = FactoryBot.build(:user)  # Userのインスタンス生成
      # user.email = ''  # emailの値を空にする
      # user.valid?
      # expect(user.errors.full_messages).to include "Email can't be blank"
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Email can't be blank"
    end
    it '重複したemailが存在する場合は登録できない' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end
    it 'emailは@を含まないと登録できない' do
      @user.email = 'email'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end
    it 'passwordが空では登録できない(パスワードが必須であること)' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Password can't be blank"
    end
    it 'passwordが5文字以下では登録できない' do
      @user.password = '00000'
      @user.password_confirmation = '00000'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end
    it 'passwordが半角英数字混合での入力が必須であること（数字のみ）' do
      # ダメなデータを入れて→バリデーションを通す→エラー文が出る
      # 数字のみ、全角のみ、英語のみ
      @user.password = '000000'
      @user.password_confirmation = '000000'
      @user.valid?
      expect(@user.errors.full_messages).to include "Password is invalid"
    end  
    it 'passwordが半角英数字混合での入力が必須であること（全角のみ）' do
      @user.password = 'ＡＢＣ１２３'
      @user.password_confirmation = 'ＡＢＣ１２３'
      @user.valid?
      expect(@user.errors.full_messages).to include "Password is invalid"
    end  
    it 'passwordが半角英数字混合での入力が必須であること（英語のみ）' do
      @user.password = 'aaaaaa'
      @user.password_confirmation = 'aaaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include "Password is invalid"
    end  
    it 'パスワードとパスワード（確認）は、値の一致が必須であること。' do
    end
    it 'お名前(全角)は、名字が必須であること。' do 
      @user.family_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Family name can't be blank"
    end 
    it 'お名前(全角)は、名前が必須であること。' do 
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "First name can't be blank"
    end 
    it 'お名前(全角)（苗字）は、全角（漢字・ひらがな・カタカナ）での入力が必須であること。（全角数字のみ）' do 
      # ダメなデータを入れて→バリデーションを通す→エラー文が出る
      # 数字のみ、半角のみ、英語のみ
      @user.family_name = '００００００'
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name is invalid")
    end  
    it 'お名前(全角)（苗字）は、全角（漢字・ひらがな・カタカナ）での入力が必須であること。（半角のみ）' do 
      # ダメなデータを入れて→バリデーションを通す→エラー文が出る
      # 数字のみ、半角のみ、英語のみ
      @user.family_name = 'ｱｲｳｴｵ'
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name is invalid")
    end  
    it 'お名前(全角)（苗字）は、全角（漢字・ひらがな・カタカナ）での入力が必須であること。（全角英語のみ）' do 
      # ダメなデータを入れて→バリデーションを通す→エラー文が出る
      # 数字のみ、半角のみ、英語のみ
      @user.family_name = 'ＡＡＡＡＡＡ'
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name is invalid")
    end  
    it 'お名前(全角)（名前）は、全角（漢字・ひらがな・カタカナ）での入力が必須であること。（全角数字のみ）' do 
      # ダメなデータを入れて→バリデーションを通す→エラー文が出る
      # 数字のみ、半角のみ、英語のみ
      @user.first_name = '００００００'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name is invalid")
    end  
    it 'お名前(全角)（名前）は、全角（漢字・ひらがな・カタカナ）での入力が必須であること。（半角のみ）' do 
      # ダメなデータを入れて→バリデーションを通す→エラー文が出る
      # 数字のみ、半角のみ、英語のみ
      @user.first_name = 'ｱｲｳｴｵ'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name is invalid")
    end  
    it 'お名前(全角)（名前）は、全角（漢字・ひらがな・カタカナ）での入力が必須であること。（全角英語のみ）' do 
      # ダメなデータを入れて→バリデーションを通す→エラー文が出る
      # 数字のみ、半角のみ、英語のみ
      @user.first_name = 'ＡＡＡＡＡＡ'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name is invalid")
    end  
    it 'お名前カナ(全角)は、名字が必須であること。' do 
      @user.family_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Family name kana can't be blank"
    end  
    it 'お名前カナ(全角)は、名前が必須であること。' do 
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "First name kana can't be blank"
    end  
    it '苗字（カナ）(全角)は、全角（カタカナ）での入力が必須であること。' do 
       # ダメなデータを入れて→バリデーションを通す→エラー文が出る
      # 半角カタカナ
      @user.family_name_kana = 'ｱｲｳｴｵ'
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name kana is invalid")
    end  
    it '名前（カナ）(全角)(名前)は、全角（カタカナ）での入力が必須であること。' do 
      # ダメなデータを入れて→バリデーションを通す→エラー文が出る
     # 半角カタカナ
     @user.first_name_kana = 'ｱｲｳｴｵ'
     @user.valid?
     expect(@user.errors.full_messages).to include("First name kana is invalid")
   end  
    it '生年月日が必須であること。' do 
      @user.date_of_birth  = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Date of birth can't be blank"
    end   
  end
end