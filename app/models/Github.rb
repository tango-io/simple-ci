require 'open-uri'
class Github
  attr_reader :gemfile, :script, :url

  def initialize url
    @url     = url
    @gemfile = open(url_gemfile).read rescue nil
    @script  = [
      "git clone #{@url}",
      "cd #{folder_name @url}",
      "bundle install --path vendor",
      "rake db:create",
      "rake db:test:prepare"
    ]
  end

  TEST_ENV = %w(rspec)

  def is_valid?
    @gemfile.nil? ? false : update_script
  end

  private

  def folder_name url
    url.slice(/\/[^\/]+$/).gsub('/', '')
  end

  def update_script
    gem_list = generate_list
    if gem_list.include?(TEST_ENV)
      @script << 'bundle exec rspec'
    else
      @script << 'rake test'
    end
    true
  end

  def generate_list
    list = []
    @gemfile.each_line do |line|
      list << line.gsub("-", ' ') if line.include?("gem '")
    end
    list
  end

  def url_gemfile
    "#{@url}/raw/master/Gemfile"
  end

end
