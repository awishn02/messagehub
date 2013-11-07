class MessagesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def index
    @messages = Message.where("created_at > ?", Time.at(params[:after].to_i + 1)).order("created_at DESC")
    respond_to do |format|
      format.html
      format.js {}
      format.json {render json: @messages.to_json}
    end
  end

  def create
    @message = Message.new(params.require(:message).permit(:username, :content, :app_id))
    #devices = Device.where.not(device_token: params.require(:message).permit(:device_token))
    # devices = Device.all
    # device_tokens = []
    # devices.each do |device|
    #   device_tokens.push(device.device_token)
    # end
    notification = {
      :schedule_for => Time.now,
      :device_tokens => ['C44CA5DC5B47038CEF7802010C514A3564396828BBB643CF861220EAD5961C9B'],
      :aps => {:alert => 'You have new messages!', :badge => 1}
    }
    Urbanairship.push(notification)
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
