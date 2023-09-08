start_date = Time.now # 現在の日時を取得
50.times do |i|
  Task.create!(
    title: "Title#{i+1}",
    content: "Content#{i+1}",
    created_at: start_date + i.days # 日数を加算して新しい日付を設定
  )
end