# frozen_string_literal: true

class AllowedIpConstraint
  def initialize
    @ips = %w[
      127.0.0.1
      ::1
      72.48.136.69
    ]
  end

  def matches?(request)
    @request = request
    @ips.include?(ip)
  end

  private

  def ip
    @request.respond_to?(:remote_ip) ? @request.remote_ip : @request.ip
  end
end
