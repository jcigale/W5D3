require_relative 'questions_database'
require_relative 'questions'
require_relative 'replies'

class Users
    attr_accessor :id, :fname, :lname

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM users")
        data.map { |datum| Users.new(datum) }
    end

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end

    def self.find_by_id(id)
        user = QuestionsDatabase.instance.execute(<<-SQL, id)
          SELECT 
            *
          FROM
            users
          WHERE
            id  = ?
        SQL
        return nil if user.length <= 0
        Users.new(user.first)
    end

    def self.find_by_name(fname, lname)
        user = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
          SELECT 
            *
          FROM
            users
          WHERE
            fname  = ? AND lname = ?
         SQL
        return nil if user.length <= 0
        Users.new(user.first)
    end

    def authored_questions 
      Questions.find_by_author_id(self.id)
    end

    def authored_replies
      Replies.find_by_author_id(self.id)
    end

    def followed_questions
      QuestionFollows.followed_questions_for_user_id(self.id)
    end

  end