Fabricator :job do
  session_id Digest::SHA1.hexdigest(request.remote_ip)
  github_url Faker::Internet.url
end
