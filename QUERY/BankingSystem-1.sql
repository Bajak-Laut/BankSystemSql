-- File SQL: create_and_insert.sql

-- Membuat tabel Nasabah
CREATE TABLE IF NOT EXISTS Nasabah (
    NasabahID INT PRIMARY KEY,
    Nama VARCHAR(255),
    Alamat VARCHAR(255),
    NomorTelepon VARCHAR(15),
    TanggalLahir DATE
);

-- Membuat tabel Akun
CREATE TABLE IF NOT EXISTS Akun (
    AkunID INT PRIMARY KEY,
    JenisAkun VARCHAR(50),
    Saldo DECIMAL(15, 2),
    NasabahID INT,
    FOREIGN KEY (NasabahID) REFERENCES Nasabah(NasabahID)
);

-- Membuat tabel Transaksi
CREATE TABLE IF NOT EXISTS Transaksi (
    TransaksiID INT PRIMARY KEY,
    TanggalTransaksi DATE,
    JumlahTransaksi SERIAL, -- Mengubah tipe data JumlahTransaksi menjadi SERIAL
    JenisTransaksi VARCHAR(50),
    AkunID INT,
    FOREIGN KEY (AkunID) REFERENCES Akun(AkunID)
);

-- Tambahkan data awal ke tabel Nasabah
INSERT INTO Nasabah (NasabahID, Nama, Alamat, NomorTelepon, TanggalLahir)
VALUES
    (1, 'John Doe', 'Jl. Contoh No. 1', '081234567890', '1990-05-15'),
    (2, 'Jane Smith', 'Jl. Sample No. 2', '085678901234', '1985-08-20');
-- Anda dapat menambahkan data tambahan sesuai kebutuhan.

-- Tambahkan data awal ke tabel Akun
INSERT INTO Akun (AkunID, JenisAkun, Saldo, NasabahID)
VALUES
    (1, 'Tabungan', 1000.00, 1),
    (2, 'Deposito', 5000.00, 2);
-- Anda dapat menambahkan data tambahan sesuai kebutuhan.

-- Membuat indeks pada kolom NomorTelepon di tabel Nasabah
CREATE INDEX IF NOT EXISTS idx_nomor_telepon
ON Nasabah (NomorTelepon);

-- Membuat stored procedure untuk menambahkan data Nasabah
CREATE OR REPLACE FUNCTION tambah_nasabah(nama VARCHAR(255), alamat VARCHAR(255), nomor_telepon VARCHAR(15), tanggal_lahir DATE) RETURNS VOID AS $$
BEGIN
    INSERT INTO Nasabah (Nama, Alamat, NomorTelepon, TanggalLahir) VALUES (nama, alamat, nomor_telepon, tanggal_lahir);
END;
$$ LANGUAGE plpgsql;


-- 2. READ - Mengambil data
SELECT * FROM Nasabah;

-- 3. UPDATE - Memperbarui data
UPDATE Nasabah
SET Alamat = 'Jl. Baru No. 123'
WHERE NasabahID = 3;

-- 4. DELETE - Menghapus data
DELETE FROM Nasabah
WHERE NasabahID = 3;
