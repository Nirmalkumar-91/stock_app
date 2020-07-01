class Stock < ApplicationRecord
    has_many :user_stocks
    has_many :users, through: :user_stocks

    validates :name, :ticker, presence: true

    def self.getprice(ticker_symbol)
        client = IEX::Api::Client.new(publishable_token: Rails.application.credentials.iex_client[:sandbox_key], endpoint: 'https://sandbox.iexapis.com/v1')
        begin
            new(ticker: ticker_symbol, name: client.company(ticker_symbol).company_name, last_price: client.price(ticker_symbol))
        rescue => exception
            return nil
        end
    end

    def self.has_stock(ticker_symbol)
        where(ticker: ticker_symbol).first
    end

    def self.get_all_stocks
        client = IEX::Api::Client.new(publishable_token: Rails.application.credentials.iex_client[:sandbox_key], endpoint: 'https://sandbox.iexapis.com/v1')
        client.stock_market_list(:mostactive)
    end
end
