require 'sequel'

class Cliente < Sequel::Model
  one_to_many :transacaos, key: :cliente_id
end
