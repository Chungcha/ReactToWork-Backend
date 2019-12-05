class JobsController < ApplicationController
    skip_before_action :authorized, only: [:create, :stackoverflowjobs, :getStackJobs, :remote, :index]
    #take out :create, anyone can make posts right now.

    def create
        job = Job.create(
            company: job_params[:company], 
            description: job_params[:description],
            link: job_params[:link],
            position: job_params[:position],
            zipCode: job_params[:zipCode],
            category: job_params[:category].split(" "),
            date: DateTime.current 
        )
        render json: job
    end

    def destroy
        job = Job.find(params[:id])
        job.destroy
        render json: {}, status: :no_content
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
        params.require(:job).permit(:position, :company, :link, :description, :zipCode, :category)
    end

end