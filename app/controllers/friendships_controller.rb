class FriendshipsController < ApplicationController

    def my_friends
        @friends = current_user.friends
    end

    def destroy
        friend = User.find(params[:id])
        remove_friend = Friendship.where(user_id: current_user.id, friend_id: friend.id).first
        remove_friend.destroy
        flash[:notice] = "You stopped following #{friend.first_name}"
        redirect_to my_friends_path
    end
end