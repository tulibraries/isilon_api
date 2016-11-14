require 'json'
require 'csv'
require 'stringio'
require 'isilon_api'
require 'pry'

module IsilonApi
  module Report

    @@isilon_total_size = 1.0E+15
    @@default_scale_factor = 1.0E+6

    def self.initialize (csv_filename)
      @config = IsilonApi.configuration
      @units = @config.units ? @config.units : 'mb'
      @csv_file = CSV.open(csv_filename, 'wb')

      magnitude_table={'mb' => 1.0E+6,
                       'gb' => 1.0E+9,
                       'tb' => 1.0E+12,
                       'pb' => 1.0E+15}
      @scale_factor = magnitude_table.include?(@units) ? magnitude_table[@units] : @default_scale_factor 

      @conn = IsilonApi::Base.new.connection
      @isilon_conn = IsilonApi::Quotas.new @conn
    end

    def self.header(csv_file)
      quotas_header = [
        "name",
        "path",
        "usage (#{@units})",
        "free (#{@units})",
        "soft quota (#{@units})",
        "hard quota (#{@units})",
        "precentage used",
        "hard limit (%)"
      ]
      csv_file << quotas_header
    end

    def self.to_array (quotas, scale_factor = @@default_scale_factor)
      quotas_array =  [quotas.name]
      quotas_array << quotas.path
      quotas_array << (Float(quotas.usage) / scale_factor).round(2)
      quotas_array << (Float(quotas.free_space) / scale_factor).round(2)
      quotas_array << (Float(quotas.soft_limit) / scale_factor).round(2)
      quotas_array << (Float(quotas.hard_limit) / scale_factor).round(2)
      quotas_array << (Float(quotas.percent_used) * 100.0).round(2)
      quotas_array << (Float(quotas.usage) / @@isilon_total_size).round(2)

      return quotas_array
    end

    def self.generate_csv(csv_filename)
      initialize(csv_filename)
      header(@csv_file)
      raw = JSON.parse(@isilon_conn.request_quotas.body)["quotas"]
      raw.each_with_index do |share_quota, i|
        quota = IsilonApi::Quota.new :quota => share_quota
        @csv_file << to_array(quota, @scale_factor)
      end
    end

  end
end
