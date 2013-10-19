require 'spec_helper'

describe Github do
  context 'methods' do

    before do
      @url = 'https://github.com/rspec/rspec-rails'
      @gemfile = Github.new(@url)
    end

    it 'is_valid? return true if the gemfile is valid' do
      response = @gemfile.is_valid?
      response.class.should be_true
    end

    it 'folder_name return a name of folder from an url' do
      response = @gemfile.send(:folder_name, @url)
      response.should eq(@url.slice(/\/[^\/]+$/).gsub('/', ''))
    end

    it 'update_script verify if gemfile have gems for testing' do
      @gemfile.send(:update_script)
      @gemfile.script.should include('rake test' || 'bundle exec rspec')
    end

    it 'generate_list return list of gems ' do
      response = @gemfile.send(:generate_list)
      response.should be_kind_of(Array)
    end

    it 'url_gemfile return an url to get a gemfile' do
      response = @gemfile.send(:url_gemfile)
      response.should eq("#{@url}/raw/master/Gemfile")
    end
  end
end
