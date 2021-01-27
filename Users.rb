require_relative 'QuestionsDatabase'

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

end