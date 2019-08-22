# frozen_string_literal: true

class Attachment < ApplicationRecord
  belongs_to :project
  validates :attachment, presence: true
  mount_uploader :attachment, AttachmentUploader
end
