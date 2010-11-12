require 'config'

module LocalCDN

  ##
  # Render a stylesheet link tag.
  # Uses local copy in development mode, CDN otherwise.
  #
  def cdn_stylesheet_link_tag(cdn, file)
    cdn_include_tag(:stylesheet, cdn, file)
  end

  ##
  # Render a JavaScript include tag.
  # Uses local copy in development mode, CDN otherwise.
  #
  def cdn_javascript_include_tag(cdn, file)
    cdn_include_tag(:javascript, cdn, file)
  end


  private # -----------------------------------------------------------------

  ##
  # The CDN configuration object (based on user config files).
  #
  def cdn_config
    if defined?(@config)
      @config
    else
      @config = LocalCDN::Config.new
    end
  end

  ##
  # Get the URL of the named CDN.
  # URLs are specified in the local_cdn config files.
  #
  def cdn_url(name)
    urls = cdn_config.urls
    if local_request? and locals = urls[:local] and url = locals[name.to_s]
      url
    else
      if remotes = urls[:remote][name.to_s]
        remotes
      else
        raise MissingCDN, name
      end
    end
  end

  ##
  # Render a stylesheet or JavaScript include tag.
  #
  def cdn_include_tag(type, cdn, file)
    method = type == :javascript ? :javascript_include_tag : :stylesheet_link_tag
    send(method, cdn_url(cdn) + file)
  end

  ##
  # Are we in the development environment and on localhost?
  #
  def local_request?
    Rails.env == "development" and (
      request.server_name =~ /local/ or request.server_name == '127.0.0.1'
    )
  end

  ##
  # Are we on Rails 3 or using the rails_xss plugin?
  #
  def rails_3?
    String.instance_methods.include?("html_safe?")
  end

  ##
  # Exception class, for when the specified CDN has not been defined.
  #
  class MissingCDN < NameError
    def initialize(cdn)
      super "Expected the CDN '#{cdn}' to be defined in the cdn.remote.yml config file"
    end
  end
end

ActionView::Base.send(:include, LocalCDN)
