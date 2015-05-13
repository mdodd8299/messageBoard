Sequel.migration do
  up do
    create_table(:posts) do
      primary_key :id
      String :content
      foreign_key :user_id
      foreign_key :topic_id
    end
  end

  down do
    drop_table(:posts)
  end
end