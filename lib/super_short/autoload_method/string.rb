module SuperShort

  module AutoloadMethodString
    include AutoloadMethod

    autoload_method [
      :pluralize,
      :singularize,
      :constantize,
      :safe_constantize,
      :camelize,
      :camelcase,
      :titleize,
      :titlecase,
      :underscore,
      :dasherize,
      :demodulize,
      :deconstantize,
      :parameterize,
      :tableize,
      :classify,
      :humanize,
      :foreign_key
    ], 'active_support/core_ext/string/inflections'
    
  end
end