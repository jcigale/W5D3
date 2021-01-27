PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL
);

CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    author_id INTEGER NOT NULL,
    title TEXT NOT NULL,
    body TEXT,
    
    FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
    questions_id INTEGER,
    users_id INTEGER,

    FOREIGN KEY (questions_id) REFERENCES questions(id)
    FOREIGN KEY (users_id) REFERENCES users(id)
);

CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    author_id INTEGER NOT NULL,
    parent_id INTEGER,
    body TEXT NOT NULL,
    
    FOREIGN KEY (question_id) REFERENCES questions(id)
    FOREIGN KEY (author_id) REFERENCES users(id)
    FOREIGN KEY (parent_id) REFERENCES replies(id)
);

CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    liker_id INTEGER NOT NULL,

    FOREIGN KEY (question_id) REFERENCES questions(id)
    FOREIGN KEY (liker_id) REFERENCES users(id)
);

INSERT INTO 
    users(fname, lname)
VALUES 
    ('Tom', 'Smith'),
    ('John', 'Cigale'),
    ('Marco', 'Torre'),
    ('Karen', 'McKaren');

INSERT INTO
    questions(title, body, author_id)
VALUES  
    ('John''s question', 'Someone please tell me why the sky is blue?', (SELECT id FROM users WHERE fname = 'John' AND lname = 'Cigale')),
    ('Karen''s question', 'What is bit coin?', (SELECT id FROM users WHERE fname = 'Karen' AND lname = 'McKaren'));

INSERT INTO
    replies(question_id, author_id, parent_id, body)
VALUES
    ((SELECT id FROM questions WHERE id = 2), (SELECT id FROM users WHERE id = 3), NULL, 'stfu karen'),
    ((SELECT id FROM questions WHERE id = 2), (SELECT id FROM users WHERE id = 4), 1, 'im calling the cops on you');



