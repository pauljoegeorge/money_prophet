# frozen_string_literal: true

module Uid
  extend ActiveSupport::Concern

  included do
    before_create :generate_uid
  end

  private

  def generate_uid
    self.uid = SecureRandom.uuid
  end
end
