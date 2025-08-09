-- Use the database
USE sai;

-- Insert sample users
INSERT INTO users (name, email, password) VALUES
('Admin User', 'admin@example.com', '$2a$12$examplehashedpassword'),
('John Doe', 'john.doe@example.com', '$2a$12$examplehashedpassword'),
('Jane Smith', 'jane.smith@example.com', '$2a$12$examplehashedpassword');

-- Insert sample schedules for user 2 (John Doe)
INSERT INTO schedules (user_id, hari, waktu, kode_matkul, nama_matkul, sks, kelas, dosen) VALUES
(2, 'Monday', '08:00-09:40', 'CS101', 'Introduction to Computer Science', 3, 'A', 'Prof. Anderson'),
(2, 'Monday', '10:00-11:40', 'MATH101', 'Calculus I', 3, 'B', 'Dr. Brown'),
(2, 'Tuesday', '13:00-14:40', 'PHY101', 'Physics I', 3, 'C', 'Dr. White'),
(2, 'Wednesday', '09:00-10:40', 'CS102', 'Data Structures', 3, 'A', 'Prof. Johnson'),
(2, 'Thursday', '14:00-15:40', 'ENG101', 'English Composition', 2, 'D', 'Prof. Davis');

-- Insert sample schedules for user 3 (Jane Smith)
INSERT INTO schedules (user_id, hari, waktu, kode_matkul, nama_matkul, sks, kelas, dosen) VALUES
(3, 'Monday', '08:00-09:40', 'BIO101', 'Biology I', 3, 'E', 'Dr. Green'),
(3, 'Tuesday', '10:00-11:40', 'CHEM101', 'Chemistry I', 3, 'F', 'Prof. Black'),
(3, 'Wednesday', '13:00-14:40', 'PSY101', 'Introduction to Psychology', 3, 'G', 'Dr. Taylor'),
(3, 'Friday', '09:00-10:40', 'ART101', 'Art History', 2, 'H', 'Prof. Wilson');

-- Insert sample chat history
INSERT INTO chat_history (user_id, message, response) VALUES
(2, 'Apa jadwal saya hari ini?', 'Anda memiliki kelas Introduction to Computer Science pada pukul 08:00-09:40 dan Calculus I pada pukul 10:00-11:40.'),
(2, 'Siapa dosen untuk kelas Calculus?', 'Dosen untuk kelas Calculus I adalah Dr. Brown.'),
(3, 'Kapan kelas Biology saya?', 'Kelas Biology I Anda setiap Senin pukul 08:00-09:40.'),
(3, 'Berapa SKS untuk Art History?', 'Art History memiliki 2 SKS.');
