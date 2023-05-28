# frozen_string_literal: true

module Balance
  class GetForecastService
    attr_reader :current_user, :from, :forecast_months, :forecast_months_as_string

    def initialize(current_user)
      @current_user = current_user
      @from = Time.zone.today.beginning_of_month
      @data = Array.new(12, 0)
    end

    def execute
      set_initialize_months
      @savings = set_monthly_savings
      success
    end

    private

    def success
      OpenStruct.new(success?: true, data: { savings: @savings, months: @forecast_months_as_string })
    end

    def set_initialize_months
      @forecast_months_as_string = []
      @forecast_months = []
      12.times do |i|
        @forecast_months_as_string << (from + i.month).strftime("%Y-%m")
        @forecast_months << (from + i.month)
      end
    end

    def set_monthly_savings
      savings = []
      @forecast_months.each do |month|
        savings << current_user.bank_balance_forecasts.of_month(month).first.amount
      end
      savings
    end
  end
end
