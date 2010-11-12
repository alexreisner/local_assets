module LocalCDN
  class Config
    attr_reader :urls

    def initialize
      @urls = {}
      @urls[:remote] = YAML.load_file(file_path(:remote))
      if File.exist?(f = file_path(:local))
        @urls[:local] = YAML.load_file(f)
      end
    end

    def file_path(local_or_remote)
      File.join Rails.root, "config", "cdn.#{local_or_remote}.yml"
    end
  end
end
