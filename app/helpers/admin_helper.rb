module AdminHelper

  def avatar_for(user)
    return if user.nil?

    user.image.attached? ? user.image : AdminUtils.avatar_for(user)
  end

  def page_title(title = nil)
    site_name = Rails.configuration.try :site_name || ''
    separator = Rails.configuration.try :title_site_name_separator || ''
    [title || default_page_title, site_name].join(" #{separator} ")
  end

  def default_page_title
    I18n.t(controller_name, scope: 'app.controllers', default: controller_name.titleize)
  end

  def per_page_options
    Set.new([10, 25, 50, 100])
  end

  def span_status(status, options = %w[Activo Inactivo])
    status = (status == 'activo') if status.is_a?(String)
    content_tag :span, status ? options.first : options.last, class: "badge badge-sm #{status ? 'bg-success' : 'bg-secondary'}"
  end

  def link_to_show(record, &block)
    content = block_given? ? capture(&block) : feather('eye')
    link_to(content, record, class: 'btn btn-link text-secondary mb-0 px-1 text-sm', title: 'Ver')
  end

  def link_to_edit(record)
    link_to(feather('edit'), polymorphic_url([:edit, record]), class: 'btn btn-link text-secondary mb-0 px-1 text-sm', title: 'Editar')
  end

  def link_to_delete(record)
    link_to(feather('trash'), record, method: :delete, data: { confirm: t('app.messages.confirm') }, title: 'Eliminar')
  end

  def current_controller?(paths)
    paths = Array(paths)
    current_controller = get_controller_from_path(request.path_info, request.method)
    paths.any? do |path|
      path_controller = get_controller_from_path(path)
      current_controller == path_controller
    end
  rescue StandardError
    false
  end

  def prepare_sidebar_options(options)
    default_options = {
      text: '',
      icon: nil,
      action: 'read',
      paths: nil,
      id: "dd-#{SecureRandom.hex(3)}"
    }
    options.reverse_merge(default_options)
  end

  def generate_sidebar_item(url, permissions, options = {}, &block)
    options = prepare_sidebar_options(options)
    options[:text] = t("app.controllers.#{options[:text]}") if options[:text].is_a?(Symbol)

    return unless permissions.nil? || authorized(permissions, options[:action])

    icon_html = content_tag(:i, '', class: "align-middle me-2 fas fa-fw fa-#{options[:icon]}") if options[:icon]
    child_active = current_controller?(options[:paths]) || (url == request.path)  # Check if the current item is active
    child_active = capture(&block).include?('class="sidebar-item active"') if block_given?
    item_class = child_active ? 'active' : ''

    # Add the data-bs-target attribute
    data_bs_target = block_given? ? "##{options[:id]}" : nil

    link_content = icon_html.to_s.html_safe + content_tag(:span, options[:text], class: 'align-middle')
    sidebar_link = link_to(url, class: "sidebar-link #{child_active ? '' : 'collapsed'}", data: { 'bs-toggle': (block_given? ? 'collapse' : nil), 'bs-target': data_bs_target }) do
      link_content
    end

    sidebar_content = sidebar_link + (block_given? ? generate_sidebar_dropdown(options[:id], child_active, capture(&block)) : ''.html_safe)
    content_tag(:li, sidebar_content, class: "sidebar-item #{item_class}")
  end


  def generate_sidebar_dropdown(id, active = false, content = nil)
    content_tag(:ul, content, id: id, class: "sidebar-dropdown list-unstyled collapse #{active ? ' show' : ''}")
  end

  def img_or_placeholder(image, options = {})
    variant_options = build_variant_options(options)
    if image.try(:attached?)
      image = image.first if image.is_a?(ActiveStorage::Attached::Many)
      image_variant = variant_options.present? ? image.variant(variant_options).processed : image
      image_tag(image_variant, options)
    else
      image_tag('/img/placeholder.jpg', options.reverse_merge(height: 70))
    end
  end

  private

  def build_variant_options(options)
    format = options.delete(:format)
    resize = options.delete(:resize) || {}
    transform = (resize.keys.select { |k| %i[pad limit fill].include?(k) }.first if resize.is_a?(Hash)) || :limit
    size = resize.is_a?(Hash) ? resize.fetch(transform, nil) : Array(resize)
    return {} unless size.is_a?(Array)

    {}.tap do |variant_options|
      variant_options[:convert] = format if format
      variant_options[:resize_to_limit] = [size.first, size.last] if transform == :limit
      variant_options[:resize_and_pad] = [size.first, size.last, { gravity: 'Center' }] if transform == :pad
      variant_options[:resize_to_fill] = [size.first, size.last, { gravity: 'Center' }] if transform == :fill
    end
  end

  def get_controller_from_path(path, method = nil)
    begin
      recognized_route = Rails.application.routes.recognize_path(path, method: method)
    rescue StandardError
      recognized_route = Rails.application.routes.recognize_path(path)
    end
    recognized_route[:controller]
  end

  def form_columns(title, options = {}, &block)
    content_tag(:div, class: 'row mb-3') do
      title = content_tag(:div, class: 'col-lg-4 mb-4') do
        title = content_tag(:h4, title, class: 'gl-mt-0 fw-bold')
        subtitle = (content_tag(:div, options[:subtitle], class: 'text-muted') if options[:subtitle])
        subtitle.present? ? title + subtitle : title
      end
      inputs = content_tag(:div, class: 'col-lg-8', &block)
      divider = content_tag(:div, content_tag(:hr, nil, class: 'border-top'), class: 'col-lg-12')
      title + inputs + divider
    end
  end

  def file_on_disk(active_storage)
    ActiveStorage::Blob.service.path_for(active_storage&.key)
  end

end
