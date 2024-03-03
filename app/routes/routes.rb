require_relative 'clientes'

class Routes
  def self.register(r)
    r.response['Content-Type'] = 'application/json; charset=utf-8'

    r.root do
      { message: 'API up at /api/v1' }.to_json
    end

    r.on 'clientes' do
      Clientes.routes(r)
    end

    r.on 'transacaos' do
      Transacaos.routes(r)
    end 

    r.get do
      { message: "API is up and running" }.to_json
    end
  end
end
