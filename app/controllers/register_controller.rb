class RegisterController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def index
    puts params
    puts params[:device]
    puts params[:device][:device_token]
    Urbanairship.register_device(params[:device][:device_token])
    @device = Device.new(params.require(:device).permit(:device_token))
    respond_to do |format|
      if @device.save
        puts @device
        format.json {render :text => params[:device]}
      else
        puts @device.errors
        format.json {render json: @device.errors}
      end
    end
  end

  def destroy
    Urbanairship.unregister_device params[:device][:device_token]
  end
end
