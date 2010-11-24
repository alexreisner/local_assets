module Rack # :nodoc:

  ##
  # Selectively modifies the application responses by filtering out those
  # URLs which you provide as keys to the translation table, with the
  # values you assign to them:
  #
  #     use LocalAssets, {
  #       'http://ajax.googleapis.com/ajax/libs/jquery/1.4.1/jquery.min.js' => '/javascripts/jquery.min.js'
  #     }
  # 
  # Optionally, you can define a block which should return the translation
  # hash.
  #
  #     use LocalAssets do |request|
  #       if request.get? && !params['external_assets']
  #         {'http://bad.url/' => '/new/local/path'}
  #       else
  #         {}
  #       end
  #     end
  #
  class LocalAssets
    def initialize(app, translations = {}, &block)
      @app = app
      @translations = block_given? ? block : translations
    end

    def call(env)
      filter_response(@app.call(env), Rack::Request.new(env))
    end


    ##
    # If the application response is a Success or Client Error response
    # (client error being 404, 422, etc), then modify the outbound result,
    # otherwise pass it through.
    #
    def filter_response(response, request)
      if response.first.to_s =~ /^(?:2|4)\d{2}$/
        new_body = filter_body(response.pop, request)
        response.push([new_body])
      else
        response
      end
    end
    private :filter_response

    def filter_body(body, request)
      body = body.body if body.respond_to?(:body)
      body = body.first if body.kind_of?(Array)
      body = body.to_s

      translations(request).each_pair do |external, local|
        body.gsub!(external, local)
      end

      body
    end
    private :filter_body

    def translations(request)
      @translations.respond_to?(:call) ?
        @translations.call(request) : @translations
    end
    private :translations

  end
end
