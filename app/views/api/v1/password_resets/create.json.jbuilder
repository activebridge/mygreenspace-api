if @user
  json.status :ok
  json.message 'Email sent with password reset instructions'
else
  json.status :error
  json.message 'Email address not found'
end
