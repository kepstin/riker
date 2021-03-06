INSERT INTO artist (id, gid, name, sort_name, artist_type, country) VALUES (1, 'e1719c24-118e-425b-8f94-954dcf583fb0', '40mP', '40mP', (SELECT id FROM artist_type WHERE name = 'Person'), (SELECT id FROM country WHERE iso_code = 'JP'));
INSERT INTO artist (id, gid, name, sort_name, begin_date_year, begin_date_month, begin_date_day, artist_type, gender) VALUES (2, '130d679a-9a92-4373-8348-0800b6b93a30', '初音ミク', 'Hatsune, Miku', 2007, 8, 31, (SELECT id FROM artist_type WHERE name = 'Other'), (SELECT id FROM gender WHERE name = 'Female'));
INSERT INTO artist (id, gid, name, sort_name, artist_type, gender, disambiguation) VALUES (3, 'ef46bbef-dba2-46e3-b534-1b44cbddf249', 'GUMI', 'GUMI', (SELECT id FROM artist_type WHERE name = 'Other'), (SELECT id FROM gender WHERE name = 'Female'), 'vocaloid');
INSERT INTO artist (id, gid, name, sort_name, artist_type, country) VALUES (4, '623ea50d-00c2-4576-8303-db088e84951d', '1640mP', '1640mP', (SELECT id FROM artist_type WHERE name = 'Group'), (SELECT id FROM country WHERE iso_code = 'JP'));

INSERT INTO artist_credit (id, name, artist_count) VALUES (1, '40mP', 1);
INSERT INTO artist_credit (id, name, artist_count) VALUES (2, '40mP feat. 初音ミク', 2);
INSERT INTO artist_credit (id, name, artist_count) VALUES (3, '40mP feat. GUMI', 2);
INSERT INTO artist_credit (id, name, artist_count) VALUES (4, '1640mP feat. 初音ミク', 2);
INSERT INTO artist_credit (id, name, artist_count) VALUES (5, '40mP feat. 初音ミク・GUMI', 3);

INSERT INTO artist_credit_name (artist_credit, position, artist, name, join_phrase) VALUES (1, 1, 1, '40mP', NULL);
INSERT INTO artist_credit_name (artist_credit, position, artist, name, join_phrase) VALUES (2, 1, 1, '40mP', ' feat. ');
INSERT INTO artist_credit_name (artist_credit, position, artist, name, join_phrase) VALUES (2, 2, 2, '初音ミク', NULL);
INSERT INTO artist_credit_name (artist_credit, position, artist, name, join_phrase) VALUES (3, 1, 1, '40mP', ' feat. ');
INSERT INTO artist_credit_name (artist_credit, position, artist, name, join_phrase) VALUES (3, 2, 3, 'GUMI', NULL);
INSERT INTO artist_credit_name (artist_credit, position, artist, name, join_phrase) VALUES (4, 1, 4, '1640mP', ' feat. ');
INSERT INTO artist_credit_name (artist_credit, position, artist, name, join_phrase) VALUES (4, 2, 2, '初音ミク', NULL);
INSERT INTO artist_credit_name (artist_credit, position, artist, name, join_phrase) VALUES (5, 1, 1, '40mP', ' feat. ');
INSERT INTO artist_credit_name (artist_credit, position, artist, name, join_phrase) VALUES (5, 2, 2, '初音ミク', '・');
INSERT INTO artist_credit_name (artist_credit, position, artist, name, join_phrase) VALUES (5, 3, 3, 'GUMI', NULL);

