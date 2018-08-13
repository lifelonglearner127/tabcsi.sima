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

  def extra_form_tags(model: nil, url: nil, format: nil, **options)
    if model
      url ||= polymorphic_path(model, format: format)

      model = model.last if model.is_a?(Array)
    end

    html_options = html_options_for_form_with(url, model, options)

    extra_tags_for_form(html_options)
  end

  private

  def pack_names(type)
    names =
      [controller_path, "#{controller_path}/#{action_name}"].map do |name|
        next unless Webpacker.manifest.lookup(name_with_extension(name, type))
        name
      end

    names.compact
  end

  def name_with_extension(name, type)
    "#{name}#{compute_asset_extname(name, type: type)}"
  end
end
