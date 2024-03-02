# encoding: utf-8

require 'roda'
require_relative '../config/database'
require_relative '../config/plugins'

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

Dir[File.expand_path('../../app/routes/**/*.rb', __FILE__)].each { |file| require file }
