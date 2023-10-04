class User < ApplicationRecord
  before_validation { email.downcase! }
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 6, message: "は6文字以上で入力してください" }
  validates :password_confirmation, presence: true
  validate :password_confirmation_matches

  has_many :tasks, dependent: :destroy

  def destroy_with_tasks
    self.destroy
  end

  private

  def password_confirmation_matches
    if password.present? && password_confirmation.present? && password != password_confirmation
      errors.add(:password_confirmation, "とパスワードの入力が一致しません")
    end
  end
end