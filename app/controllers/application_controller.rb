class ApplicationController < ActionController::API
  before_action :authorized

  def secret_key
    Rails.application.secrets.secret_key_base
  end 

    def encode_token(payload)
        # payload => { beef: 'steak' }
        JWT.encode(payload, secret_key)
      end
     
      def auth_header
        # { 'Authorization': 'Bearer <token>' }
        request.headers['Authorization']
      end
     
      def decoded_token
        
        if auth_header
          token = auth_header
          # headers: { 'Authorization': 'Bearer <token>' }
          begin
            JWT.decode(token, secret_key, true, algorithm: 'HS256')
            # JWT.decode => [{ "beef"=>"steak" }, { "alg"=>"HS256" }]
          rescue JWT::DecodeError
            nil
          end
        end
      end

      def decode(token)
        JWT.decode(token, secret_key, true, {algorithm: 'HS256'})[0]
        #return OG payload
    end 

        def current_user
            
            if decoded_token
              # decoded_token=> [{"user_id"=>2}, {"alg"=>"HS256"}]
              # or nil if we can't decode the token
              user_id = decoded_token[0]['user_id']
              @user = User.find_by(id: user_id)
            end
          end
         
          def logged_in?
            !!current_user
          end

          def authorized
            render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
          end

end
