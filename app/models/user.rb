class User < ApplicationRecord
    before_validation { email.downcase! }
    has_secure_password

    validates :name, presence: { message: "名前を入力してください" }
    validates :email, presence: { message: "メールアドレスを入力してください" }
    validates :email, uniqueness: { message: "メールアドレスはすでに使われています" }
    validates :password_digest, presence: { message: "パスワードを入力してください" }
    validates :password, length: { minimum: 6, message: "パスワードは6文字以上で入力してください" }
    validates :password_confirmation, presence: true

  end