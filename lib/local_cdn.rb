module LocalCDN

	##
	# Render a stylesheet link tag for an array of YUI stylesheets. Uses local
	# copy in development mode, Yahoo CDN otherwise. Takes an array of
	# (relative) stylesheet URLs. For example:
	#
	#   <%= yui_stylesheet_link_tag \
  #       "2.7.0/build/reset-fonts-grids/reset-fonts-grids.css",
  #       "2.7.0/build/base/base-min.css",
  #       "2.7.0/build/container/assets/container-core.css",
  #       "2.7.0/build/tabview/assets/tabview-core.css" %> 
	#
	def yui_stylesheet_link_tag(*files)
	  if RAILS_ENV == 'development'
	    base_url = "http://localhost/yui/"
	    files.map{ |f| stylesheet_link_tag(base_url + f) }.join("\n")
    else
      base_url = "http://yui.yahooapis.com/combo?"
	    stylesheet_link_tag base_url + files.join('&')
    end
	end
	
	##
	# Render a javascript include tag for an array of YUI scripts. Uses local
	# copy in development mode, Yahoo CDN otherwise. Takes an array of
	# (relative) script URLs. For example:
	#
  #   <%= yui_javascript_include_tag \
  #       "2.7.0/build/yahoo-dom-event/yahoo-dom-event.js",
  #       "2.7.0/build/dragdrop/dragdrop-min.js",
  #       "2.7.0/build/container/container-min.js" %>
	#
	def yui_javascript_include_tag(*files)
	  if RAILS_ENV == 'development'
	    base_url = "http://localhost/yui/"
	    files.map{ |f| javascript_include_tag(base_url + f) }.join("\n")
    else
      base_url = "http://yui.yahooapis.com/combo?"
	    javascript_include_tag base_url + files.join('&')
    end
	end
	
	##
	# Render a Prototype include tag. Uses local copy in development mode,
	# Google CDN otherwise.
	#
	def prototype_include_tag
	  javascript_include_tag (RAILS_ENV == 'development') ? "prototype" :
      "http://ajax.googleapis.com/ajax/libs/prototype/1.6.0.3/prototype.js"
	end
  
	##
	# Render a Scriptaculous include tag. Uses local copy in development mode,
	# Google CDN otherwise.
	#
	def scriptaculous_include_tag
	  javascript_include_tag (RAILS_ENV == 'development') ?
	    ["effects", "controls", "dragdrop"] :
      "http://ajax.googleapis.com/ajax/libs/scriptaculous/1.8.1/scriptaculous.js"
	end
end
