class UserStocksController < ApplicationController

    def create
        stock = Stock.has_stock(params[:stock])
        if stock.blank?
            stock = Stock.getprice(params[:stock])
            stock.save
        end
        @user_stock = UserStock.create(user: current_user, stock: stock)
        flash[:notice] = "Stock #{stock.name} was successfully added to your portfolio"
        redirect_to my_portfolio_path
    end
end
