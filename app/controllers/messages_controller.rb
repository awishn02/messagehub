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
    respond_to do |format|
      if @message.save
        devices = Device.where.not(device_token: params[:message][:device_token])
        device_tokens = []
        devices.each do |device|
          device_tokens.push(device.device_token)
        end
        notification = {
          :device_tokens => device_tokens,
          :aps => {:alert => 'You have new messages!', :badge => 1}
        }
        Urbanairship.push(notification)
        format.json {render json: @message}
      else
        format.json {render json: @message.errors, :status => 500}
      end
    end
  end

  def messagesForUser
    @messages = Message.where("username = ?", params[:username])
    respond_to do |format|
      format.json {render json: @messages.to_json}
    end
  end

  def show
    @message = Message.find(params[:id])
  end
end
