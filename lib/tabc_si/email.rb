# frozen_string_literal: true

module TabcSi
  module Email
    WSP ||= /[ \t]/.freeze
    QUOTED_PAIR ||= /\\([!-~]|#{WSP})/.freeze
    FWS ||= /(#{WSP}*\r\n)?#{WSP}+/.freeze
    CTEXT ||= /[!-'*-\[\]-~]/.freeze
    COMMENT ||= /\((#{FWS}?(#{CTEXT}|#{QUOTED_PAIR}|\g<0>))*#{FWS}?\)/.freeze
    CFWS ||= /((#{FWS}?#{COMMENT})+#{FWS}?|#{FWS})/.freeze
    ATEXT ||= %r{[!#-'*+\-/-9=?A-Z^_`-~]}.freeze
    DOT_ATOM_TEXT ||= /#{ATEXT}+(\.#{ATEXT}+)*/.freeze
    DOT_ATOM ||= /#{CFWS}?#{DOT_ATOM_TEXT}#{CFWS}?/.freeze
    QCONTENT ||= /([!#-\[\]-~]|#{QUOTED_PAIR})/.freeze
    QUOTED_STRING ||= /#{CFWS}?"(#{FWS}?#{QCONTENT})*#{FWS}?"#{CFWS}?/.freeze
    LOCAL_PART ||= /(?:#{DOT_ATOM}|#{QUOTED_STRING})/.freeze
    DOMAIN_LITERAL ||= /#{CFWS}?\[(#{FWS}?[!-Z^-~])*#{FWS}?\]#{CFWS}?/.freeze
    DOMAIN ||= /(?:#{DOT_ATOM}|#{DOMAIN_LITERAL})/.freeze
    ADDR_SPEC ||= /^#{LOCAL_PART}@#{DOMAIN}$/.freeze

    def self.valid?(value)
      ADDR_SPEC.match?(value)
    end
  end
end
