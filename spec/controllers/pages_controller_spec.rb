require 'spec_helper'

describe PagesController do

  it 'render index' do
    get :index
    expect(response).to render_template('index')
  end

  it 'render dashboard index' do
    controller.stub(user_signed_in?: true)
    get :index
    expect(response).to redirect_to(dashboard_index_path)
  end

  #it 'respond json ' do
    #get :verify_gemfile, repository: 'anithing/something', format: :json
    #json = { message: 'invalid repository' }
    #expect(response.message).to eq(json)
  #end

  it 'when response with status 422' do
    get :verify_gemfile, repository: 'anithing/something', format: :json
    expect(response.status).to eq(422)
  end
end
