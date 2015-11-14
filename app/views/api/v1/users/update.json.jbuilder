json.success true
json.status 201
json.user do
  json.id @user.id
  json.email @user.email
  json.name @user.name
  json.customer_id @user.customer_id
end
