require_relative '../services/transacao_service'

class TransacaoController
  # CREATE
  def self.create(cliente_id, params)
    TransacaoService.create_transacao(cliente_id, params)
  end
end
