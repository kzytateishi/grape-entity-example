module API
  module V1
    class Base < Grape::API
      format :json
      default_format :json

      prefix :api # /apiというパスになる
      version 'v1', using: :path # /api/v1というパスになる

      rescue_from ActiveRecord::RecordNotFound do |e|
        rack_response({ message: e.message, status: 404 }.to_json, 404)
      end

      rescue_from Grape::Exceptions::ValidationErrors do |e|
        rack_response e.to_json, 400
      end

      rescue_from :all do |e|
          raise e
      end

      mount V1::MessageBoards
      mount V1::Comments
    end
  end
end
