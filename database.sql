-- ITAP/SOEN 4371 - Term Project
-- Online Shoe Store - MySQL schema + seed data
-- Run:  mysql -u root -p < database.sql

DROP DATABASE IF EXISTS shoe_store;
CREATE DATABASE shoe_store CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE shoe_store;

-- -----------------------------------------------------------------------
-- Users
-- -----------------------------------------------------------------------
CREATE TABLE Users (
  idU       INT AUTO_INCREMENT PRIMARY KEY,
  uName     VARCHAR(50)  NOT NULL UNIQUE,
  uPass     VARCHAR(255) NOT NULL,            -- bcrypt hash
  firstName VARCHAR(50),
  lastName  VARCHAR(50),
  email     VARCHAR(100) NOT NULL UNIQUE,
  address   TEXT,
  phone     VARCHAR(20),
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  isActive  BOOLEAN DEFAULT TRUE
);

-- -----------------------------------------------------------------------
-- Products
-- -----------------------------------------------------------------------
CREATE TABLE Products (
  idP         INT AUTO_INCREMENT PRIMARY KEY,
  labelP      VARCHAR(100) NOT NULL,
  desP        TEXT,
  priceP      DECIMAL(10,2) NOT NULL,
  QtyP        INT NOT NULL DEFAULT 0,
  photoPath   VARCHAR(500),
  category    VARCHAR(50),
  isAvailable BOOLEAN DEFAULT TRUE
);

-- -----------------------------------------------------------------------
-- Shopping Cart
-- -----------------------------------------------------------------------
CREATE TABLE ShopCart (
  idCart   INT AUTO_INCREMENT PRIMARY KEY,
  idU      INT NOT NULL,
  idP      INT NOT NULL,
  quantity INT DEFAULT 1,
  addedAt  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (idU) REFERENCES Users(idU)    ON DELETE CASCADE,
  FOREIGN KEY (idP) REFERENCES Products(idP) ON DELETE CASCADE,
  UNIQUE KEY unique_cart_item (idU, idP)
);

-- -----------------------------------------------------------------------
-- Orders
-- -----------------------------------------------------------------------
CREATE TABLE Orders (
  idO             INT AUTO_INCREMENT PRIMARY KEY,
  idU             INT NOT NULL,
  totalPrice      DECIMAL(10,2) NOT NULL,
  shippingAddress TEXT NOT NULL,
  orderStatus     ENUM('pending','paid','shipped','delivered','cancelled') DEFAULT 'pending',
  paymentId       VARCHAR(150),
  createdAt       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (idU) REFERENCES Users(idU)
);

CREATE TABLE OrderItems (
  idOI         INT AUTO_INCREMENT PRIMARY KEY,
  idO          INT NOT NULL,
  idP          INT NOT NULL,
  quantity     INT NOT NULL,
  priceAtTime  DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (idO) REFERENCES Orders(idO)   ON DELETE CASCADE,
  FOREIGN KEY (idP) REFERENCES Products(idP)
);

-- -----------------------------------------------------------------------
-- Password reset tokens (used by /forgot and /reset)
-- -----------------------------------------------------------------------
CREATE TABLE PasswordResets (
  idR        INT AUTO_INCREMENT PRIMARY KEY,
  idU        INT NOT NULL,
  tokenHash  CHAR(64) NOT NULL UNIQUE,
  expiresAt  DATETIME NOT NULL,
  used       BOOLEAN DEFAULT FALSE,
  createdAt  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (idU) REFERENCES Users(idU) ON DELETE CASCADE
);

-- -----------------------------------------------------------------------
-- Seed data
-- -----------------------------------------------------------------------
INSERT INTO Products (labelP, desP, priceP, QtyP, photoPath, category) VALUES
('Nike Air Zoom Pegasus 40',
 'Lightweight daily trainer with responsive Zoom Air cushioning. Breathable engineered mesh upper.',
 129.99, 25,
 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&w=800&q=80',
 'Running'),

('Adidas Ultraboost 22',
 'Energy-returning Boost midsole. Primeknit upper for a sock-like fit.',
 179.00, 18,
 'https://images.unsplash.com/photo-1560769629-975ec94e6a86?auto=format&fit=crop&w=800&q=80',
 'Running'),

('Converse Chuck Taylor All Star',
 'Classic canvas high-top sneaker. The original since 1917.',
 59.99, 40,
 'https://images.unsplash.com/photo-1607522370275-f14206abe5d3?auto=format&fit=crop&w=800&q=80',
 'Casual'),

('Vans Old Skool',
 'Low-top lace-up with the iconic side stripe. Padded collar for comfort.',
 69.95, 32,
 'https://images.unsplash.com/photo-1525966222134-fcfa99b8ae77?auto=format&fit=crop&w=800&q=80',
 'Casual'),

('Air Jordan 1 Retro High',
 'Iconic basketball silhouette with premium leather upper.',
 199.99, 12,
 'https://images.unsplash.com/photo-1600269452121-4f2416e55c28?auto=format&fit=crop&w=800&q=80',
 'Basketball'),

('New Balance 574 Classic',
 'Timeless lifestyle sneaker with ENCAP cushioning.',
 89.99, 22,
 'https://images.unsplash.com/photo-1551107696-a4b0c5a0d9a2?auto=format&fit=crop&w=800&q=80',
 'Casual'),

('Puma RS-X',
 'Bold retro-runner with chunky midsole and color-blocked upper.',
 109.00, 16,
 'https://images.unsplash.com/photo-1608231387042-66d1773070a5?auto=format&fit=crop&w=800&q=80',
 'Casual'),

('Timberland 6-Inch Premium Boot',
 'Waterproof full-grain leather boot. Built for any season.',
 219.99, 14,
 'https://images.unsplash.com/photo-1542219550-37153d387c27?auto=format&fit=crop&w=800&q=80',
 'Boots'),

('Asics Gel-Kayano 30',
 'Stability running shoe with FF BLAST+ midsole and PureGEL technology.',
 159.95, 20,
 'https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?auto=format&fit=crop&w=800&q=80',
 'Running'),

('Reebok Classic Leather',
 'Soft garment leather upper. A heritage favourite since 1983.',
 79.99, 28,
 'https://images.unsplash.com/photo-1491553895911-0055eca6402d?auto=format&fit=crop&w=800&q=80',
 'Casual'),

('Salomon XT-6',
 'Trail-inspired sneaker with Quicklace system. Built for grip and comfort.',
 199.00, 10,
 'https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa?auto=format&fit=crop&w=800&q=80',
 'Trail'),

('Crocs Classic Clog',
 'Lightweight Croslite foam. The everyday off-duty staple.',
 49.99, 50,
 'https://images.unsplash.com/photo-1556906781-9a412961c28c?auto=format&fit=crop&w=800&q=80',
 'Casual');
