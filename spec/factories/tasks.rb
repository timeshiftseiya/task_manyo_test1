# 「FactoryBotを使用します」という記述
FactoryBot.define do
  
    # 作成するテストデータの名前を「task」とします
    # 「task」のように存在するクラス名のスネークケースをテストデータ名とする場合、そのクラスのテストデータが作成されます  
    factory :task do
      title { '登録表示テスト' }
      content { '登録表示のテスト内容' }
    end

    # 作成するテストデータの名前を「second_task」とします
    # 「second_task」のように存在しないクラス名のスネークケースをテストデータ名とする場合、`class`オプションを使ってどのクラスのテストデータを作成するかを明示する必要があります
    factory :second_task, class: Task do
      title { '書類作成' }
      content { '企画書を作成する。' }
    end

    factory :third_task, class: Task do
      title { '詳細テスト' }
      content { '詳細表示のテスト内容' }
    end
    
  end