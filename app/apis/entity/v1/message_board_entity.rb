module Entity
  module V1
    class MessageBoardEntity < Grape::Entity
      # {"message_boards":[]}
      # {"message_board":{} }
      # というJSON出力になります。
      root 'message_boards', 'message_board'

      expose :id, :title, :body
      # 値を加工することができる。
      expose :updated_at do |message_baord, options|
        message_baord.updated_at.strftime("%Y-%m-%d %H:%M:%S")
      end

      # 他のEntityの定義を使うことができる。
      expose :comments, using: 'Entity::V1::CommentEntity'

      expose(:comment_count) do |message_board|
        message_board.comments.count(:id)
      end
    end
  end
end
