require_relative 'questions_database'
require_relative 'users'

class Questions
    attr_accessor :id, :author_id, :title, :body

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM questions")
        data.map { |datum| Questions.new(datum) }
    end

    def initialize(options)
        @id = options['id']
        @author_id = options['author_id']
        @title = options['title']
        @body = options['body']
    end

    def self.find_by_id(id)
        question = QuestionsDatabase.instance.execute(<<-SQL, id)
          SELECT 
            *
          FROM
            questions
          WHERE
            id  = ?
        SQL
        return nil if question.length <= 0
        Questions.new(question.first)
    end

    def self.find_by_title(title)
        question = QuestionsDatabase.instance.execute(<<-SQL, title)
          SELECT 
            *
          FROM
            questions
          WHERE
            title = ?
         SQL
        return nil if question.length <= 0
        Questions.new(question.first)
    end

    def self.find_by_author_id(author_id)
        question = QuestionsDatabase.instance.execute(<<-SQL, author_id)
          SELECT 
            *
          FROM
            questions
          WHERE
            author_id  = ?
        SQL
        return nil if question.length <= 0
        Questions.new(question.first)
    end

    def replies
        Replies.find_by_question_id(self.id)
    end

    def author
        Users.find_by_id(self.author_id)
    end

    def followed_questions
      QuestionFollows.followers_for_question_id(self.id)
    end

end