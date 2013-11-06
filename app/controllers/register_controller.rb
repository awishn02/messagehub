class RegisterController < ApplicationController

  def index
    Urbanairship.register_device(params[:device][:device_token])
    Device.new(params[:device])
    puts params
    puts params[:device]
    puts params[:device][:device_token]
  end
end
