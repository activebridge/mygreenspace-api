class Api::V1::PasswordResetsController < ApiController

  def create
    @user = User.find_by_email(params[:email])
    ResetPasswordService.new(@user).perform! if @user
  end

  def update
    @user = User.find_by_reset_digest(params[:id])
    if @user && @user.update_attributes(user_params)
      @user.update_attribute :reset_digest, nil
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

end
