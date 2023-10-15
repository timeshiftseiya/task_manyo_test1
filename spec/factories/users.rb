# ユーザーファクトリー（通常のユーザー）
FactoryBot.define do
  factory :user do
    name { "UserTest" }
    email { "usertest@example.com" }
    password { "UserTest" }
    password_confirmation { "UserTest" }
    admin { false }
  end
end

# ユーザーファクトリー（管理者ユーザー）
FactoryBot.define do
  factory :admin_user, class: 'User' do
    name { "AdminUserTest" }
    email { "adminusertest@example.com" }
    password { "AdminUserTest" }
    password_confirmation { "AdminUserTest" }
    admin { true }
  end
end