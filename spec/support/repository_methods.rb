def public_repo
  Fabricate.build(
    :repository,
    uid: user.uid,
    name: Faker::Internet.domain_word,
    url: Faker::Internet.url,
  )
end

def public_repositories
  repositories = []
  repositories << repository
  5.times { repositories << public_repo }
  repositories
end
