require_relative '../controllers/cliente_controller'
require_relative '../controllers/transacao_controller'

module Clientes
  def self.routes(r)
    r.on Integer do |id|
      r.get "extrato" do
        result = ClienteController.extrato(id)
        if result.key?(:status)
          r.response.status = result[:status]
          result.delete(:status)
        end

        result.to_json
      end

      r.on 'transacoes' do
        r.post do
          result = TransacaoController.create(id, r.params)

          if result.key?(:status)
            r.response.status = result[:status]
            result.delete(:status)
          end

          result.to_json
        end
      end
    end
  end
end
