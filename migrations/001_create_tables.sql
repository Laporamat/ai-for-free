-- Perfume Database Schema

CREATE TABLE IF NOT EXISTS ingredients (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    note_type VARCHAR(50) NOT NULL, -- top, middle, base
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS fragrance_families (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS perfumes (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    brand VARCHAR(100),
    family_id INTEGER REFERENCES fragrance_families(id),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS perfume_ingredients (
    perfume_id INTEGER REFERENCES perfumes(id),
    ingredient_id INTEGER REFERENCES ingredients(id),
    PRIMARY KEY (perfume_id, ingredient_id)
);

CREATE TABLE IF NOT EXISTS design_tips (
    id SERIAL PRIMARY KEY,
    tip TEXT NOT NULL,
    category VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert initial data
INSERT INTO ingredients (name, note_type, description) VALUES
('ลาเวนเดอร์ (Lavender)', 'middle', 'กลิ่นหอมสดชื่น, ผ่อนคลาย, มักใช้ในน้ำหอมกลิ่นเฟรชและฟู้ด'),
('วานิลลา (Vanilla)', 'base', 'กลิ่นหวาน, อบอุ่น, มักใช้เพื่อเพิ่มความหอมยั่งยืน'),
('สังกะสี (Sandalwood)', 'base', 'กลิ่นร่มไม้, อบอุ่น, เป็นที่นิยมใช้ในน้ำหอมหลายประเภท'),
('เบอร์กามอต (Bergamot)', 'top', 'กลิ่นส้มสดชื่น, มักใช้เป็นกลิ่นเปิดตัวของน้ำหอม'),
('โจโส (Jasmine)', 'middle', 'กลิ่นดอกไม้หวาน, มีเสน่ห์, มักใช้ในน้ำหอมดอกไม้'),
('โอ๊คมอส (Oakmoss)', 'base', 'กลิ่นร่มไม้ดิบ, มักใช้ในน้ำหอมชายพ์ (Chypre)'),
('แพทชูลี (Patchouli)', 'base', 'กลิ่นดิน, ร่มไม้, มักใช้ในน้ำหอมโอเรียนทัล (Oriental)'),
('โรส (Rose)', 'middle', 'กลิ่นดอกกุหลาบคลาสสิก, มีเสน่ห์สูง'),
('ซิตรัส (Citrus)', 'top', 'กลิ่นส้ม, มะนาว, ส้มโอ, สดชื่นและกระปรี้กระเปร่า'),
('อัมเบอร์ (Amber)', 'base', 'กลิ่นอบอุ่น, หวาน, มักสร้างจากส่วนผสมต่างๆ');

INSERT INTO fragrance_families (name, description) VALUES
('Floral (ดอกไม้)', 'กลิ่นดอกไม้ต่างๆ เช่น กุหลาบ, โจโส, ยาสามี'),
('Citrus (ซิตรัส)', 'กลิ่นสดชื่นจากผลไม้ประเภทส้ม เช่น เบอร์กามอต, มะนาว'),
('Woody (ร่มไม้)', 'กลิ่นร่มไม้ เช่น สังกะสี, แพทชูลี, ซีดาร์วู้ด'),
('Oriental (โอเรียนทัล)', 'กลิ่นอบอุ่น, หวาน, มีเสน่ห์ เช่น วานิลลา, อัมเบอร์, สปายซ์'),
('Fresh (เฟรช)', 'กลิ่นสดชื่น, สะอาด เช่น ออกิเจน, น้ำทะเล'),
('Chypre (ชายพ์)', 'กลิ่นคลาสสิกที่มีโอ๊คมอส, เบอร์กามอต, และแพทชูลี'),
('Fougère (ฟูแชร์)', 'กลิ่นสำหรับผู้ชายที่มีลาเวนเดอร์, คูมาริน, และโอ๊คมอส');

INSERT INTO design_tips (tip, category) VALUES
('เริ่มด้วยการเลือก Note หัว (Top Note) ที่จะสร้างความประทับใจแรก', 'basic'),
('Note กลาง (Middle Note) จะช่วยเชื่อมโยง Note หัวและ Note ฐาน', 'basic'),
('Note ฐาน (Base Note) จะทำให้น้ำหอมคงตัวและมีกลิ่นค้างยาว', 'basic'),
('ทดสอบส่วนผสมในอัตราส่วนต่างๆ ก่อนทำขนาดใหญ่', 'testing'),
('พิจารณาเกี่ยวกับเวลาและอากาศที่จะใช้น้ำหอม', 'context'),
('หาความสมดุลระหว่างกลิ่นต่างๆ ไม่ให้กลิ่นใดโดดเด่นเกินไป', 'balance');
