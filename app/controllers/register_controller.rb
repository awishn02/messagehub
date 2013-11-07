class RegisterController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def index
    puts params
    puts params[:device]
    puts params[:device][:device_token]
    Urbanairship.register_device(params[:device][:device_token])
    Device.new(params[:device])
    respond_to do |format|
      format.json {render :text => params[:device]}
    end
  end
end
