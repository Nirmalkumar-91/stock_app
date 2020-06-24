class Stock < ApplicationRecord


    def self.getprice(ticker_symbol)
        client = IEX::Api::Client.new(publishable_token: Rails.application.credentials.iex_client[:sandbox_key], endpoint: 'https://sandbox.iexapis.com/v1')
        client.price(ticker_symbol)
    end
end
