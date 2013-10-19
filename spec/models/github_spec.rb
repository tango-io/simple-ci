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

    it 'folder_name return a name of folder from an url' do
      folder_name = @gemfile.send(:folder_name, @url)
      folder_name.should eq(@url.slice(/\/[^\/]+$/).gsub('/', ''))
    end

    it 'update_script verify if gemfile have gems for testing' do
      @gemfile.send(:update_script)
      @gemfile.script.should include('rake test' || 'bundle exec rspec')
    end

    it 'generate_list return list of gems ' do
      list = @gemfile.send(:generate_list)
      list.should be_kind_of(Array)
    end

    it 'url_gemfile return an url to get a gemfile' do
      url = @gemfile.send(:url_gemfile)
      url.should eq("#{@url}/raw/master/Gemfile")
    end
  end
end
