FactoryBot.define do
  factory :user do
    id {1}
    name { "MyString" }
    email { "MyString" }
    password { "MyString" }
    password_confirmation { "MyString" }
    admin {true}
    created_at {'2023-02-18'}
    updated_at {'2023-03-18'}
  end
end
