Sequel.migration do
  up do
    create_table(:clientes) do
      primary_key :id
      String :nome, size: 255, null: false
      Integer :limite, null: false
      Integer :saldo, null: false, default: 0
      DateTime :created_at, default: Sequel::CURRENT_TIMESTAMP
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
      CREATE TRIGGER set_clientes_updated_at
      BEFORE UPDATE ON clientes
      FOR EACH ROW
      EXECUTE FUNCTION update_updated_at_column();
    SQL
  end

  down do
    drop_table(:clientes)

    run "DROP TRIGGER IF EXISTS set_clientes_updated_at ON clientes;"
    run "DROP FUNCTION IF EXISTS update_updated_at_column;"
  end
end
