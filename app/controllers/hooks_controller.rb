class HooksController <ApplicationController

  def github
  end

  def payload_params
    params.require(:payload)
  end

end
