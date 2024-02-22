require 'sequel'

class Transacao < Sequel::Model
  many_to_one :cliente, key: :cliente_id
end
