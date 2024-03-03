class ExtratoService
  def initialize(cliente)
    @cliente = cliente
  end

  def gerar_extrato
    transacoes = Transacao.where(cliente_id: @cliente.id).order(Sequel.desc(:realizada_em)).limit(10)

    saldo_total = @cliente.saldo
    limite = @cliente.limite
    data_extrato = Time.now

    {
      saldo: {
        total: saldo_total,
        data_extrato: data_extrato.iso8601(6),
        limite: limite
      },
      ultimas_transacoes: transacoes.map do |transacao|
        {
          valor: transacao.valor,
          tipo: transacao.tipo,
          descricao: transacao.descricao,
          realizada_em: transacao.realizada_em.iso8601(6)
        }
      end
    }
  end
end
