module ApplicationHelper
  def link_to_object(object, options = {})
    return if object.blank?
    _module = options.delete(:module)
    property = %w[name_for_link_to name id to_s].find { |property| object.respond_to?(property) && object.send(property).present? }
    link_to(object.send(property), [_module].flatten.compact.map(&:to_s).map(&:downcase) + [object], options)
  end

  def link_to_count(records, options = {})
    return if records.empty?
    link_to_if(can?(:show, records), records.count, controller: 'admin/' + records.klass.name.downcase.pluralize.gsub('::', '/'), where: { records.proxy_association.reflection.foreign_key => records.proxy_association.owner.id })
  end

  def can?(action, object)
    @current_user.try(:admin_user)
  end

  def model
    @model ||= self.controller.send(:model)
  end

  def text_format(text)
    simple_format(auto_link(h(text)))
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
end
