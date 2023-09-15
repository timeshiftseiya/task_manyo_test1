require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  describe '登録機能' do
    context 'タスクを登録した場合' do
      it '登録したタスクが表示される' do
        @task = FactoryBot.create(:task)
        visit task_path(@task)
        expect(page).to have_content '登録表示テスト'
        expect(page).to have_content '登録表示のテスト内容'
      end
    end
  end

  describe '一覧表示機能' do
    let!(:first_task) { FactoryBot.create(:second_task, title: 'first_task', created_at: '2022-02-18') }
    let!(:second_task) { FactoryBot.create(:second_task, title: 'second_task', created_at: '2022-02-17') }
    let!(:third_task) { FactoryBot.create(:second_task, title: 'third_task', created_at: '2022-02-16') }
    
    before do
    visit tasks_path
    end

    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が作成日時の降順で表示される' do
        # タスク一覧ページからすべてのタスクの作成日時を取得
        task_dates = page.all('.task-created-at').map(&:text)
        
        # タスクの作成日時が降順に並んでいることを確認
        expect(task_dates).to eq(['2022/02/18 00:00', '2022/02/17 00:00', '2022/02/16 00:00'].sort.reverse)
      end
    end

    
    context '新たにタスクを作成した場合' do
      it '新しいタスクが一番上に表示される' do
        # タスクを新規作成
        new_task_title = 'New Task Title'
        visit new_task_path
        fill_in 'task[title]', with: new_task_title
        fill_in 'task[content]', with: new_task_title
        click_button 'create-task'

        # 一覧画面に戻って新しいタスクが一番上に表示されているか確認
        visit tasks_path
        expect(page).to have_content(new_task_title)
        expect(page).to have_selector('tbody tr:first-child', text: new_task_title)
      end
    end
  end

    describe '任意のタスク詳細画面に遷移した場合' do
      before(:each) do
        @task = FactoryBot.create(:third_task)
      end
  
      it 'そのタスクの内容が表示される' do
        visit task_path(@task)
        expect(page).to have_content '詳細テスト'
        expect(page).to have_content '詳細表示のテスト内容'
      end
    end
  end  