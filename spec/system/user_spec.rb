require 'rails_helper'

RSpec.describe 'ユーザ管理機能', type: :system do
  describe '登録機能' do
    context 'ユーザを登録した場合' do
      before do
        @user = FactoryBot.create(:user)
        visit new_session_path
        fill_in 'session_email', with: @user.email
        fill_in 'session_password', with: @user.password
        click_button 'create-session'
      end
      it 'タスク一覧画面に遷移する' do
          visit tasks_path
          expect(page).to have_content('タスク一覧ページ')
      end
    end

    context 'ログインせずにタスク一覧画面に遷移した場合' do
      before do
        visit tasks_path
      end
      it 'ログイン画面に遷移し、「ログインしてください」というメッセージが表示される' do
          visit new_session_path
          expect(page).to have_content 'ログインしてください'
      end
    end
  end

  describe 'ログイン機能' do
    context '登録済みのユーザでログインした場合' do
      before do
        @user = FactoryBot.create(:user)
        visit new_session_path
        fill_in 'session_email', with: @user.email
        fill_in 'session_password', with: @user.password
        click_button 'create-session'
      end
      it 'タスク一覧画面に遷移し、「ログインしました」というメッセージが表示される' do
          visit tasks_path
          expect(page).to have_content 'ログインしました'
      end
      it '自分の詳細画面にアクセスできる' do
          visit user_path(@user)
          expect(page).to have_content(@user.name)
      end
      it '他人の詳細画面にアクセスすると、タスク一覧画面に遷移する' do
          @another_user = FactoryBot.create(:user, email: 'another@example.com')
          visit user_path(@another_user)
          expect(page).to have_content 'タスク一覧'
      end
      it 'ログアウトするとログイン画面に遷移し、「ログアウトしました」というメッセージが表示される' do
          click_link 'sign-out'
          expect(page).to have_content 'ログアウトしました'
      end
    end
  end

  describe '管理者機能' do
    context '管理者がログインした場合' do
      before do
        @admin_user = FactoryBot.create(:admin_user)
        visit new_session_path
        fill_in 'session_email', with: @admin_user.email
        fill_in 'session_password', with: @admin_user.password
        click_button 'create-session'
      end
      it 'ユーザ一覧画面にアクセスできる' do
        visit admin_users_path
        expect(page).to have_content 'ユーザ一覧ページ'
      end
      it '管理者を登録できる' do
      end
      it 'ユーザ詳細画面にアクセスできる' do
      end
      it 'ユーザ編集画面から、自分以外のユーザを編集できる' do
      end
      it 'ユーザを削除できる' do
      end
    end

    context '一般ユーザがユーザ一覧画面にアクセスした場合' do
      it 'タスク一覧画面に遷移し、「管理者以外アクセスできません」というエラーメッセージが表示される' do
      end
    end
  end
end