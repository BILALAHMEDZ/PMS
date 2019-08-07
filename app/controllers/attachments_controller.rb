class AttachmentsController < ApplicationController
  def create
    byebug
    @attachment = Attachment.create(attachment_params)
    redirect_to request.referrer, notice: 'Your attachment was successfully added' if @attachment.save
  end
  def destroy
    @attachment = Attachment.find(params[:id])
    redirect_to request.referrer, notice: 'Attachment was successfully remove.' if @attachment.destroy
  end
  private
  def attachment_params
    params.require(:attachment).permit(:attachment, :project_id)
  end
end
