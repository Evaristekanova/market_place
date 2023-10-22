module Authenticable
    def current_user
        return @current_user if @current_user
        
        token = token_from_request
        @current_user ||= user_from_token(token)
        
       @current_user 
    end


    private

    def token_from_request
        token = request.headers['Authorization']&.split(' ')&.last
        raise JWT::DecodeError, "Invalid Credentials" unless token
            
        token
    end

    def user_from_token(token)
        decoded_token = JsonWebToken.decode(token)
        User.find(decoded_token[:user_id]) rescue ActiveRecord::RecordNotFound
    end
end