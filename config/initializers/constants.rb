module Constants
  case Rails.env
  when "development"
    GOOGLE_REDIRECT_URI = "http://localhost:3001/sign_in"
  when "test"
    GOOGLE_REDIRECT_URI = "http://localhost:3001/sign_in"
  when "production"
    GOOGLE_REDIRECT_URI = "https://www.paulworks.online/sign_in"
  end
end