INSERT INTO recording (id, gid, name, artist_credit) VALUES (1, '71c3db9c-91d7-46d7-ad14-c54944b6bc25', '小さな世界', 2);
INSERT INTO recording (id, gid, name, artist_credit) VALUES (2, '976ea82a-9124-43a3-915e-510ee7233c19', '夢地図', 3);
INSERT INTO recording (id, gid, name, artist_credit) VALUES (3, '2caadf01-885a-4f03-b706-34f02c624523', 'タイムマシン', 4);
INSERT INTO recording (id, gid, name, artist_credit) VALUES (4, '23af32ee-1884-42a7-bd56-64cfa212dd39', '空中アクアリウム', 2);
INSERT INTO recording (id, gid, name, artist_credit, length, disambiguation) VALUES (5, '331ad360-8ab5-477e-879d-cb5c2b093bf4', 'トリノコシティ', 2, 205000, '小さな自分と大きな世界 mix');
INSERT INTO recording (id, gid, name, artist_credit) VALUES (6, '5209daef-f83d-4fd6-a6fc-310eed7ed574', 'それでいいなら', 3);
INSERT INTO recording (id, gid, name, artist_credit) VALUES (7, 'fed1e6c5-61a7-4475-991d-0bdec28215d8', 'からくりピエロ', 2);
INSERT INTO recording (id, gid, name, artist_credit) VALUES (8, 'd18e0063-8c4d-44df-99ca-b584ae3b7368', '妄想スケッチ', 2);
INSERT INTO recording (id, gid, name, artist_credit) VALUES (9, '7e996201-cd8f-4b27-8f4e-2bc0e3b09a5a', 'キリトリセン', 3);
INSERT INTO recording (id, gid, name, artist_credit) VALUES (10, '93314ec2-1ce0-4b96-8da2-9842c73de03b', '綺麗な世界', 2);
INSERT INTO recording (id, gid, name, artist_credit) VALUES (11, '86629606-a594-4e33-8d3a-dc51a2eb67dc', '396', 2);
INSERT INTO recording (id, gid, name, artist_credit) VALUES (12, '3aab0a59-2de0-4e7d-bcd8-e05d88b56d88', 'フタリボシ (acoustic version)', 5);
INSERT INTO recording (id, gid, name, artist_credit) VALUES (13, '197a2df9-f0a7-4c2f-aced-fd9b0991af96', '夏恋花火', 3);
INSERT INTO recording (id, gid, name, artist_credit) VALUES (14, '6f3df2f5-344e-41a4-a1b8-c76b7f4dd49b', '君の手、僕の手', 2);
INSERT INTO recording (id, gid, name, artist_credit) VALUES (15, '20b1c853-6a53-4beb-a722-596b4bf80ad7', '大きな世界', 3);
INSERT INTO recording (id, gid, name, artist_credit, length) VALUES (16, '80e30e66-caf3-494b-b33b-a0436c510d6d', '[unknown]', 2, 288000);

INSERT INTO release_group (id, gid, name, artist_credit, release_group_type) VALUES (1, '91da0ea1-cf62-4bfa-b951-cc4a57a4c43a', '小さな自分と大きな世界', 1, (SELECT id FROM release_group_type WHERE name='Album'));

INSERT INTO release (id, gid, name, artist_credit, release_group, release_status, country, language, script, date_year, date_month, date_day) VALUES (1, '8d740564-0c66-4735-9577-c3984ea23981', '小さな自分と大きな世界', 1, 1, (SELECT id FROM release_status WHERE name='Official'), (SELECT id FROM country WHERE iso_code='JP'), (SELECT id FROM language WHERE iso_code_3t='jpn'), (SELECT id FROM script WHERE iso_code='Jpan'), 2011, 7, 20);

INSERT INTO medium (id, release, position, track_count, medium_format, name) VALUES (1, 1, 1, 16, (SELECT id FROM medium_format WHERE name='CD'), NULL);

INSERT INTO track (id, recording, medium, position, name, artist_credit, length) VALUES (1, 1, 1, 1, '小さな世界', 2, 243000);
INSERT INTO track (id, recording, medium, position, name, artist_credit, length) VALUES (2, 2, 1, 2, '夢地図', 3, 188000);
INSERT INTO track (id, recording, medium, position, name, artist_credit, length) VALUES (3, 3, 1, 3, 'タイムマシン', 4, 248000);
INSERT INTO track (id, recording, medium, position, name, artist_credit, length) VALUES (4, 4, 1, 4, '空中アクアリウム', 2, 262000);
INSERT INTO track (id, recording, medium, position, name, artist_credit, length) VALUES (5, 5, 1, 5, 'トリノコシティ', 2, 205000);

INSERT INTO track (id, recording, medium, position, name, artist_credit, length) VALUES (6, 6, 1, 6, 'それでいいなら', 3, 204000);
INSERT INTO track (id, recording, medium, position, name, artist_credit, length) VALUES (7, 7, 1, 7, 'からくりピエロ', 2, 249000);
INSERT INTO track (id, recording, medium, position, name, artist_credit, length) VALUES (8, 8, 1, 8, '妄想スケッチ', 2, 222000);
INSERT INTO track (id, recording, medium, position, name, artist_credit, length) VALUES (9, 9, 1, 9, 'キリトリセン', 3, 235000);
INSERT INTO track (id, recording, medium, position, name, artist_credit, length) VALUES (10, 10, 1, 10, '綺麗な世界', 2, 300000);
INSERT INTO track (id, recording, medium, position, name, artist_credit, length) VALUES (11, 11, 1, 11, '396', 2, 244000);
INSERT INTO track (id, recording, medium, position, name, artist_credit, length) VALUES (12, 12, 1, 12, 'フタリボシ (acoustic version)', 5, 300000);
INSERT INTO track (id, recording, medium, position, name, artist_credit, length) VALUES (13, 13, 1, 13, '夏恋花火', 3, 297000);
INSERT INTO track (id, recording, medium, position, name, artist_credit, length) VALUES (14, 14, 1, 14, '君の手、僕の手', 2, 339000);
INSERT INTO track (id, recording, medium, position, name, artist_credit, length) VALUES (15, 15, 1, 15, '大きな世界', 3, 285000);
INSERT INTO track (id, recording, medium, position, name, artist_credit, length) VALUES (16, 16, 1, 16, '[unknown]', 2, 288000);
