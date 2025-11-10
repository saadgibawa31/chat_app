module V1

  class Base < Grape::API
    prefix 'api'
    format :json
    version 'v1', using: :path

    helpers V1::Helpers::AuthHelper
    mount V1::Users
    mount V1::Sessions
    mount V1::Chats
    mount V1::Messages

  end

end