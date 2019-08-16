# frozen_string_literal: true

class AttachmentsController < ApplicationController
  def create
    @attachment = Attachment.create(attachment_params)
    redirect_to request.referrer, notice: 'Your attachment was successfully added' if @attachment.save
    redirect_to request.referrer, alert: 'This attachment cannot be added, Unsupported Extension!!!' unless @attachment.save
  end

  def destroy
    @attachment = Attachment.find(params[:id])
    redirect_to request.referrer, notice: 'Attachment was successfully remove.' if @attachment.destroy
    redirect_to request.referrer, alert: 'This attachment cannot be deleted' unless @attachment.destroy
  end

  private

  def attachment_params
    params.require(:attachment).permit(:attachment, :project_id)
  end
end
