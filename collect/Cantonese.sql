CREATE TABLE words (
id			int,
chi_char	varchar(50),
pos			int,
roman		varchar(50),
sent_seq	int,
sent_num	int
);
CREATE TABLE sentence (
sent_num	int
);

CREATE TABLE pos (
pos_num		int,
pos_type	varchar(50)
);

ALTER TABLE Cantonese.cantonese MODIFY COLUMN chi_char VARCHAR(20)  
    CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL;