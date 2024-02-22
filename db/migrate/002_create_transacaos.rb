Sequel.migration do
  up do
    run "CREATE TYPE tipo_transacao AS ENUM ('c', 'd');"

    create_table(:transacaos) do
      primary_key :id
      foreign_key :cliente_id, :clientes, null: false
      Integer :valor, null: false
      column :tipo, :tipo_transacao, null: false, default: 'c'
      String :descricao, size: 255, null: false
      DateTime :realizada_em, null: false, default: Sequel::CURRENT_TIMESTAMP
      DateTime :updated_at, default: Sequel::CURRENT_TIMESTAMP
    end

    run <<-SQL
      CREATE OR REPLACE FUNCTION update_updated_at_column()
      RETURNS TRIGGER AS $$
      BEGIN
        NEW.updated_at = NOW();
        RETURN NEW;
      END;
      $$ LANGUAGE plpgsql;
    SQL

    run <<-SQL
      CREATE TRIGGER set_transacaos_updated_at
      BEFORE UPDATE ON transacaos
      FOR EACH ROW
      EXECUTE FUNCTION update_updated_at_column();
    SQL
  end

  down do
    drop_table(:transacaos)
    run "DROP TRIGGER IF EXISTS set_transacaos_updated_at ON transacaos;"
    run "DROP FUNCTION IF EXISTS update_updated_at_column;"
    run "DROP TYPE tipo_transacao;"
  end
end
