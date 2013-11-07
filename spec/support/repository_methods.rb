def repo
  {
    'name' => Faker::Lorem.sentence,
    'url'  => Faker::Internet.url
  }
end

def repositories
  repositories = []
  5.times { repositories << repo }
  repositories
end

def initialize_repositories(repos)
  repos.map do |repo|
    Repository.find_or_initialize_by(
      uid:   repo['id'],
      name: repo['name'],
      url:  repo['url'])
  end
end
