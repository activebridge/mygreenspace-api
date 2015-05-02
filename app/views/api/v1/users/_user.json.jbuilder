json.cache! user do
  json.id             user.id
  json.first_name     user.first_name
  json.last_name      user.last_name
  json.email          user.email
  json.picture        user.picture
  json.provider       user.provider
  json.password_digest user.password_digest

  json.created_at     user.created_at
  json.updated_at     user.updated_at
end
