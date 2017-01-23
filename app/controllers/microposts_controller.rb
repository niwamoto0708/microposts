class MicropostsController < ApplicationController
    before_action :logged_in_user, only: [:create]
    
    def create
        @micropost = current_user.microposts.build(micropost_params)
        if @micropost.save
            flash[:success] = "Micropost created!"
            redirect_to root_url
        else
            @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
            render 'static_pages/home'
        end
    end
    
    def retweet
        @micropost = current_user.microposts.build
        @retweet_micropost = Micropost.find(params[:id])
        @micropost.retweets_microposts_id = @retweet_micropost.id
        @micropost.content = @retweet_micropost.content
        if @micropost.save
            flash[:success] = "Retweet Successful!"
            redirect_to root_url
        else
            @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
            render 'static_pages/home'
        end
        # @micropost.content = @user.microposts.build(micropost_params)
        # @micropost.retweets_microposts_id = @user.user_id
        # if @micropost.save
        #     flash[:success] = "Micropost retweeted!"
        #     redirect_to root_url
        # else
        #     @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
        #     render 'static_pages/home'
        # end
    end
    
    def destroy
        @micropost = current_user.microposts.find_by(id: params[:id])
        return redirect_to root_url if @micropost.nil?
        @micropost.destroy
        flash[:success] = "Micropost deleted"
        redirect_to request.referrer || root_url
    end
    
    private
    def micropost_params
        params.require(:micropost).permit(:content)
    end
end
