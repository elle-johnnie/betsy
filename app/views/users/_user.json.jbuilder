json.extract! user, :id, :uid, :username, :email, :created_at, :updated_at
json.url user_url(user, format: :json)
