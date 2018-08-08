# frozen_string_literal: true

require 'resolv'

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
    real_ip = @request.headers['X-Real-IP']
    ip_address =
      if valid_ip?(real_ip)
        real_ip
      else
        @request.respond_to?(:remote_ip) ? @request.remote_ip : @request.ip
      end

    Rails.logger.debug("AllowedIpConstraint: ip = #{ip_address}")

    ip_address
  end

  def valid_ip?(ip_address)
    ip_address.present? && (valid_ipv4?(ip_address) || valid_ipv6?(ip_address))
  end

  def valid_ipv4?(ip_address)
    Resolv::IPv4::Regex.match?(ip_address)
  end

  def valid_ipv6?(ip_address)
    Resolv::IPv6::Regex.match?(ip_address)
  end
end
