require_relative "base_service"

class SessionService < BaseService
  def get_userId(email, password)
    payload = { email: email, password: password }
    result = self.class.post(
      "/sessions",
      body: payload.to_json,
      headers: {
        "Content-Type": "application/json",
      },
    )

    return result.parsed_response["_id"]
  end
end
