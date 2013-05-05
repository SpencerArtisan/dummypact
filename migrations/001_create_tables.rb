Sequel.migration do
  up do
    create_table :policies do
      primary_key :id
      Int :annualPremium
      String :status
    end

    create_table :policy_holders do
      primary_key :id
      String :assocUid
      foreign_key :policy_id, :policies
    end

    create_table :vehicles do
      primary_key :id
      String :registration
    end
  end

  down do
    drop_table? :vehicles
    drop_table? :policy_holders
    drop_table? :policies
  end
end
