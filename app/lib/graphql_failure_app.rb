# frozen_string_literal: true

class GraphqlFailureApp < Devise::FailureApp
  def respond
    self.status = 401
    self.content_type = "application/json"
    self.response_body = { "errors": [{ message: "unauthorized" }] }.to_json.freeze
  end
end
