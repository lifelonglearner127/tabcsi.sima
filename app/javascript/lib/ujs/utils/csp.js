import Rails from '../rails'

// Content-Security-Policy nonce for inline scripts
Rails.cspNonce = () => {
  const meta = document.querySelector('meta[name=csp-nonce]')

  return meta && meta.content
}
