class Whitelist

  # Only accept outgoing message coming from salesforce
  def self.approved?(ip)
    white_list.include? ip
  end

  private

  def self.white_list
    @white_list ||= build_white_list
  end

  # https://www.salesforce.com/developer/docs/api/Content/sforce_api_om_outboundmessaging_security.htm
  def self.build_white_list
    [ '127.0.0.1' ] + # testing locally
      build('204.14.232.', 0, 23) +
      build('204.14.237.', 0, 24) +
      build('96.43.144.', 0, 22) +
      build('96.43.148.', 0, 22) +
      build('204.14.234.', 0, 23) +
      build('204.14.238.', 0, 23) +
      build('182.50.76.', 0, 22)
  end

  def self.build(base, low, high)
    list = []
    for i in low..high
      list << base + i.to_s
    end
    list
  end
end
