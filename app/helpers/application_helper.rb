module ApplicationHelper

  # SEO Tags

  def title(text)
    content_for :title, text
  end

  def description(text)
    content_for :description, text
  end

  # End of SEO tags

  def sortable(column, title = nul)
    title ||= column.titleize
    direction = column == params[:sort] && params[:direction] == 'asc' ? 'desc' : 'asc'

    if column == params[:sort]
      css = direction == 'asc' ? '<i class="align-middle me-2 fas fa-fw fa-long-arrow-alt-up"></i>' : '<i class="align-middle me-2 fas fa-fw fa-long-arrow-alt-down"></i>'
    else
      css = ""
    end

    # css = direction == 'asc' ? '<i class="align-middle me-2 fas fa-fw fa-long-arrow-alt-down"></i>' : '<i class="align-middle me-2 fas fa-fw fa-long-arrow-alt-up"></i>'

    link_to (title.html_safe + css.html_safe), sort: column, direction: direction
  end

  def site_sortable(column, title = nul, query, category_id)
    title ||= column.titleize
    direction = column == params[:sort] && params[:direction] == 'asc' ? 'desc' : 'asc'

    if column == params[:sort]
      css = direction == 'asc' ? '<i class="align-middle me-2 fas fa-fw fa-long-arrow-alt-up"></i>' : '<i class="align-middle me-2 fas fa-fw fa-long-arrow-alt-down"></i>'
    else
      css = ""
    end

    # css = direction == 'asc' ? '<i class="align-middle me-2 fas fa-fw fa-long-arrow-alt-down"></i>' : '<i class="align-middle me-2 fas fa-fw fa-long-arrow-alt-up"></i>'

    link_to (title.html_safe + css.html_safe), sort: column, direction: direction, query: query, search_category: category_id
  end

  def text_to_short(text)
    !text.nil? && text.body.to_s.length > 30 ? text.body.to_s.truncate(30) : text.body
  end

  def currency_options(currency)
    {
      pyg: { unit: '₲', separator: ',', delimiter: '.', precision: 0 },
      usd: { unit: '$', separator: '.', delimiter: ',', precision: 2 }
    }.fetch(currency.to_sym, { unit: currency.to_s, separator: '.', delimiter: ',', precision: 2 })
  end

  def money(amount, currency = :pyg)
    currency = :pyg if %w[₲ gs pyg].include? currency.to_s.strip.downcase
    currency = :usd if %w[$ usd].include? currency.to_s.strip.downcase
    number_to_currency(amount, currency_options(currency))
  end

  def generic_active(active)
    if active
      '<span class="badge badge-success-light"> <i class="mdi mdi-arrow-bottom-right"></i> Sí </span>'.html_safe
    else
      '<span class="badge badge-danger-light"> <i class="mdi mdi-arrow-bottom-right"></i> No </span>'.html_safe
    end
  end

  def link_to_add_row(name, f, association, **args)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize, f: builder)
    end
    link_to(name, '#', class: 'add_fields ' + args[:class], data: { id: id, fields: fields.gsub("\n", "") })
  end

  def link_to_add_row2(name, f, association, **args)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize, f: builder)
    end
    link_to(name, '#', class: 'add_fields2 ' + args[:class], data: { id: id, fields: fields.gsub("\n", "") })
  end

  def py_date(date)
    date.strftime('%d/%m/%Y %H:%M:%S')
  rescue StandardError
    ''
  end

  def py_date_only(date)
    date.strftime('%d/%m/%Y')
  rescue StandardError
    ''
  end

  def image_or_video_tag(attachment, options = {})
    return if attachment.is_a?(ActiveStorage::Attached::One) && !attachment.attached?

    if attachment.content_type.include?('image')
      image_tag(attachment, options)
    else
      options = { controls: false, loop: true, muted: true }.merge(options)
      video_tag("#{rails_blob_url(attachment)}?#{Time.now.to_i}", options)
    end
  end

  def map_icons(name)
    {
      position: 'sort-amount-down',
      link: 'external-link-alt',
      status: 'flag',
      date: 'calendar-alt',
      text: 'text-height'
    }.fetch(name, name.to_s)
  end

  def icon(name, type = :awesome, options = {})
    name = map_icons(name) if name.is_a?(Symbol)
    solid = options.delete(:solid)
    options[:class] = "#{options[:class]} #{solid ? 'fas' : 'fa'} fa-#{name.strip}".strip if type == :awesome
    options[:data] ||= {}
    options[:data][:feather] = name if type == :feather
    content_tag(:i, nil, options)
  end

  def fa(name, options = {})
    icon(name, :awesome, options)
  end

  def feather(name, options = {})
    icon(name, :feather, options)
  end

  def remove_stop_words(search_term)
    words = search_term.downcase.split
    words - STOP_WORDS
  end

  def normalize_string(string)
    string.unicode_normalize(:nfkd).gsub(/[^a-zA-Z0-9]/, '').downcase
  end

  def price_query?(query)
    query = query.split.map { |word| normalize_string(word) }
    (query.include?('cuanto') && query.include?('esta')) ||
      (query.include?('cuanto') && query.include?('sale')) ||
      query.include?('cuesta') ||
      query.include?('precio') ||
      query.include?('costo')
  end

  def strftime(time, format = :default)
    time.strftime(t(format, scope: 'time.formats')) if time.present? && time.respond_to?(:strftime)
  end

  def message_type(type)
    case type
    when 'success', 'notice' then 'success'
    when 'alert', 'error' then 'error'
    when 'warning' then 'warning'
    else 'info'
    end
  end

  def alert_type(type)
    case type
    when 'success', 'notice' then 'success'
    when 'alert', 'error' then 'danger'
    when 'warning' then 'warning'
    else 'info'
    end
  end

  def time_duration(milliseconds)
    if milliseconds < 1000
      "#{milliseconds}ms"
    elsif milliseconds < 60_000
      "#{(milliseconds / 1000.0).round(2)}s"
    else
      "#{(milliseconds / 60_000.0).round(2)}m"
    end
  end

  def response_code(response_code)
    badge_class = [200, 201, 204].include?(response_code.to_i) ? 'bg-success' : 'bg-danger'
    content_tag(:span, response_code, class: "badge #{badge_class}")
  end

  def pretty_json(data)
    JSON.pretty_generate(JSON.parse(data)).html_safe # rubocop:disable Rails/OutputSafety
  rescue StandardError => e
    Rails.logger.error(e)
    data
  end

end
