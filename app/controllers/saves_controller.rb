class SavesController < ApplicationController

    def create
        byebug
        save = Save.create(saver_id:params[:user_id] , job_id:params[:job_id])

        render json: save
    end

    def destroy
        save = Save.find(params[:id])
        save.destroy

        render json: save
    end
end