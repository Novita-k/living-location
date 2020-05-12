json.array! @posts do |post|
  json.id post.id
  json.image post.images[0].image.file.file.split(/\public/,2)[1]
  json.title post.title
  json.text post.text
  json.nickname post.user.nickname
  json.address post.address
  json.user_id post.user_id
  json.user_sign_in current_user
end