Sequel.migration do
  up do
    alter_table(:users) do
      add_column :date, Date
    end
  end

  down do
    alter_table(:posts) do
      drop_column :date
    end
  end
end