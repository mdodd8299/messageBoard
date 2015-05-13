Sequel.migration do
  up do
    alter_table(:posts) do
      add_column :time, Time
    end
  end

  down do
    alter_table(:posts) do
      drop_column :time
    end
  end
end