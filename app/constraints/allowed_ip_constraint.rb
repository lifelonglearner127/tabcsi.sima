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
    @ips.include?(request.remote_ip)
  end
end
