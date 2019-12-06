class UsersController < ApplicationController
    skip_before_action :authorized, only: [:create, :show, :validateUsername]

    def validateUsername
        user = User.find_by(username: params[:username])
        if user
            render json: {message: "name unavailable"}
        else
            render json: {message: "name available"}
        end
    end

    def create
        @user = User.create(user_params)
            if @user.valid?
            @token = encode_token({user_id: @user.id})
            render json: { user: UserSerializer.new(@user), jwt: @token }, status: :created
            else
            render json: { error: 'failed to create user' }, status: :not_acceptable
            end
    end
    

    def destroy
    end

    def show
        token = request.headers["Authorization"]
        payload = decode(token)
        user = User.find(payload["user_id"])
        # render json: { user: UserSerializer.new(current_user) }, status: :accepted
        render json: user
    end

    def update
    end

    private
    def user_params
      params.require(:user).permit(:username, :password, :bio, :email, :zipCode, :admin)
    end
end