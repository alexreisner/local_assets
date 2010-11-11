module LocalCDN
  class Config
    attr_reader :urls

    def initialize
      @urls = {}
      @urls[:remote] = YAML.load_file("#{Rails.root}/config/cdn.remote.yml")
      if File.exist?(f = "#{Rails.root}/config/cdn.local.yml")
        @urls[:local] = YAML.load_file(f)
      end
    end
  end
end
