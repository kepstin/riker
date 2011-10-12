INSERT OR IGNORE INTO artist (id, gid, name, sort_name, artist_type, country) VALUES (1, 'e1719c24-118e-425b-8f94-954dcf583fb0', '40mP', '40mP', (SELECT id FROM artist_type WHERE name = 'Person'), (SELECT id FROM country WHERE iso_code = 'JP'));
INSERT OR IGNORE INTO artist (id, gid, name, sort_name, begin_date_year, begin_date_month, begin_date_day, artist_type, gender) VALUES (2, '130d679a-9a92-4373-8348-0800b6b93a30', '初音ミク', 'Hatsune, Miku', 2007, 8, 31, (SELECT id FROM artist_type WHERE name = 'Other'), (SELECT id FROM gender WHERE name = 'Female'));
INSERT OR IGNORE INTO artist (id, gid, name, sort_name, artist_type, gender, comment) VALUES (3, 'ef46bbef-dba2-46e3-b534-1b44cbddf249', 'GUMI', 'GUMI', (SELECT id FROM artist_type WHERE name = 'Other'), (SELECT id FROM gender WHERE name = 'Female'), 'vocaloid');
INSERT OR IGNORE INTO artist (id, gid, name, sort_name, artist_type, country) VALUES (4, '623ea50d-00c2-4576-8303-db088e84951d', '1640mP', '1640mP', (SELECT id FROM artist_type WHERE name = 'Group'), (SELECT id FROM country WHERE iso_code = 'JP'));

INSERT OR IGNORE INTO artist_credit (id, name, artist_count) VALUES (1, '40mP', 1);
INSERT OR IGNORE INTO artist_credit (id, name, artist_count) VALUES (2, '40mP feat. 初音ミク', 2);
INSERT OR IGNORE INTO artist_credit (id, name, artist_count) VALUES (3, '40mP feat. GUMI', 2);
INSERT OR IGNORE INTO artist_credit (id, name, artist_count) VALUES (4, '1640mP feat. 初音ミク', 2);
INSERT OR IGNORE INTO artist_credit (id, name, artist_count) VALUES (5, '40mP feat. 初音ミク・GUMI', 3);

INSERT OR IGNORE INTO artist_credit_name (artist_credit, position, artist, name, join_phrase) VALUES (1, 1, 1, '40mP', NULL);
INSERT OR IGNORE INTO artist_credit_name (artist_credit, position, artist, name, join_phrase) VALUES (2, 1, 1, '40mP', ' feat. ');
INSERT OR IGNORE INTO artist_credit_name (artist_credit, position, artist, name, join_phrase) VALUES (2, 2, 2, '初音ミク', NULL);
INSERT OR IGNORE INTO artist_credit_name (artist_credit, position, artist, name, join_phrase) VALUES (3, 1, 1, '40mP', ' feat. ');
INSERT OR IGNORE INTO artist_credit_name (artist_credit, position, artist, name, join_phrase) VALUES (3, 2, 3, 'GUMI', NULL);
INSERT OR IGNORE INTO artist_credit_name (artist_credit, position, artist, name, join_phrase) VALUES (4, 1, 4, '1640mP', ' feat. ');
INSERT OR IGNORE INTO artist_credit_name (artist_credit, position, artist, name, join_phrase) VALUES (4, 2, 2, '初音ミク', NULL);
INSERT OR IGNORE INTO artist_credit_name (artist_credit, position, artist, name, join_phrase) VALUES (5, 1, 1, '40mP', ' feat. ');
INSERT OR IGNORE INTO artist_credit_name (artist_credit, position, artist, name, join_phrase) VALUES (5, 2, 2, '初音ミク', '・');
INSERT OR IGNORE INTO artist_credit_name (artist_credit, position, artist, name, join_phrase) VALUES (5, 3, 3, 'GUMI', NULL);

INSERT OR IGNORE INTO recording (id, gid, name, artist_credit) VALUES (1, '71c3db9c-91d7-46d7-ad14-c54944b6bc25', '小さな世界', 2);
INSERT OR IGNORE INTO recording (id, gid, name, artist_credit) VALUES (2, '976ea82a-9124-43a3-915e-510ee7233c19', '夢地図', 3);

INSERT OR IGNORE INTO tracklist (id, track_count) VALUES (1, 16);
