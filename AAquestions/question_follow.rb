require_relative "users"

class QuestionFollow

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM question_follows")
        data.map { |datum| QuestionFollow.new(datum) }
    end
    
    def initialize(options)
        @questions_id = options['questions_id']
        @users_id = options['users_id']
    end

    def self.followers_for_question_id(question_id)
        users = QuestionsDatabase.instance.execute(<<-SQL, question_id)
          SELECT 
            *
          FROM
            users
          JOIN 
            questions_follows ON users.id = question_follows.users_id
          JOIN
            replies ON question_follows.questions_id = replies.question_id
          WHERE
            questions_id = replies.question_id
        SQL
        return nil if user.length <= 0
        Users.new(user.first)
    end

    def self.followed_questions_for_user_id(user_id)
        questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
          SELECT 
            *
          FROM
            questions
          JOIN 
            questions_follows ON questions.id = question_follows.questions_id
          JOIN
            replies ON question_follows.questions_id = replies.question_id
          WHERE
            user_id = replies.author_id
        SQL
        return nil if questions.length <= 0
        Questions.new(questions.first)
    end

end