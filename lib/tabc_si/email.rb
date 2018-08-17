# frozen_string_literal: true

module TabcSi
  module Email
    WSP ||= /[ \t]/
    QUOTED_PAIR ||= /\\([!-~]|#{WSP})/
    FWS ||= /(#{WSP}*\r\n)?#{WSP}+/
    CTEXT ||= /[!-'*-\[\]-~]/
    COMMENT ||= /\((#{FWS}?(#{CTEXT}|#{QUOTED_PAIR}|\g<0>))*#{FWS}?\)/
    CFWS ||= /((#{FWS}?#{COMMENT})+#{FWS}?|#{FWS})/
    ATEXT ||= %r{[!#-'*+\-/-9=?A-Z^_`-~]}
    DOT_ATOM_TEXT ||= /#{ATEXT}+(\.#{ATEXT}+)*/
    DOT_ATOM ||= /#{CFWS}?#{DOT_ATOM_TEXT}#{CFWS}?/
    QCONTENT ||= /([!#-\[\]-~]|#{QUOTED_PAIR})/
    QUOTED_STRING ||= /#{CFWS}?"(#{FWS}?#{QCONTENT})*#{FWS}?"#{CFWS}?/
    LOCAL_PART ||= /(?:#{DOT_ATOM}|#{QUOTED_STRING})/
    DOMAIN_LITERAL ||= /#{CFWS}?\[(#{FWS}?[!-Z^-~])*#{FWS}?\]#{CFWS}?/
    DOMAIN ||= /(?:#{DOT_ATOM}|#{DOMAIN_LITERAL})/
    ADDR_SPEC ||= /^#{LOCAL_PART}@#{DOMAIN}$/

    def self.valid?(value)
      ADDR_SPEC.match?(value)
    end
  end
end
