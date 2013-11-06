class RegisterController < ApplicationController

  def index
    Urbanairship.register_device(params[:device_token])
    Device.new(params[:device_token])
  end
end
