class JobsController < ApplicationController

    def index
        city = params["search"]
        s = Net::HTTP.get_response(URI.parse("https://stackoverflow.com/jobs/feed?q=react&l=#{city}")).body
        render json: Hash.from_xml(s).to_json
    end

    def remote
        response = RestClient.get("https://remoteok.io/api")
        jsonResponse=JSON.parse(response.body)
        # newHash = jsonResponse.map{|obj| obj[:link]=obj.delete :url}
        jsonResponse.drop(1).map do |obj| 
            obj["link"] = obj.delete "url"
            obj["category"] = obj.delete "tags"
        end
        render json: jsonResponse
    end



end