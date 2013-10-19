require 'spec_helper'

describe Api::WorkersController do

  it 'returns the status of the workers' do
    get :index
    hash = JSON.parse(response.body)
    expect(hash).to include('available')
    expect(hash).to include('total')
    expect(hash).to include('busy')
  end

end
