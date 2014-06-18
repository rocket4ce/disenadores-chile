json.array!(@blogs) do |blog|
  json.extract! blog, :id, :titulo, :cuerpo, :user_id
  json.url blog_url(blog, format: :json)
end
