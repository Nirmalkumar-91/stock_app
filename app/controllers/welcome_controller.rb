class WelcomeController < ApplicationController
    before_action :index
    def index
        @stocks = Stock.get_all_stocks
        @list_stock = @stocks.each do |list_stock|
            list_stock
        end
    end
end