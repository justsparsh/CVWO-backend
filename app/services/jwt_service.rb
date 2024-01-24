require 'jwt'

class JwtService
  def self.encode(payload)
    JWT.encode(payload, Rails.application.config.jwt_secret, 'HS256')
  end

  def self.decode(token)
    JWT.decode(token, Rails.application.config.jwt_secret, true, algorithm: 'HS256')
  end
end
