require 'sequel'

DB = Sequel.connect(ENV['DATABASE_URL'] || 'postgres://paulao:segredosagrado@db/vempropau')

DB.create_table?(:seed_control) do
  primary_key :id
  String :script_name, unique: true, null: false
  DateTime :executed_at, null: false
end

clientes = [
  {id: 1, nome: "Bobby Tables", limite: 100000, saldo: 0},
  {id: 2, nome: "João Overflow", limite: 80000, saldo: 0},
  {id: 3, nome: "Arrayzilda dos Index", limite: 1000000, saldo: 0},
  {id: 4, nome: "Cássia Switcher", limite: 10000000, saldo: 0},
  {id: 5, nome: "Astolfo Rodolfo", limite: 500000, saldo: 0}
]

unless DB[:seed_control].where(script_name: 'clientes_seed').count > 0
  clientes.each do |cliente|
    unless DB[:clientes].where(id: cliente[:id]).count > 0
      DB[:clientes].insert(cliente)
    else
      puts "Client with ID #{client[:id]} already exists. Skipping..."
    end
  end

  DB[:seed_control].insert(script_name: 'clientes_seed', executed_at: Time.now)
else
  puts "Seed 'clients_seed' has already been executed."
end
