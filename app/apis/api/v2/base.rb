module API
  module V2
    class Base < Grape::API
      format :json
      default_format :json

      prefix 'api' # /apiというパスになる
      version 'v2', using: :path # /api/v2というパスになる

      rescue_from ActiveRecord::RecordNotFound do |e|
        rack_response({ message: e.message, status: 404 }.to_json, 404)
      end

      rescue_from Grape::Exceptions::ValidationErrors do |e|
        rack_response e.to_json, 400
      end

      rescue_from :all do |e|
        if Rails.env.development?
          raise e
        else
          rack_response({ message: e.message, status: 500 }.to_json, 500)
        end
      end

      mount V2::MessageBoards
      mount V2::Comments
    end
  end
end
