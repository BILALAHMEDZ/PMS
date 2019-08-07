# frozen_string_literal: true

class Attachment < ApplicationRecord
  belongs_to :project
  mount_uploader :attachment, AttachmentUploader
end
