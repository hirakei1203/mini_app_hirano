json.array! @comments do |comment|
  json.id         comment.id
  json.text       comment.comment
  json.user_name  comment.user.user_name
end