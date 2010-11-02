module LocalCDN
  class Config

    def initialize
      @urls = YAML.load_file("#{Rails.root}/config/cdn.yml")
    end

    def urls
      @urls
    end
  end
end
