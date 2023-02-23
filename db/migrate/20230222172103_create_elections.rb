class CreateElections < ActiveRecord::Migration[7.0]

  # Create elections table
  def change
    create_table :elections do |t|
      t.string :name , index: { unique: true, name: 'unique_election_name' }
      t.string :election_day
      t.string :division
      t.timestamps
    end

    # Create representatives table 
    create_table :representatives do |t|
      t.string :name , index: { unique: true, name: 'unique_representative_name' }
      t.references :election, index: true, foreign_key: true
      t.string :party
      t.string :phone
      t.timestamps
    end
  end
end
