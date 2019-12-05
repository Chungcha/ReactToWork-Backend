class JobsController < ApplicationController
    skip_before_action :authorized, only: [:stackoverflowjobs, :getStackJobs, :remote, :index]
    #take out :create, anyone can make posts right now.

    def create
        if current_user 
        user = current_user
            if user[:admin] && request.headers["Save"]=="false"
                job = Job.create(
                company: job_params[:company], 
                description: job_params[:description],
                link: job_params[:link],
                position: job_params[:position],
                zipCode: job_params[:zipCode],
                category: job_params[:category],
                date: DateTime.current,
                poster_id: user.id
                )
                render json: job


            elsif request.headers["Save"]

                job2 = Job.find_or_create_by(
                    company: job_params[:company], 
                    description: job_params[:description],
                    link: job_params[:link],
                    position: job_params[:position],
                    zipCode: job_params[:zipCode],
                    category: job_params[:category],
                    date:  job_params[:date]
                    )


                    # job2 = Job.find_or_create_by(link: job_params[:link]) do |job|
                    #     job.company = job_params[:company], 
                    #     job.description = job_params[:description],
                    #     job.position = job_params[:position],
                    #     job.zipCode = job_params[:zipCode],
                    #     job.category = job_params[:category],
                    #     job.date = job_params[:date]
                    # end

                     save = Save.find_or_create_by(saver_id:user.id,job_id:job2.id)
                    
                    render json: job2

            else
                render json: { message: "You're Not AN ADMIN!!!!!" }, status: :unauthorized
            end
            
        end
    end

    def destroy
        if current_user 
            user = current_user
                if user[:admin] 
                    job = Job.find(params[:id])
                    job.destroy
                    render json: {}, status: :no_content
                else
                    render json: { message: "You're Not AN ADMIN!!!!!" }, status: :unauthorized
                end
                
            end
    end

    def index
        city = params["search"]
        allJobs = self.getStackJobs(city) + self.remote
        # take out remote for a seperate remote fetch, this just adds up the array
        render json: allJobs
    end

    def stackoverflowjobs
        city = params["search"]
        jobsArr = self.getStackJobs(city)
        render json: jobsArr
    end

    def getStackJobs(city)
        city = params["search"]
        s = Net::HTTP.get_response(URI.parse("https://stackoverflow.com/jobs/feed?q=react&l=#{city}")).body
        jsonResponse=JSON.parse(Hash.from_xml(s).to_json)
        jobsArr = jsonResponse["rss"]["channel"]["item"]
        jobsArr.map do |obj|
            obj["company"] = obj["author"].delete "name"
            obj["position"] = obj.delete "title"
            obj.delete "author"
            obj["date"] = obj.delete "pubDate"
        end
        return jobsArr
    end

    def remote
        response = RestClient.get("https://remoteok.io/api")
        jsonResponse=JSON.parse(response.body)
        jsonResponse.map do |obj|  
                obj["link"] = obj.delete "url"
                obj["category"] = obj.delete "tags"
        end
        jsonResponse.drop(1).filter do |obj|
            obj["category"].include?("react")
        end
        # this drops a hash of words.
    end

    private

    def job_params
        params.require(:job).permit(:position, :company, :link, :description, :zipCode, :category, :date)
    end

end
