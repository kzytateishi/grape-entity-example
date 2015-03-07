module API
  module V1
    class MessageBoards < Grape::API
      helpers do
        # Strong Parametersの設定
        def message_board_params
          ActionController::Parameters.new(params).permit(:title, :body)
        end

        def set_message_board
          @message_board = MessageBoard.find(params[:id])
        end

        # パラメータのチェック
        params :attributes do
          requires :title, type: String, desc: "MessageBoard title."
          optional :body, type: String, desc: "MessageBoard body."
        end

        # パラメータのチェック
        params :id do
          requires :id, type: Integer, desc: "MessageBoard id."
        end
      end

      resource :message_boards do
        desc 'GET /api/v1/message_boards'
        get '/' do
          @message_boards = MessageBoard.all
          # 定義したエンティティはAPI側で指定する。
          present @message_boards, with: Entity::V1::MessageBoardEntity
        end

        desc 'POST /api/v1/message_boards'
        params do
          use :attributes
        end
        post '/' do
          message_board = MessageBoard.new(message_board_params)
          message_board.save
        end

        desc 'GET /api/v1/message_boards/:id'
        params do
          use :id
        end
        get '/:id' do
          set_message_board
          present @message_board, with: Entity::V1::MessageBoardEntity
        end

        desc 'PUT /api/v1/message_boards/:id'
        params do
          use :id
          use :attributes
        end
        put '/:id' do
          set_message_board
          @message_board.update(message_board_params)
        end

        desc 'DELETE /api/v1/message_boards/:id'
        params do
          use :id
        end
        delete '/:id' do
          set_message_board
          @message_board.destroy
        end
      end
    end
  end
end
