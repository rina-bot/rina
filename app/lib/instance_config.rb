class InstanceConfig
  PATH = Rails.root + "config/instance.yml"

  @config = OpenStruct.new

  class << self
    delegate_missing_to :@config

    def url_host
      @config.url_host || ENV["HOST"] || "localhost"
    end

    # watch instance config file chagne and auto reload
    def watch
      @listener ||= Listen.to(
        File.dirname(PATH),
        only: /\A#{File.basename(PATH)}\z/
      ) do |modified, added, removed|
        next if modified.empty? && added.empty? && removed.empty?

        reload
      end

      @listener.start
    end

    def configured?
      File.exist? PATH
    end

    def reload
      @config = OpenStruct.new(YAML.safe_load(File.read(PATH)))

      Rails.application.routes.default_url_options.merge!(
        host: url_host,
        protocol: "https"
      )
    end

    def update(new_config)
      File.write PATH, YAML.dump(new_config.to_hash)
    end
  end
end
