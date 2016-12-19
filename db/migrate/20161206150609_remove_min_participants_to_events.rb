class RemoveMinParticipantsToEvents < ActiveRecord::Migration[5.0]
  def change
    remove_column :events, :min_participants
  end
end
