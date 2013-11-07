def auth
  {
    'uid' => Random.new.rand(9999).to_s,
    'provider' => 'github',
    'info' => {
      'name' => Faker::Name.name,
      'nickname' => Faker::Internet.user_name
    }
  }
end
