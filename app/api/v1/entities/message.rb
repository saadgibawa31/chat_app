module V1

  module Entities 

    class Message < Grape::Entity

      expose :id
      expose :message
      expose :created_at
      expose :participant_id
      expose :user, using: Entities::User

    end

  end

end