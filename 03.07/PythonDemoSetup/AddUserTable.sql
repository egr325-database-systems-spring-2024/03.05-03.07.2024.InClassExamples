USE ap;

DROP TABLE IF EXISTS users;

CREATE TABLE users
(
	username		VARCHAR(50)		PRIMARY KEY,
    password		VARCHAR(50)
);

INSERT INTO users VALUES
('haki', 'password1'),
('ran', 'password2'),
('joe', 'password3'),
('sam', 'password4'),
('admin', 'password5');