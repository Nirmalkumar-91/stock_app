class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  def self.get_all_stocks
    client = IEX::Api::Client.new(publishable_token: Rails.application.credentials.iex_client[:sandbox_key], endpoint: 'https://sandbox.iexapis.com/v1')
    client.stock_market_list(:mostactive)
  end
end
