module IsilonApi
  class << self
    attr_accessor :configuration
  end

  def self.configure()
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :user, :password, :host, :port, :units

    def initialize
      @user     = 'example_user'
      @password = '3x4mpl3_p4$$w0rd'
      @host     = 'isilon.example.com'
      @port     = '8080'
    end

  end
end
