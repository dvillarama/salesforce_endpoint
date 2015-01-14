class AccountController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:update]

  before_action do
    Rails.logger.info "*** Salesforce web hook from #{request.remote_ip} ***"

    # verify that the message is coming from salesforce
    render nothing: true, status: :unauthorized unless Whitelist.approved? request.remote_ip
  end

  def update
    Rails.logger.info "*** Salesforce Account updated web hook ***"
    request_body = request.body.read
    Rails.logger.info "body => #{request_body}"

    request_xml = Nokogiri::XML(request_body)
    Account.new(request_xml).handle_update

    render layout: false
  end

end
