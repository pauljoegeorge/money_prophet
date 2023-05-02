# frozen_string_literal: true

module Uqid
  extend ActiveSupport::Concern

  included do
    before_create :generate_uqid
  end

  private

  def generate_uqid
    self.uqid = SecureRandom.uuid
  end
end
