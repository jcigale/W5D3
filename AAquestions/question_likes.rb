require_relative 'questions_database'


class QuestionLikes
    attr_accessor :id, :question_id, :liker_id

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM question_likes")
        data.map { |datum| QuestionLikes.new(datum) }
    end

    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @liker_id = options['liker_id']
    end

    def self.find_by_id(id)
        q_like = QuestionsDatabase.instance.execute(<<-SQL, id)
          SELECT 
            *
          FROM
            question_likes
          WHERE
            id  = ?
        SQL
        return nil if q_like.length <= 0
        QuestionLikes.new(q_like.first)
    end
end