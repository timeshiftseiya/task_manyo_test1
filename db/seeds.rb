start_date = Time.now # 現在の日時を取得

10.times do |i|
  Task.create!(
    title: "Title#{i+1}",
    content: "Content#{i+1}",
    created_at: start_date + (i+1).days,
    deadline_on: start_date + (i + 10).days, # 現在の日時から3日後から順に日数を加算
    priority: ["低", "中", "高"].sample, # ランダムに優先度を選択
    status: ["未着手", "着手中", "完了"].sample # ランダムにステータスを選択
  )
end
 