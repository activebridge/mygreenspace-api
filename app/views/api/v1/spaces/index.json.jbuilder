json.spaces @spaces do |space|
  json.id             space.id

  json.created_at     space.created_at
  json.updated_at     space.updated_at

  json.user_id        space.user_id
end
