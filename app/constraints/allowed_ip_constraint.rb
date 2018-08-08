# frozen_string_literal: true

class AllowedIpConstraint
  include Singleton

  def self.matches?(request)
    instance.matches?(request)
  end

  def matches?(request)
    @request = request
    allowed_ip_addresses.include?(ip)
  end

  private

  def allowed_ip_addresses
    Nenv.instance.allowed_ip_addresses.split(',')
  end

  def ip
    ip_address =
      @request.respond_to?(:remote_ip) ? @request.remote_ip : @request.ip

    Rails.logger.debug("AllowedIpConstraint: ip = #{ip_address}")

    ip_address
  end
end
