BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "group" (
	"id"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	"name"	TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS "Match" (
	"match_id"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	"match_id_team_a"	INTEGER,
	"match_id_team_b"	INTEGER,
	"team_a"	TEXT,
	"team_b"	TEXT,
	"score"	TEXT,
	"match_date"	TEXT,
	"match_hour"	TEXT,
	"match_stadium"	TEXT,
	"group_id"	INTEGER
);
CREATE TABLE IF NOT EXISTS "TeamDetail" (
	"id"	INTEGER NOT NULL,
	"matches"	INTEGER,
	"won"	INTEGER,
	"drawn"	INTEGER,
	"lost"	INTEGER,
	"points"	INTEGER,
	"rank"	INTEGER,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "Team" (
	"id"	INTEGER NOT NULL,
	"name"	TEXT,
	"group_id"	INTEGER,
	"favorite"	INTEGER,
	PRIMARY KEY("id")
);
INSERT INTO "group" VALUES (1,'Group A');
INSERT INTO "group" VALUES (2,'Group B');
INSERT INTO "group" VALUES (3,'Group C');
COMMIT;
