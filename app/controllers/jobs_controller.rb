class JobsController < ApplicationController
    def index
        city = params["search"]
        s = Net::HTTP.get_response(URI.parse("https://stackoverflow.com/jobs/feed?q=react&l=#{city}")).body
        render json: Hash.from_xml(s).to_json
    end
end