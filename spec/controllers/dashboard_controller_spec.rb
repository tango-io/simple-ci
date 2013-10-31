require 'spec_helper'

describe DashboardController do
  let(:user){ Fabricate :user }

  it 'render index' do
    controller.stub(current_user: true)
    get :index
    expect(response).to render_template('index')
  end

  it 'redirect to root path' do
    get :index
    expect(response).to redirect_to(root_path)
  end
end
