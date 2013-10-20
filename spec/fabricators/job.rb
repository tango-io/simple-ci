Fabricator :job do
  session_id Digest::SHA1.hexdigest(Faker::Internet.ip_v4_address)
  github_url Faker::Internet.url
end
