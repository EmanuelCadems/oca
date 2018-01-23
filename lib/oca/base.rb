#encoding=utf-8
require 'httparty'
require 'json'
require 'active_support/core_ext/hash'

class Oca::Base
  include HTTParty
  include ActiveModel::Validations

  base_uri "webservice.oca.com.ar"

  headers "Accept-Encoding" => "gzip,deflate"
  headers "Content-Type" => "application/soap+xml;charset=UTF-8"

  attr_reader :usr, :pwd

  validates :usr, :pwd, presence: true

  def initialize(options = {})
    @usr = options[:usr] || ENV['OCA_EMAIL']
    @pwd = options[:pwd] || "<![CDATA[#{ENV['OCA_PASSWORD']}]]>"
  end

end

