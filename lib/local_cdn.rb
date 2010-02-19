module LocalCDN

	##
	# Render a stylesheet link tag for an array of YUI stylesheets. Uses local
	# copy in development mode, Yahoo CDN otherwise. Takes an array of
	# (relative) stylesheet URLs. For example:
	# 
	#   <%= yui_stylesheet_link_tag \
  #     "2.7.0/build/reset-fonts-grids/reset-fonts-grids.css",
  #     "2.7.0/build/base/base-min.css",
  #     "2.7.0/build/container/assets/container-core.css",
  #     "2.7.0/build/tabview/assets/tabview-core.css" %> 
	#
	def yui_stylesheet_link_tag(*files)
	  if development?
	    out = files.map{ |f|
	      stylesheet_link_tag(local_base_yui_url + f)
	    }.join("\n")
    else
      base_url = "http://yui.yahooapis.com/combo?"
	    out = stylesheet_link_tag(base_url + files.join("&"))
    end
    rails_3?? out.html_safe : out
	end
	
	##
	# Render a javascript include tag for an array of YUI scripts. Uses local
	# copy in development mode, Yahoo CDN otherwise. Takes an array of
	# (relative) script URLs. For example:
	# 
  #   <%= yui_javascript_include_tag \
  #     "2.7.0/build/yahoo-dom-event/yahoo-dom-event.js",
  #     "2.7.0/build/dragdrop/dragdrop-min.js",
  #     "2.7.0/build/container/container-min.js" %>
	#
	def yui_javascript_include_tag(*files)
	  if development?
	    out = files.map{ |f|
	      javascript_include_tag(local_base_yui_url + f)
	    }.join("\n")
    else
      base_url = "http://yui.yahooapis.com/combo?"
	    out = javascript_include_tag base_url + files.join("&")
    end
    rails_3?? out.html_safe : out
	end
	
	##
	# Render a Prototype include tag. Uses local copy in development mode,
	# Google CDN otherwise.
	#
	def prototype_include_tag
	  out = javascript_include_tag(development?? "prototype" :
      "http://ajax.googleapis.com/ajax/libs/prototype/1.6.0.3/prototype.js")
    rails_3?? out.html_safe : out
	end
  
	##
	# Render a Scriptaculous include tag. Uses local copy in development mode,
	# Google CDN otherwise.
	#
	def scriptaculous_include_tag(*files)
	  unless development?
	    files.map! do |f|
	      "http://ajax.googleapis.com/ajax/libs/scriptaculous/1.8.1/#{f}.js"
	    end
	  end
	  out = javascript_include_tag(*files)
    rails_3?? out.html_safe : out
	end
	
	
	private # -----------------------------------------------------------------
	
	##
	# Are we in the development environment?
	#
	def development?
	  Rails.env == "development"
	end
	
	##
	# Base URL for the local YUI installation.
	#
	def local_base_yui_url
	  "http://#{request.host}/yui/"
	end
	
	##
	# Are we on Rails 3?
	#
	def rails_3?
	  Rails.version[0...1] == "3"
	end
end
