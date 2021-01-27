require_relative 'QuestionsDatabase'


class Replies
    attr_accessor :id, :question_id, :author_id, :parent_id, :body

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM replies")
        data.map { |datum| Replies.new(datum) }
    end

    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @author_id = options['author_id']
        @parent_id = options['parent_id']
        @body = options['body']
    end

    def self.find_by_id(id)
        reply = QuestionsDatabase.instance.execute(<<-SQL, id)
          SELECT 
            *
          FROM
            replies
          WHERE
            id  = ?
        SQL
        return nil if reply.length <= 0
        Replies.new(reply.first)
    end
end