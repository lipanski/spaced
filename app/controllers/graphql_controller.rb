# frozen_string_literal: true

class GraphqlController < ActionController::Base
  before_action :authenticate_api_credential!, only: :execute

  protect_from_forgery with: :null_session

  def execute
    result =
      SpacedSchema.execute(
        params[:query],
        variables: params[:variables]&.to_unsafe_hash,
        context: { current_user: current_api_credential.user },
        operation_name: params[:operationName]
      )

    render json: result
  rescue StandardError => e
    logger.error(e.message)
    logger.error(e.backtrace.join("\n"))

    render json: { errors: [{ message: "unknown_error" }] }.freeze, status: 500
  end

  # The GraphiQL editor, available only in development.
  def graphiql
    render layout: false
  end
end
