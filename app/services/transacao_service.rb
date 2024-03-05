require_relative '../models/transacao'
require_relative '../models/cliente'

class TransacaoService
  def self.create_transacao(cliente_id, params)
    cliente = Cliente[cliente_id]
    return { error: 'Cliente not found', status: 404 } unless cliente

    unless valid?(params)
      return { error: 'Invalid parameters', status: 422 }
    end

    valor = params['valor'].to_i
    tipo = params['tipo']
    descricao = params['descricao']

    novo_saldo = calcular_novo_saldo(cliente, valor, tipo)
    if saldo_insuficiente?(cliente, novo_saldo, tipo)
      return { error: 'Saldo insuficiente', status: 422 }
    end

    transacao = Transacao.new(cliente_id: cliente_id, valor: valor, tipo: tipo, descricao: descricao)
    if transacao.save
      cliente.update(saldo: novo_saldo)
      { limite: cliente.limite, saldo: cliente.saldo, status: 200 }
    else
      { error: 'Failed to create transacao', status: 500 }
    end
  end

  private

  def self.valid?(params)
    valor = params['valor']
    tipo = params['tipo']
    descricao = params['descricao']

    valor_positivo_inteiro = valor.is_a?(Integer) && valor.positive?
    valor_positivo_inteiro ||= valor.is_a?(String) && valor.match?(/\A\d+\z/) && valor.to_i.positive?
  
    valor_positivo_inteiro && %w[c d].include?(tipo) && descricao && descricao.length.between?(1, 10)
  end

  def self.calcular_novo_saldo(cliente, valor, tipo)
    tipo == 'd' ? cliente.saldo - valor : cliente.saldo + valor
  end

  def self.saldo_insuficiente?(cliente, novo_saldo, tipo)
    tipo == 'd' && novo_saldo < cliente.limite * -1
  end
end
