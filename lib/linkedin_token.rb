require 'linkedin'
class LinkedinToken < ConsumerToken
  LINKEDIN_SETTINGS = {:site => 'https://api.linkedin.com' }
  def self.consumer
    @consumer ||= LinkedIn::Client.new(credentials[:key], credentials[:secret]).consumer
  end

  def client
    unless @client
      @client = LinkedIn::Client.new(credentials[:key], credentials[:secret])

      rtoken = @client.request_token.token
      rsecret = @client.request_token.secret

      @client.authorize_from_access rtoken, rsecret

      RAILS_DEFAULT_LOGGER.debug("REQ URL: #{@client.request_token}")
    end
    RAILS_DEFAULT_LOGGER.debug("REQ URL: #{@client.request_token}")
    @client
  end
end