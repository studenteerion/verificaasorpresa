-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Creato il: Feb 23, 2026 alle 08:48
-- Versione del server: 10.11.14-MariaDB-0ubuntu0.24.04.1
-- Versione PHP: 8.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `verificaasorpresa`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `Catalogo`
--

CREATE TABLE `Catalogo` (
  `fid` varchar(20) NOT NULL,
  `pid` varchar(20) NOT NULL,
  `costo` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `Catalogo`
--

INSERT INTO `Catalogo` (`fid`, `pid`, `costo`) VALUES
('F1', 'P1', 10.00),
('F1', 'P10', 23.00),
('F1', 'P2', 12.00),
('F1', 'P3', 11.00),
('F1', 'P4', 13.00),
('F1', 'P5', 14.00),
('F1', 'P6', 15.00),
('F1', 'P7', 20.00),
('F1', 'P8', 21.00),
('F1', 'P9', 22.00),
('F2', 'P1', 11.00),
('F2', 'P10', 24.00),
('F2', 'P2', 13.00),
('F2', 'P3', 12.00),
('F2', 'P4', 14.00),
('F2', 'P5', 15.00),
('F2', 'P6', 16.00),
('F2', 'P7', 21.00),
('F2', 'P8', 22.00),
('F2', 'P9', 23.00),
('F3', 'P1', 12.00),
('F3', 'P10', 25.00),
('F3', 'P2', 14.00),
('F3', 'P3', 13.00),
('F3', 'P4', 15.00),
('F3', 'P5', 16.00),
('F3', 'P6', 17.00),
('F3', 'P7', 22.00),
('F3', 'P8', 23.00),
('F3', 'P9', 24.00),
('F4', 'P1', 13.00),
('F4', 'P10', 26.00),
('F4', 'P2', 15.00),
('F4', 'P3', 14.00),
('F4', 'P4', 16.00),
('F4', 'P5', 17.00),
('F4', 'P6', 18.00),
('F4', 'P7', 23.00),
('F4', 'P8', 24.00),
('F4', 'P9', 25.00),
('F5', 'P1', 14.00),
('F5', 'P10', 27.00),
('F5', 'P2', 16.00),
('F5', 'P3', 15.00),
('F5', 'P4', 17.00),
('F5', 'P5', 18.00),
('F5', 'P6', 19.00),
('F5', 'P7', 24.00),
('F5', 'P8', 25.00),
('F5', 'P9', 26.00),
('F6', 'P1', 9.00),
('F6', 'P2', 9.00),
('F6', 'P3', 9.00),
('F6', 'P4', 9.00),
('F6', 'P5', 9.00),
('F7', 'P1', 8.00),
('F7', 'P2', 8.00),
('F7', 'P3', 8.00),
('F7', 'P4', 8.00),
('F7', 'P5', 8.00),
('F8', 'P1', 7.00),
('F8', 'P2', 7.00),
('F8', 'P3', 7.00),
('F8', 'P4', 7.00),
('F8', 'P5', 7.00);

-- --------------------------------------------------------

--
-- Struttura della tabella `Fornitori`
--

CREATE TABLE `Fornitori` (
  `fid` varchar(20) NOT NULL,
  `fnome` varchar(100) NOT NULL,
  `indirizzo` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `Fornitori`
--

INSERT INTO `Fornitori` (`fid`, `fnome`, `indirizzo`) VALUES
('F1', 'Acme', 'Milano'),
('F2', 'Beta', 'Roma'),
('F3', 'Gamma', 'Torino'),
('F4', 'Delta', 'Napoli'),
('F5', 'Epsilon', 'Bologna'),
('F6', 'Zeta', 'Firenze'),
('F7', 'Eta', 'Genova'),
('F8', 'Theta', 'Venezia');

-- --------------------------------------------------------

--
-- Struttura della tabella `Pezzi`
--

CREATE TABLE `Pezzi` (
  `pid` varchar(20) NOT NULL,
  `pnome` varchar(100) NOT NULL,
  `colore` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `Pezzi`
--

INSERT INTO `Pezzi` (`pid`, `pnome`, `colore`) VALUES
('P1', 'Bullone A', 'rosso'),
('P10', 'Perno B', 'verde'),
('P2', 'Bullone B', 'rosso'),
('P3', 'Vite A', 'rosso'),
('P4', 'Vite B', 'rosso'),
('P5', 'Dado A', 'rosso'),
('P6', 'Dado B', 'rosso'),
('P7', 'Ingranaggio A', 'verde'),
('P8', 'Ingranaggio B', 'verde'),
('P9', 'Perno A', 'verde');

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `Catalogo`
--
ALTER TABLE `Catalogo`
  ADD PRIMARY KEY (`fid`,`pid`),
  ADD KEY `pid` (`pid`);

--
-- Indici per le tabelle `Fornitori`
--
ALTER TABLE `Fornitori`
  ADD PRIMARY KEY (`fid`);

--
-- Indici per le tabelle `Pezzi`
--
ALTER TABLE `Pezzi`
  ADD PRIMARY KEY (`pid`);

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `Catalogo`
--
ALTER TABLE `Catalogo`
  ADD CONSTRAINT `Catalogo_ibfk_1` FOREIGN KEY (`fid`) REFERENCES `Fornitori` (`fid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Catalogo_ibfk_2` FOREIGN KEY (`pid`) REFERENCES `Pezzi` (`pid`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
