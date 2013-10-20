require 'spec_helper'

describe Github do
  context 'methods' do

    before do
      @url = 'https://github.com/rspec/rspec-rails'
      @gemfile = Github.new(@url)
    end

    it 'is_valid? return true if the gemfile is valid' do
      expect(@gemfile.is_valid?).to be_true
    end

    it 'update_script verify if gemfile have gems for testing' do
      @gemfile.send(:update_script)
      @gemfile.script.should include('bundle exec rake test' || 'bundle exec rspec')
    end

    it 'url_gemfile return an url to get a gemfile' do
      url = @gemfile.send(:url_gemfile)
      url.should eq("#{@url}/raw/master/Gemfile")
    end
  end
end
