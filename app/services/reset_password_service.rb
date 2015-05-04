class ResetPasswordService
  attr_accessor :user

  def initialize(user)
    @user = user
  end

  def perform!
    token = Digest::MD5.hexdigest([user.id, user.created_at].join)[0..16]
    user.update_attribute :reset_digest, token

    UserMailer.reset_password(user)
  end
end
