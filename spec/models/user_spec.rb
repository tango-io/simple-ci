require 'spec_helper'

describe User do

  context 'methods' do

    before do
      @auth =JSON.parse( {
        'uid' => '1337',
        'provider' => 'github',
        'info' => {
          'name' => 'cesar gomez',
          'nickname' => 'cesargomez89'
        }
      }.to_json)

      @repos = JSON.parse(open('https://api.github.com/users/cesargomez89/repos').read)
      @names = @repos.map {|repo| { name: repo['name'] } }
    end

    it 'create a user from github' do
      User.create_from_omniauth @auth
      User.count.should eq(1)
    end

    it 'get the public repositories of a user' do
      User.create_from_omniauth @auth
      User.first.public_repositories.should eq(@names)
    end

  end
end
