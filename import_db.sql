PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL,
);

DROP TABLE IF IF EXISTS questions;

CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    author_id INTEGER NOT NULL,
    title TEXT NOT NULL,
    body TEXT,
    
    FOREIGN KEY (author_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_follows;

CREATE TABLE question_follows (
    questions_id INTEGER,
    users_id INTEGER,
);

DROP TABLE IF IF EXISTS replies;

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

DROP TABLE IF IF EXISTS question_likes;

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
    ('John', 'Cigale');

INSERT INTO
    questions(title, body, author_id)
VALUES  
    ('Why is the sky blue?', 'Someone please tell me why the sky is blue?', (SELECT id FROM users WHERE fname = 'John' AND lname = 'Cigale'));

