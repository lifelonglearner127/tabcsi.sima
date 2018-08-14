# frozen_string_literal: true

module ApplicationHelper
  def full_page_title
    app_title = I18n.t('titles.application')
    i18n_page_title = title

    content_for(:page_title, i18n_page_title) if i18n_page_title != app_title

    page_title(app_name: app_title, separator: ' | ')
  end

  def controller_stylesheet_pack_tags(**options)
    names = pack_names(:stylesheet)
    stylesheet_pack_tag(*names, **options)
  end

  def controller_javascript_pack_tags(**options)
    names = pack_names(:javascript)
    javascript_pack_tag(*names, **options)
  end

  def page_data(model: nil, url: nil, format: nil, **options)
    options[:allow_method_names_outside_object] = true
    options[:skip_default_ids] = !form_with_generates_ids

    if model
      url ||= polymorphic_path(model, format: format)

      model = model.last if model.is_a?(Array)
    end

    html_options = html_options_for_form_with(url, model, options)
    authenticity_token = html_options.delete('authenticity_token')
    method = html_options.delete('method').to_s.downcase

    case method
    when 'get'
      html_options['method'] = 'get'
    when 'post', ''
      html_options['method'] = 'post'
      html_options['authenticity_token'] =
        token(
          authenticity_token,
          form_options: {
            action: html_options['action'],
            method: 'post'
          }
        )
    else
      html_options['method'] = 'post'
      html_options['hidden_method'] = method.to_s
      html_options['authenticity_token'] =
        token(
          authenticity_token,
          form_options: {
            action: html_options['action'],
            method: method
          }
        )
    end

    html_options['enforce_utf8'] = html_options.delete('enforce_utf8') { true }

    html_options
  end

  private

  def pack_names(type)
    names =
      ['app', controller_path, "#{controller_path}/#{action_name}"].map do |name|
        next unless Webpacker.manifest.lookup(name_with_extension(name, type))
        name
      end

    names.compact
  end

  def name_with_extension(name, type)
    "#{name}#{compute_asset_extname(name, type: type)}"
  end

  def token(token = nil, form_options: {})
    return nil unless token != false && protect_against_forgery?

    {
      name: request_forgery_protection_token.to_s,
      value: form_authenticity_token(form_options: form_options)
    }
  end
end
