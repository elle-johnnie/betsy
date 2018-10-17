json.extract! review, :id, :rating, :description, :created_at, :updated_at
json.url review_url(review, format: :json)
