def create_user(params)
  user = User.build_from_omniauth params
  user.save
  user
end

