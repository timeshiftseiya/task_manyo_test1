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
    let!(:task) { FactoryBot.create(:task, title: 'first_task', created_at: '2023-02-18', priority: '中', status: '未着手', deadline_on: '2025-02-18') }
    let!(:second_task) { FactoryBot.create(:second_task, title: 'second_task', created_at: '2023-02-17', priority: '高', status: '着手中', deadline_on: '2025-02-17') }
    let!(:third_task) { FactoryBot.create(:third_task, title: 'third_task', created_at: '2023-02-16', priority: '低', status: '完了', deadline_on: '2025-02-16') }
    
    before do
    visit tasks_path
    end

    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が作成日時の降順で表示される' do
        # タスク一覧ページからすべてのタスクの作成日時を取得
        task_dates = page.all('.task-created-at').map(&:text)
        
        # タスクの作成日時が降順に並んでいることを確認
        expect(task_dates).to eq(['2025/02/18 00:00', '2025/02/17 00:00', '2025/02/16 00:00'].sort.reverse)
      end
    end
    
    context '新たにタスクを作成した場合' do
      it '新しいタスクが一番上に表示される' do
        # タスクを新規作成
        @task = FactoryBot.create(:task)

        # 一覧画面に戻って新しいタスクが一番上に表示されているか確認
        visit tasks_path
        expect(page).to have_content('登録表示のテスト内容')
        expect(page).to have_selector('tbody tr:first-child', text: '登録表示のテスト内容')
      end
    end

    describe 'ソート機能' do
      before do
        visit tasks_path
      end
      
      context '「終了期限」というリンクをクリックした場合' do
        it "終了期限昇順に並び替えられたタスク一覧が表示される" do
          # ソートリンクをクリックするアクションをシミュレートする
          click_on I18n.t("activerecord.attributes.task.deadline_on")
    
          # ページ内のタスクが終了期限昇順に表示されていることを確認
          task_titles = all('tbody tr td:first-child').map(&:text)
          expect(task_titles[0]).to eq('third_task')
          expect(task_titles[1]).to eq('second_task')
          expect(task_titles[2]).to eq('first_task')
        end
      end

      context '「優先度」というリンクをクリックした場合' do
        it "優先度の高い順に並び替えられたタスク一覧が表示される" do
          click_on I18n.t("activerecord.attributes.task.priority")

          # ページ内のタスクが優先度の高い順に表示されていることを確認
          task_titles = all('tbody tr td:first-child').map(&:text)
          expect(task_titles[0]).to eq('third_task')
          expect(task_titles[1]).to eq('first_task')
          expect(task_titles[2]).to eq('second_task')
        end
      end
    end
    
    describe '検索機能' do
      context 'タイトルであいまい検索をした場合' do
        it "検索ワードを含むタスクのみ表示される" do
          # 1. タイトルであいまい検索をシミュレートする
          fill_in 'search[title]', with: 'second'
          click_button I18n.t("search")
          
          # 2. 検索結果に指定のタスクが含まれていることを確認
          expect(page).to have_title('second_task')
          
          # 3. 検索結果に含まれていないタスクが表示されていないことを確認
          expect(page).not_to have_title('first_task')
          expect(page).not_to have_title('third_task')
        end
      end

      context 'ステータスで検索した場合' do
        it "検索したステータスに一致するタスクのみ表示される" do
          # 1. ステータスで検索をシミュレートする
          select '着手中', from: 'search[status]'
          click_button I18n.t("search")
          
          # 2. 検索結果に指定のステータスに一致するタスクが含まれていることを確認
          expect(page).to have_title('second_task')
          
          # 3. 検索結果に含まれていないステータスのタスクが表示されていないことを確認
          expect(page).not_to have_title('first_task')
          expect(page).not_to have_title('third_task')
        end
      end

      context 'タイトルとステータスで検索した場合' do
        it "検索ワードをタイトルに含み、かつステータスに一致するタスクのみ表示される" do
          # 1. タイトルとステータスで検索をシミュレートする
          fill_in 'search[title]', with: 'task'
          select '0', from: 'search_task[status]'
          click_button t("search")
          
          # 2. 検索結果に指定の条件に一致するタスクが含まれていることを確認
          expect(page).to have_title('first_task')
          
          # 3. 検索結果に含まれていないタスクが表示されていないことを確認
          expect(page).not_to have_title('second_task')
          expect(page).not_to have_title('third_task')
        end
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