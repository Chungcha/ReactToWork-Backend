class SavesController < ApplicationController

    def create
        byebug
        save = Save.create(user_id:params[:user_id] , job_id:params[:job_id])

        render json: save
    end

    def destroy
        save = Save.find(params[:id])
        save.destroy

        render json: {message:"Save Destroyed"}
    end
end