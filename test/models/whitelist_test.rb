require 'test_helper'

module Messaging
  class WhitelistTest < ActiveSupport::TestCase
    describe '.approved?' do
      it 'reject ips not on list' do
        assert_equal false, Whitelist.approved?('204.14.232.24')
        assert_equal false, Whitelist.approved?('204.14.231.0')
        assert_equal false, Whitelist.approved?('204.14.232.24')
        assert_equal false, Whitelist.approved?('96.43.144.23')
      end

      it 'approve ips on list' do
        assert_equal true, Whitelist.approved?('204.14.232.23')
        assert_equal true, Whitelist.approved?('127.0.0.1')
        assert_equal true, Whitelist.approved?('182.50.76.0')
        assert_equal true, Whitelist.approved?('96.43.144.0')
        assert_equal true, Whitelist.approved?('96.43.144.15')
        assert_equal true, Whitelist.approved?('96.43.144.22')
      end
    end
  end
end

