INSERT INTO artist_type (id, name) VALUES (1, 'Person');
INSERT INTO artist_type (id, name) VALUES (2, 'Group');
INSERT INTO artist_type (id, name) VALUES (3, 'Other');

INSERT INTO country (id, iso_code, name) VALUES (107, 'JP', 'Japan');

INSERT INTO gender (id, name) VALUES (1, 'Male');
INSERT INTO gender (id, name) VALUES (2, 'Female');
INSERT INTO gender (id, name) VALUES (3, 'Other');

INSERT INTO medium_format (id, name) VALUES (1, 'CD');
INSERT INTO medium_format (id, name) VALUES (2, 'DVD');
INSERT INTO medium_format (id, name) VALUES (3, 'SACD');
INSERT INTO medium_format (id, name) VALUES (4, 'DualDisc');
INSERT INTO medium_format (id, name) VALUES (6, 'MiniDisc');
INSERT INTO medium_format (id, name) VALUES (7, 'Vinyl');
INSERT INTO medium_format (id, name) VALUES (8, 'Cassette');
INSERT INTO medium_format (id, name) VALUES (12, 'Digital Media');
INSERT INTO medium_format (id, name) VALUES (13, 'Other');
INSERT INTO medium_format (id, name) VALUES (17, 'HD-DVD');
INSERT INTO medium_format (id, name) VALUES (20, 'Blu-ray');
INSERT INTO medium_format (id, name) VALUES (22, 'VCD');
INSERT INTO medium_format (id, name) VALUES (28, 'UMD');
INSERT INTO medium_format (id, name) VALUES (32, 'Videotape');
INSERT INTO medium_format (id, name, parent) VALUES (5, 'LaserDisc', 13);
INSERT INTO medium_format (id, name, parent) VALUES (9, 'Cartridge', 13);
INSERT INTO medium_format (id, name, parent) VALUES (10, 'Reel-to-reel', 13);
INSERT INTO medium_format (id, name, parent) VALUES (11, 'DAT', 13);
INSERT INTO medium_format (id, name, parent) VALUES (14, 'Wax Cylinder', 13);
INSERT INTO medium_format (id, name, parent) VALUES (15, 'Piano Roll', 13);
INSERT INTO medium_format (id, name, parent) VALUES (16, 'DCC', 13);
INSERT INTO medium_format (id, name, parent) VALUES (21, 'VHS', 32);
INSERT INTO medium_format (id, name, parent) VALUES (23, 'SVCD', 22);
INSERT INTO medium_format (id, name, parent) VALUES (24, 'Betamax', 32);
INSERT INTO medium_format (id, name, parent) VALUES (25, 'HDCD', 1);
INSERT INTO medium_format (id, name, parent) VALUES (29, '7" Vinyl', 7);
INSERT INTO medium_format (id, name, parent) VALUES (30, '10" Vinyl', 7);
INSERT INTO medium_format (id, name, parent) VALUES (31, '12" Vinyl', 7);
INSERT INTO medium_format (id, name, parent) VALUES (26, 'USB Flash Drive', 12);
INSERT INTO medium_format (id, name, parent) VALUES (27, 'slotMusic', 12);
INSERT INTO medium_format (id, name, parent) VALUES (18, 'DVD-Audio', 2);
INSERT INTO medium_format (id, name, parent) VALUES (19, 'DVD-Video', 2);
INSERT INTO medium_format (id, name, parent) VALUES (33, 'CD-R', 1);
INSERT INTO medium_format (id, name, parent) VALUES (34, '8cm CD', 1);

INSERT INTO release_group_type (id, name) VALUES (1, 'Album');
INSERT INTO release_group_type (id, name) VALUES (2, 'Single');
INSERT INTO release_group_type (id, name) VALUES (3, 'EP');
INSERT INTO release_group_type (id, name) VALUES (4, 'Compilation');
INSERT INTO release_group_type (id, name) VALUES (5, 'Soundtrack');
INSERT INTO release_group_type (id, name) VALUES (6, 'Spokenword');
INSERT INTO release_group_type (id, name) VALUES (7, 'Interview');
INSERT INTO release_group_type (id, name) VALUES (8, 'Audiobook');
INSERT INTO release_group_type (id, name) VALUES (9, 'Live');
INSERT INTO release_group_type (id, name) VALUES (10, 'Remix');
INSERT INTO release_group_type (id, name) VALUES (11, 'Other');

INSERT INTO release_status (id, name) VALUES (1, 'Official');
INSERT INTO release_status (id, name) VALUES (2, 'Promotion');
INSERT INTO release_status (id, name) VALUES (3, 'Bootleg');
INSERT INTO release_status (id, name) VALUES (4, 'Pseudo-Release');

INSERT INTO release_packaging (id, name) VALUES (1, 'Jewel Case');
INSERT INTO release_packaging (id, name) VALUES (2, 'Slim Jewel Case');
INSERT INTO release_packaging (id, name) VALUES (3, 'Digipak');
INSERT INTO release_packaging (id, name) VALUES (4, 'Cardboard/Paper Sleeve');
INSERT INTO release_packaging (id, name) VALUES (5, 'Other');
INSERT INTO release_packaging (id, name) VALUES (6, 'Keep Case');
INSERT INTO release_packaging (id, name) VALUES (7, 'None');

INSERT INTO language (id, iso_code_3t, iso_code_3b, iso_code_2, name) VALUES (198, 'jpn', 'jpn', 'ja', 'Japanese');

INSERT INTO script (id, iso_code, iso_number, name) VALUES (85, 'Jpan', 413, 'Japanese');
