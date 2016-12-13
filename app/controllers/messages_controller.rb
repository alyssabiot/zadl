class MessagesController < ApplicationController
  before_action :set_event

  def create
    @message = Message.new(message_params)
    @message.event = @event
    @message.user = current_user
    authorize @message
    if @message.save
      respond_to do |format|
       format.html { redirect_to event_path(@event) }
       format.js  # <-- will render `app/views/messages/create.js.erb`
      end
    else
      respond_to do |format|
      format.html { render 'events/show'}
      format.js  # <-- idem
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def set_event
    @event = Event.find(params[:event_id])
  end
end
