class SavesController < ApplicationController

    def create
        save = Save.create(user_id:params[:user_id] , job_id:params[:job_id])

        render json: save
    end

    def destroy
        save = Save.find(params[:id])
        save.destroy

        render json: save
    end
end