class Account
  ACCOUNT_ID = 'Id'
  UPDATED_INFO = 'Salesforce_data'

  def initialize(request)
    @soap_message = request
  end

  def handle_update
    # Assumming that the outbound message has the following data
    id   = parse(ACCOUNT_ID)   # key to look up for our local tables
    info = parse(UPDATED_INFO) # data to be updated

    raise "Invalid id or info" unless id.present? && info.present?

    # search accounts for id
    if account = Account.find_by_salesforce_id(id)
      account.info = info # updating one column
      account.save!
    else
      raise "Id(#{id}) not found in Accounts"
    end
  end

  def parse(key)
    @soap_message.xpath("//sf:#{key}", { 'sf'=> "urn:sobject.enterprise.soap.sforce.com" }).text
  end
end
