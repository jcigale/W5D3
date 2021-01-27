require_relative 'QuestionsDatabase'

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

end