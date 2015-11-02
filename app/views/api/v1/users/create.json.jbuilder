json.success true
json.status 201
json.access_token @api_key.access_token
json.user do
  json.id @user.id
  json.email @user.email
  json.name @user.name
  
end
