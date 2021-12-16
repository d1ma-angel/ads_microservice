module RouteHelpers
  def app
    ApplicationController
  end

  def response_body
    JSON(last_response.body)
  end
end
