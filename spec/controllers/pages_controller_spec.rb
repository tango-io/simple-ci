require 'spec_helper'

describe PagesController do
  before do
    request.stub(:remote_ip).and_return('foo')
    @user_id = Digest::SHA1.hexdigest(request.remote_ip)
  end

  context 'session' do

    it 'can create a session when the user visit the index page' do
      get :index
      session[:user][:id].should eq(@user_id)
    end

  end

end
