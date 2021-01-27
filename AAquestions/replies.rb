require_relative 'questions_database'
require_relative 'users'

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

    def self.find_by_author_id(author_id)
        reply = QuestionsDatabase.instance.execute(<<-SQL, author_id)
          SELECT 
            *
          FROM
            replies
          WHERE
            author_id  = ?
        SQL
        return nil if reply.length <= 0
        Replies.new(reply.first)
    end

    def self.find_by_question_id(question_id)
        reply = QuestionsDatabase.instance.execute(<<-SQL, question_id)
          SELECT 
            *
          FROM
            replies
          WHERE
            question_id  = ?
        SQL
        return nil if reply.length <= 0
        Replies.new(reply.first)
    end

    def self.find_by_parent_id(parent_id)
        reply = QuestionsDatabase.instance.execute(<<-SQL, parent_id)
          SELECT 
            *
          FROM
            replies
          WHERE
            parent_id  = ?
        SQL
        return nil if reply.length <= 0
        Replies.new(reply.first)
    end

    def author
        Users.find_by_id(self.author_id)
    end

    def question
        Questions.find_by_id(self.question_id)
    end

    def parent_reply
        Replies.find_by_id(self.parent_id)
    end

    def child_replies
        Replies.find_by_parent_id(self.id)
    end
end