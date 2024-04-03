-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2024. Ápr 03. 19:46
-- Kiszolgáló verziója: 10.4.28-MariaDB
-- PHP verzió: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `flyhighdb`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `gepadatok`
--

CREATE TABLE `gepadatok` (
  `Id` int(11) NOT NULL,
  `Gepneve` varchar(50) DEFAULT NULL,
  `Foglaltturista` int(11) DEFAULT NULL,
  `Foglalt1oszt` int(11) DEFAULT NULL,
  `Elsoosztulohelyek` int(11) DEFAULT NULL,
  `Turistaulohelyek` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `gepadatok`
--

INSERT INTO `gepadatok` (`Id`, `Gepneve`, `Foglaltturista`, `Foglalt1oszt`, `Elsoosztulohelyek`, `Turistaulohelyek`) VALUES
(2, 'ZF-870', 43, 63, 66, 12),
(3, 'RTG-820', 54, 84, 12, 13),
(4, 'M-900', 32, 76, 12, 23),
(5, 'sddsdsd', 44, 3, 3, 11);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `jegyadatok`
--

CREATE TABLE `jegyadatok` (
  `jegy_id` int(11) NOT NULL,
  `honnan` varchar(255) DEFAULT NULL,
  `hova` varchar(255) DEFAULT NULL,
  `ido` date DEFAULT NULL,
  `ora` int(11) DEFAULT NULL,
  `perc` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `jegyadatok`
--

INSERT INTO `jegyadatok` (`jegy_id`, `honnan`, `hova`, `ido`, `ora`, `perc`) VALUES
(1, 'Ausztria', 'Belgium', '2025-05-05', 12, 35),
(2, 'Ausztria', 'Belgium', '2025-05-05', 13, 45),
(3, 'Ausztria', 'Belgium', '2025-05-05', 17, 50),
(4, 'Ausztria', 'Bulgária', '2025-05-06', 10, 25),
(5, 'Ausztria', 'Bulgária', '2025-05-06', 14, 40),
(6, 'Ausztria', 'Bulgária', '2025-05-06', 18, 55),
(7, 'Ausztria', 'Ciprus', '2025-05-07', 9, 30),
(8, 'Ausztria', 'Ciprus', '2025-05-07', 13, 45),
(9, 'Ausztria', 'Ciprus', '2025-05-07', 16, 55),
(10, 'Ausztria', 'Csehország', '2025-05-08', 11, 20),
(11, 'Ausztria', 'Csehország', '2025-05-08', 15, 40),
(12, 'Ausztria', 'Csehország', '2025-05-08', 19, 50),
(13, 'Belgium', 'Ausztria', '2025-05-09', 12, 30),
(14, 'Belgium', 'Ausztria', '2025-05-09', 14, 45),
(15, 'Belgium', 'Ausztria', '2025-05-09', 16, 55),
(16, 'Belgium', 'Bulgária', '2025-05-10', 9, 30),
(17, 'Belgium', 'Bulgária', '2025-05-10', 13, 45),
(18, 'Belgium', 'Bulgária', '2025-05-10', 16, 55),
(19, 'Belgium', 'Ciprus', '2025-05-11', 11, 20),
(20, 'Belgium', 'Ciprus', '2025-05-11', 15, 40),
(21, 'Belgium', 'Ciprus', '2025-05-11', 19, 50),
(22, 'Belgium', 'Csehország', '2025-05-12', 10, 25),
(23, 'Belgium', 'Csehország', '2025-05-12', 14, 40),
(24, 'Belgium', 'Csehország', '2025-05-12', 18, 55),
(25, 'Bulgária', 'Ausztria', '2025-05-13', 12, 30),
(26, 'Bulgária', 'Ausztria', '2025-05-13', 14, 45),
(27, 'Bulgária', 'Ausztria', '2025-05-13', 16, 55),
(28, 'Bulgária', 'Belgium', '2025-05-14', 9, 30),
(29, 'Bulgária', 'Belgium', '2025-05-14', 13, 45),
(30, 'Bulgária', 'Belgium', '2025-05-14', 16, 55),
(31, 'Bulgária', 'Ciprus', '2025-05-15', 11, 20),
(32, 'Bulgária', 'Ciprus', '2025-05-15', 15, 40),
(33, 'Bulgária', 'Ciprus', '2025-05-15', 19, 50),
(34, 'Bulgária', 'Csehország', '2025-05-16', 10, 25),
(35, 'Bulgária', 'Csehország', '2025-05-16', 14, 40),
(36, 'Bulgária', 'Csehország', '2025-05-16', 18, 55),
(37, 'Ciprus', 'Ausztria', '2025-05-17', 12, 30),
(38, 'Ciprus', 'Ausztria', '2025-05-17', 14, 45),
(39, 'Ciprus', 'Ausztria', '2025-05-17', 16, 55),
(40, 'Ciprus', 'Belgium', '2025-05-18', 9, 30),
(41, 'Ciprus', 'Belgium', '2025-05-18', 13, 45),
(42, 'Ciprus', 'Belgium', '2025-05-18', 16, 55),
(43, 'Ciprus', 'Bulgária', '2025-05-19', 11, 20),
(44, 'Ciprus', 'Bulgária', '2025-05-19', 15, 40),
(45, 'Ciprus', 'Bulgária', '2025-05-19', 19, 50),
(46, 'Ciprus', 'Csehország', '2025-05-20', 10, 25),
(47, 'Ciprus', 'Csehország', '2025-05-20', 14, 40),
(48, 'Ciprus', 'Csehország', '2025-05-20', 18, 55),
(49, 'Csehország', 'Ausztria', '2025-05-21', 12, 30),
(50, 'Csehország', 'Ausztria', '2025-05-21', 14, 45),
(51, 'Csehország', 'Ausztria', '2025-05-21', 16, 55),
(52, 'Csehország', 'Belgium', '2025-05-22', 9, 30),
(53, 'Csehország', 'Belgium', '2025-05-22', 13, 45),
(54, 'Csehország', 'Belgium', '2025-05-22', 16, 55),
(55, 'Csehország', 'Bulgária', '2025-05-23', 11, 20),
(56, 'Csehország', 'Bulgária', '2025-05-23', 15, 40),
(57, 'Csehország', 'Bulgária', '2025-05-23', 19, 50),
(58, 'Csehország', 'Ciprus', '2025-05-24', 10, 25),
(59, 'Csehország', 'Ciprus', '2025-05-24', 14, 40),
(60, 'Csehország', 'Ciprus', '2025-05-24', 18, 55);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `jegyek`
--

CREATE TABLE `jegyek` (
  `jegy_id` int(11) NOT NULL,
  `megrendelo_nev` varchar(50) DEFAULT NULL,
  `Indulas_hely` varchar(50) DEFAULT NULL,
  `erkezes_hely` varchar(50) DEFAULT NULL,
  `indulasido` varchar(50) DEFAULT NULL,
  `utazok` int(11) DEFAULT NULL,
  `osztaly` varchar(50) DEFAULT NULL,
  `ar` int(11) DEFAULT NULL,
  `erkezesido` varchar(50) DEFAULT NULL,
  `SorSzek` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `jegyek`
--

INSERT INTO `jegyek` (`jegy_id`, `megrendelo_nev`, `Indulas_hely`, `erkezes_hely`, `indulasido`, `utazok`, `osztaly`, `ar`, `erkezesido`, `SorSzek`) VALUES
(22, 'admin', 'Csehország', 'Ausztria', '14:45', 2, 'business', 19779, '16:45', '1, 8, 1'),
(25, 'asd', 'Belgium', 'Ciprus', '15:40', 2, 'business', 23111, '17:40', '1, 18, 1;1, 17, 1'),
(26, 'asd', 'Belgium', 'Ciprus', '11:20', 3, 'business', 65106, '13:20', '1, 21, 1;1, 20, 1;1, 19, 1'),
(28, 'teszter', 'Csehország', 'Ausztria', '14:45', 5, 'business', 91465, '16:45', '1, 1, 1;1, 2, 1;1, 3, 1;1, 5, 1;1, 4, 1');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `orszagok`
--

CREATE TABLE `orszagok` (
  `Id` int(11) NOT NULL,
  `Orszag_nev` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `orszagok`
--

INSERT INTO `orszagok` (`Id`, `Orszag_nev`) VALUES
(1, 'Ausztria'),
(2, 'Belgium'),
(3, 'Bulgária'),
(4, 'Ciprus'),
(5, 'Csehország');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `userdata`
--

CREATE TABLE `userdata` (
  `Id` int(11) NOT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Password` varchar(255) DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `Permission` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `userdata`
--

INSERT INTO `userdata` (`Id`, `Name`, `Password`, `Email`, `Permission`) VALUES
(1, 'teszt', 'tesztjelszo123', 'teszt@teszt.hu', 'Ugyfel'),
(5, 'admin', 'admin12', 'admin@flyhigh.hu', 'Admin'),
(8, 'teszter', 'teszteles', 'asdasd@asd.hu', 'Ugyfel'),
(10, 'asd', 'asd', 'asdasd@fkdf.hu', 'Ugyfel');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `gepadatok`
--
ALTER TABLE `gepadatok`
  ADD PRIMARY KEY (`Id`);

--
-- A tábla indexei `jegyadatok`
--
ALTER TABLE `jegyadatok`
  ADD PRIMARY KEY (`jegy_id`);

--
-- A tábla indexei `jegyek`
--
ALTER TABLE `jegyek`
  ADD PRIMARY KEY (`jegy_id`);

--
-- A tábla indexei `orszagok`
--
ALTER TABLE `orszagok`
  ADD PRIMARY KEY (`Id`);

--
-- A tábla indexei `userdata`
--
ALTER TABLE `userdata`
  ADD PRIMARY KEY (`Id`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `gepadatok`
--
ALTER TABLE `gepadatok`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT a táblához `jegyadatok`
--
ALTER TABLE `jegyadatok`
  MODIFY `jegy_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT a táblához `jegyek`
--
ALTER TABLE `jegyek`
  MODIFY `jegy_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT a táblához `orszagok`
--
ALTER TABLE `orszagok`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT a táblához `userdata`
--
ALTER TABLE `userdata`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
