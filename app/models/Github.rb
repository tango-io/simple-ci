require 'open-uri'
class Github
  attr_reader :gemfile, :script, :url

  def initialize url
    @url     = url
    @gemfile = open(url_gemfile).read rescue nil
    @script  = [
      "git clone #{@url}",
      "cd #{url.split('/').last}",
      "bundle install --path vendor/bundle",
    ]
  end

  TEST_ENV  = /rspec/
  REGEXP_DB = /pg|mysql|mongo|sqllite3|mysql2|oci8|mysqlplus/

  def is_valid?
    @gemfile.nil? ? false : update_script
  end

  private

  def update_script
    unless scan_empty?(REGEXP_DB)
      @script << 'bundle exec rake db:create'
      @script << 'bundle exec rake db:test:prepare'
    end
    scan_empty?(TEST_ENV) ? @script << 'rake test' : @script << 'bundle exec rspec'
    true
  end

  def scan_empty? regexp
    @gemfile.scan(regexp).empty?
  end

  def url_gemfile
    "#{@url}/raw/master/Gemfile"
  end

end
