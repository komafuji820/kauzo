require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe "ユーザー新規登録" do
    context "新規登録できるとき" do
      it "nickname, email, passwordを正しく入力すれば登録できる" do
        expect(@user).to be_valid
      end
    end

    context "新規登録できないとき" do
      it do
      end
    end

  end


end
