module BankBalance
  module Update
    extend ActiveSupport::Concern

    included do
      after_create :update_bank_balance
    end

    private

    def generate_uid
      self.uid = SecureRandom.uuid
    end
  end
end
