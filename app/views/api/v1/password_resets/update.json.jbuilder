if @user && @user.valid?
  json.status :ok
  json.message 'Password has been reset'
elsif @user
  json.status :error
  json.message @user.errors.full_messages
else
  json.status :error
  json.message 'Invalid reset password link'
end
