class AddParticipantsToMessages < ActiveRecord::Migration[7.2]
  def change
    add_reference :messages, :participant, foreign_key: true, null: false  

    Message.update_all(participant_id: '1')
  end
end
