require 'ffi-rzmq'
require 'concurrent'
require 'msgpack'
require 'convulse'
require 'timeout'
require 'singleton'
require 'securerandom'

# require 'classify'
require 'log4r'
require 'pathname'
require 'fileutils'

require "karibu_cli/version"
require "karibu_cli/logger"
require "karibu_cli/configuration"
require "karibu_cli/request"
require "karibu_cli/response"
require "karibu_cli/executor"
require "karibu_cli/future"
require "karibu_cli/client"

module KaribuCli
  # Your code goes here...
  def self.root
    Pathname.new(Dir.pwd)
  end

  def self.call(service, payload)
    raise "Start client before request anywhere in your initialization process: << KaribuCli.start! >>"
    resp = @client.call(service, payload)
    Future.get(resp)
  end

  def self.start!
    @client = Client.new
  end

  class << self
    attr_reader :client
  end
end
