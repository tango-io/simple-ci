require 'spec_helper'

describe SessionsController do

  before do
    request.stub('env').and_return({
      'omniauth.auth' => {
        'uid' => '1337',
        'provider' => 'github',
        'info' => {
          'name' => Faker::Name.name,
          'nickname' => Faker::Internet.user_name
        },
        'credentials' => { 'token' => '1234567890098765432' }
      }
    })
  end

  it 'creates a user from a given omniauth session' do
    get :create, provider: 'github'
    expect(response).to redirect_to(dashboard_index_path)
  end

  it "doesn't create the session if the data is wrong" do
    request.stub('env').and_return({
      'omniauth.auth' => {
        'uid' => nil,
        'provider' => nil,
        'info' => {
          'name' => nil,
          'nickname' => nil
        }
      }
    })
    get :create, provider: 'github'
    expect(response).to redirect_to(root_path)
  end

  it 'destroys the session' do
    delete :destroy
    expect(response).to redirect_to(root_path)
  end

end
