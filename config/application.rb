require 'roda'
require_relative '../config/database'

Encoding.default_internal = Encoding::UTF_8
Encoding.default_external = Encoding::UTF_8

Dir['./models/**/*.rb'].each { |file| require file }
