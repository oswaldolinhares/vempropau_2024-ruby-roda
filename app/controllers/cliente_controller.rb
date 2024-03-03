require_relative '../models/cliente'
require_relative '../services/extrato_service'

class ClienteController
  # EXTRATO
  def self.extrato(id)
    cliente = Cliente[id: id]

    if cliente
      dados_extrato = ExtratoService.new(cliente).gerar_extrato
      
      dados_extrato.merge({status: 200})
    else
      { error: 'Cliente not found', status: 404 }
    end
  end
end
