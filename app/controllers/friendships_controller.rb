class FriendshipsController < ApplicationController

    def my_friends
        @friends = current_user.friends
    end

    def search
        if params[:search].present?
            @search = User.search(params[:search])
            @search = current_user.except_current_user(@search)
                if !@search.empty?
                    respond_to do |format|
                        format.js { render partial: 'friendships/result' }
                    end
                else
                    respond_to do |format|
                        flash.now[:alert] = "No user found"
                        format.js { render partial: 'friendships/result' }
                    end
                end
        else
            respond_to do |format|
                flash.now[:alert] = "Please enter a Name or Email to search"
                format.js { render partial: 'friendships/result' }
            end
        end
    end

    def create
        friend = User.find(params[:friend])
        @new_friend = Friendship.create(user: current_user, friend: friend)
        flash[:notice] = "You are now friends with User #{friend.first_name}"
        redirect_to my_friends_path
    end

    def destroy
        friend = User.find(params[:id])
        remove_friend = Friendship.where(user_id: current_user.id, friend_id: friend.id).first
        remove_friend.destroy
        flash[:notice] = "You stopped following #{friend.first_name}"
        redirect_to my_friends_path
    end
end