module ErrorHandler
  def error_handler(error)
    case error
    when ActionController::ParameterMissing
      render json: { error: error.message }, status: :bad_request
    when ActiveRecord::RecordNotFound
      render json: { error: error.message }, status: :not_found
    when ActiveRecord::RecordInvalid
      render json: { error: error.message }, status: :bad_request
    when JWT::VerificationError
      render json: { error: error.message }, status: :unauthorized
    when JWT::ExpiredSignature
      render json: { error: error.message }, status: :unauthorized
    when JWT::DecodeError
      render json: { error: error.message }, status: :unauthorized
    when ActionDispatch::Http::Parameters::ParseError
      render json: { error: error.message }, status: :bad_request
    else
      render json: { error: error.message }, status: :internal_server_error
    end
  end
end
