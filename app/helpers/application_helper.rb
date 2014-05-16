module ApplicationHelper
  def link_to_object(object, options = {})
    return if object.blank?
    _module = options.delete(:module)
    name_method = %w[name_for_link_to name id to_s].find { |property| object.respond_to?(property) && object.send(property).present? }
    return link_to(object.send(name_method), [_module].flatten.compact.map(&:to_s).map(&:downcase) + [object], options) if object.is_a?(ActiveRecord::Base)
    path_method = %w[url_for_link_to path_for_link_to url path to_s].find { |property| object.respond_to?(property) && object.send(property).present? }
    link_to(object.send(name_method), object.send(path_method), options)
  end

  def link_to_admin(object)
    link_to_object(object, module: Admin) if defined? Admin
  end

  def link_to_business(object)
    link_to_object(object, module: Business)
  end

  def link_to_admin_count(records, options = {})
    return if records.empty?
    link_to_if(can?(:show, records), records.count, controller: 'admin/' + records.klass.name.downcase.pluralize.gsub('::', '/'), where: { records.proxy_association.reflection.foreign_key => records.proxy_association.owner.id })
  end

  def link_to_count(records, options = {})
    link_to_admin_count(records, options)
  end

  def link_to_business_count(records, options = {})
    return if records.empty?
    link_to records.count, controller: 'business/' + records.klass.name.downcase.pluralize.gsub('::', '/'), where: { records.proxy_association.reflection.foreign_key => records.proxy_association.owner.id }
  end

  def boolean_tag(value)
    content_tag(:span, value ? '✔' : '✘')
  end

  def can?(action, object)
    @current_user.try(:admin_user)
  end

  def model
    @model ||= self.controller.send(:model)
  end

  def text_format(text)
    simple_format(auto_link(h(text).gsub(' ', '&nbsp;')))
  end

  def sanitize_format(text)
    sanitize(text, tags: %w[ h1 h2 h3 h4 h5 h6 p div blockquote ol ul li span img a], attributes: %w[ style src alt href target height width ])
  end

  def t(key, options = {})
    # If the user has specified rescue_format then pass it all through, otherwise use
    # raise and do the work ourselves
    options[:raise] = true unless options.key?(:raise) || options.key?(:rescue_format)
    if html_safe_translation_key?(key)
      html_safe_options = options.dup
      options.except(*I18n::RESERVED_KEYS).each do |name, value|
        unless name == :count && value.is_a?(Numeric)
          html_safe_options[name] = ERB::Util.html_escape(value.to_s)
        end
      end
      translation = I18n.translate(scope_key_by_partial(key), html_safe_options)

      translation.respond_to?(:html_safe) ? translation.html_safe : translation
    else
      I18n.translate(scope_key_by_partial(key), options)
    end
  rescue I18n::MissingTranslationData => e
    keys = I18n.normalize_keys(e.locale, e.key, e.options[:scope])
    keys.last.to_s.titleize
  end

  def inventories_calendar
    calendar(:year => @date.year,
             :month => @date.month,
             :show_today => true,
             :first_day_of_week => 1,
             :previous_month_text => link_to('<<', business_travel_inventories_path(params.merge(date: @date - 1.month))),
             :next_month_text => link_to('>>', business_travel_inventories_path(params.merge(date: @date + 1.month))),
             :calendar_title => "#{@date.year}年#{@date.month}月",
             :table_class => 'calendar inventories_calendar inventories-calendar',
             :table_id => "inventories-#{@date.year}-#{"%02d" % @date.month}",
            ) do |day|
              inventorie = @inventories.find_by(started_on: day)
              available = inventorie.present?
              passed = available && inventorie.started_on < Time.now.to_date
              inventorie_html = available ? "<div class='inventories-day inventories_day #{available}'><p><label>库存:</label><span>#{inventorie.total_number.to_i - inventorie.remained_number.to_i}</span></p><p><label>成人价:</label><span>#{inventorie.adult_price.to_i}</span></p><p><label>儿童价:</label><span>#{inventorie.child_price.to_i}</span></p></div>" : ""
              day_html = "<div class='day'>#{day.day}</div>"
              [inventorie_html+day_html,
                {
                  :'data-inventorie-id' => inventorie.try(:id),
                }
              ]
            end
  end
end
