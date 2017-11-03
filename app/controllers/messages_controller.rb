class MessagesController < ApplicationController

  def create
    context = JSON.parse(message_params[:context].presence || '{}') # set the context variable as a Hash
    context.merge! current_customer.conversation_context if context.empty?  # add customer context if first message
    context[:locale] = message_params[:locale]

    response = Conversation.send message_params[:content], context  # send message and context to Watson Conversation

    # Extract messages and context 
    @messages = response[:output][:text]
    @context = response[:context].to_json

    respond_to { |format| format.js } # respond with Javascript to update chat bubble
  end

  private

  def message_params
    params.permit(:content, :context, :locale)
  end
end
