module API
  module V1
    class RegistrationController < LoginSystemController
      def create
        success, result, errors = DispatchActionService.new(:register, params).run
        if success
          render json: { token: result }, status: :ok
        else
          render json: { errors: errors }, status: :unprocessable_entity
        end
      end
    end
  end
end
