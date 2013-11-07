class MessagesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def index
    @messages = Message.where("created_at > ?", Time.at(params[:after].to_i + 1)).order("created_at DESC")
    devices = Device.all
    puts devices
    puts "here first"
    device_tokens = []
    devices.each do |device|
      puts "looping"
      puts device.device_token
      device_tokens.push(device.device_token)
    end
    puts device_tokens
    puts "here"
    respond_to do |format|
      format.html
      format.js {}
      format.json {render json: @messages.to_json}
    end
  end

  def create
    @message = Message.new(params.require(:message).permit(:username, :content, :app_id))
    #devices = Device.where.not(device_token: params.require(:message).permit(:device_token))
    devices = Device.all
    device_tokens = []
    devices.each do |device|
      device_tokens.push(device.device_token)
    end
    notification = {
      :schedule_for => 5.seconds.from_now,
      :device_tokens => device_tokens,
      :aps => {:alert => 'You have new messages!', :badge => 1}
    }
    Urbanairship.push notification
    respond_to do |format|
      if @message.save
        format.json {render json: @message}
      else
        format.json {render json: @message.errors}
      end
    end
  end

  def show
    @message = Message.find(params[:id])
  end
end
