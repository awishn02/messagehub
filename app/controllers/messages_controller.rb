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
