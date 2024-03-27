-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2024. Már 27. 19:21
-- Kiszolgáló verziója: 10.4.32-MariaDB
-- PHP verzió: 8.2.12

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
  `ido` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `jegyadatok`
--

INSERT INTO `jegyadatok` (`jegy_id`, `honnan`, `hova`, `ido`) VALUES
(1, 'Ausztria', 'Belgium', '2024-10-16'),
(2, 'Ausztria', 'Bulgária', '2024-10-17'),
(3, 'Ausztria', 'Ciprus', '2024-10-18'),
(4, 'Ausztria', 'Csehország', '2024-10-19'),
(5, 'Ausztria', 'Dánia', '2024-10-20'),
(6, 'Belgium', 'Észtország', '2024-10-21'),
(7, 'Belgium', 'Finnország', '2024-10-22'),
(8, 'Belgium', 'Franciaország', '2024-10-23'),
(9, 'Belgium', 'Görögország', '2024-10-24'),
(10, 'Belgium', 'Horvátország', '2024-10-25'),
(11, 'Bulgária', 'Írország', '2024-10-26'),
(12, 'Bulgária', 'Lengyelország', '2024-10-27'),
(13, 'Bulgária', 'Lettország', '2024-10-28'),
(14, 'Bulgária', 'Litvánia', '2024-10-29'),
(15, 'Bulgária', 'Luxemburg', '2024-10-30'),
(16, 'Ciprus', 'Magyarország', '2024-10-31'),
(17, 'Ciprus', 'Málta', '2024-11-01'),
(18, 'Ciprus', 'Németország', '2024-11-02'),
(19, 'Ciprus', 'Hollandia', '2024-11-03'),
(20, 'Ciprus', 'Portugália', '2024-11-04'),
(21, 'Dánia', 'Svédország', '2024-11-05'),
(22, 'Dánia', 'Szlovákia', '2024-11-06'),
(23, 'Dánia', 'Szlovénia', '2024-11-07'),
(24, 'Dánia', 'Egyiptom', '2024-11-08'),
(25, 'Dánia', 'Olaszország', '2024-11-09'),
(26, 'Észtország', 'Törökország', '2024-11-10'),
(27, 'Észtország', 'Egyesült Királyság', '2024-11-11'),
(28, 'Észtország', 'Ausztria', '2024-11-12'),
(29, 'Észtország', 'Belgium', '2024-11-13'),
(30, 'Észtország', 'Bulgária', '2024-11-14'),
(31, 'Finnország', 'Ciprus', '2024-11-15'),
(32, 'Finnország', 'Csehország', '2024-11-16'),
(33, 'Finnország', 'Dánia', '2024-11-17'),
(34, 'Finnország', 'Észtország', '2024-11-18'),
(35, 'Finnország', 'Franciaország', '2024-11-19'),
(36, 'Franciaország', 'Görögország', '2024-11-20'),
(37, 'Franciaország', 'Horvátország', '2024-11-21'),
(38, 'Franciaország', 'Írország', '2024-11-22'),
(39, 'Franciaország', 'Lengyelország', '2024-11-23'),
(40, 'Franciaország', 'Lettország', '2024-11-24'),
(41, 'Svédország', 'Szlovákia', '2024-12-01'),
(42, 'Svédország', 'Szlovénia', '2024-12-02'),
(43, 'Svédország', 'Egyiptom', '2024-12-03'),
(44, 'Svédország', 'Olaszország', '2024-12-04'),
(45, 'Svédország', 'Törökország', '2024-12-05'),
(46, 'Szlovákia', 'Egyesült Királyság', '2024-12-06'),
(47, 'Szlovákia', 'Ausztria', '2024-12-07'),
(48, 'Szlovákia', 'Belgium', '2024-12-08'),
(49, 'Szlovákia', 'Bulgária', '2024-12-09'),
(50, 'Szlovákia', 'Ciprus', '2024-12-10'),
(51, 'Szlovénia', 'Csehország', '2024-12-11'),
(52, 'Szlovénia', 'Dánia', '2024-12-12'),
(53, 'Szlovénia', 'Észtország', '2024-12-13'),
(54, 'Szlovénia', 'Finnország', '2024-12-14'),
(55, 'Szlovénia', 'Franciaország', '2024-12-15'),
(56, 'Egyiptom', 'Görögország', '2024-12-16'),
(57, 'Egyiptom', 'Horvátország', '2024-12-17'),
(58, 'Egyiptom', 'Írország', '2024-12-18'),
(59, 'Egyiptom', 'Lengyelország', '2024-12-19'),
(60, 'Egyiptom', 'Lettország', '2024-12-20'),
(61, 'Olaszország', 'Portugália', '2024-12-21'),
(62, 'Olaszország', 'Románia', '2024-12-22'),
(63, 'Olaszország', 'Spanyolország', '2024-12-23'),
(64, 'Olaszország', 'Svédország', '2024-12-24'),
(65, 'Olaszország', 'Szlovákia', '2024-12-25'),
(66, 'Törökország', 'Svédország', '2024-12-26'),
(67, 'Törökország', 'Szlovákia', '2024-12-27'),
(68, 'Törökország', 'Szlovénia', '2024-12-28'),
(69, 'Törökország', 'Egyiptom', '2024-12-29'),
(70, 'Törökország', 'Olaszország', '2024-12-30'),
(71, 'Egyesült Királyság', 'Szlovákia', '2025-01-01'),
(72, 'Egyesült Királyság', 'Szlovénia', '2025-01-02'),
(73, 'Egyesült Királyság', 'Egyiptom', '2025-01-03'),
(74, 'Egyesült Királyság', 'Olaszország', '2025-01-04'),
(75, 'Egyesült Királyság', 'Törökország', '2025-01-05'),
(76, 'Csehország', 'Egyiptom', '2025-01-06'),
(77, 'Csehország', 'Olaszország', '2025-01-07'),
(78, 'Csehország', 'Törökország', '2025-01-08'),
(79, 'Csehország', 'Egyesült Királyság', '2025-01-09'),
(80, 'Csehország', 'Ausztria', '2025-01-10'),
(81, 'Görögország', 'Horvátország', '2025-02-01'),
(82, 'Görögország', 'Írország', '2025-02-02'),
(83, 'Görögország', 'Lengyelország', '2025-02-03'),
(84, 'Görögország', 'Lettország', '2025-02-04'),
(85, 'Görögország', 'Litvánia', '2025-02-05'),
(86, 'Horvátország', 'Luxemburg', '2025-02-06'),
(87, 'Horvátország', 'Magyarország', '2025-02-07'),
(88, 'Horvátország', 'Málta', '2025-02-08'),
(89, 'Horvátország', 'Németország', '2025-02-09'),
(90, 'Horvátország', 'Hollandia', '2025-02-10'),
(91, 'Írország', 'Portugália', '2025-02-11'),
(92, 'Írország', 'Románia', '2025-02-12'),
(93, 'Írország', 'Spanyolország', '2025-02-13'),
(94, 'Írország', 'Svédország', '2025-02-14'),
(95, 'Írország', 'Szlovákia', '2025-02-15'),
(96, 'Lengyelország', 'Szlovénia', '2025-02-16'),
(97, 'Lengyelország', 'Egyiptom', '2025-02-17'),
(98, 'Lengyelország', 'Olaszország', '2025-02-18'),
(99, 'Lengyelország', 'Törökország', '2025-02-19'),
(100, 'Lengyelország', 'Egyesült Királyság', '2025-02-20'),
(101, 'Magyarország', 'Olaszország', '2025-03-21'),
(102, 'Magyarország', 'Törökország', '2025-03-22'),
(103, 'Magyarország', 'Egyesült Királyság', '2025-03-23'),
(104, 'Magyarország', 'Franciaország', '2025-03-24'),
(105, 'Magyarország', 'Spanyolország', '2025-03-25'),
(106, 'Málta', 'Németország', '2025-03-26'),
(107, 'Málta', 'Hollandia', '2025-03-27'),
(108, 'Málta', 'Portugália', '2025-03-28'),
(109, 'Málta', 'Románia', '2025-03-29'),
(110, 'Málta', 'Görögország', '2025-03-30'),
(111, 'Németország', 'Csehország', '2025-03-31'),
(112, 'Németország', 'Dánia', '2025-04-01'),
(113, 'Németország', 'Észtország', '2025-04-02'),
(114, 'Németország', 'Finnország', '2025-04-03'),
(115, 'Németország', 'Lettország', '2025-04-04'),
(116, 'Hollandia', 'Litvánia', '2025-04-05'),
(117, 'Hollandia', 'Luxemburg', '2025-04-06'),
(118, 'Hollandia', 'Magyarország', '2025-04-07'),
(119, 'Hollandia', 'Málta', '2025-04-08'),
(120, 'Hollandia', 'Hollandia', '2025-04-09'),
(121, 'Portugália', 'Norvégia', '2025-04-10'),
(122, 'Portugália', 'Lengyelország', '2025-04-11'),
(123, 'Portugália', 'Portugália', '2025-04-12'),
(124, 'Portugália', 'Románia', '2025-04-13'),
(125, 'Portugália', 'Szlovákia', '2025-04-14'),
(126, 'Egyiptom', 'Magyarország', '2025-05-05'),
(127, 'Egyiptom', 'Málta', '2025-05-06'),
(128, 'Egyiptom', 'Németország', '2025-05-07'),
(129, 'Egyiptom', 'Hollandia', '2025-05-08'),
(130, 'Egyiptom', 'Portugália', '2025-05-09'),
(131, 'Olaszország', 'Románia', '2025-05-10'),
(132, 'Olaszország', 'Spanyolország', '2025-05-11'),
(133, 'Olaszország', 'Svédország', '2025-05-12'),
(134, 'Olaszország', 'Szlovákia', '2025-05-13'),
(135, 'Olaszország', 'Szlovénia', '2025-05-14'),
(136, 'Törökország', 'Egyesült Királyság', '2025-05-15'),
(137, 'Törökország', 'Ausztria', '2025-05-16'),
(138, 'Törökország', 'Belgium', '2025-05-17'),
(139, 'Törökország', 'Bulgária', '2025-05-18'),
(140, 'Törökország', 'Ciprus', '2025-05-19'),
(141, 'Egyesült Királyság', 'Csehország', '2025-05-20'),
(142, 'Egyesült Királyság', 'Dánia', '2025-05-21'),
(143, 'Egyesült Királyság', 'Észtország', '2025-05-22'),
(144, 'Egyesült Királyság', 'Finnország', '2025-05-23'),
(145, 'Egyesült Királyság', 'Franciaország', '2025-05-24');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `jegyek`
--

CREATE TABLE `jegyek` (
  `jegy_id` int(11) NOT NULL,
  `megrendelo_nev` varchar(50) DEFAULT NULL,
  `Indulas_hely` varchar(50) DEFAULT NULL,
  `erkezes_hely` varchar(50) DEFAULT NULL,
  `ido` datetime DEFAULT NULL,
  `utazok` varchar(50) NOT NULL,
  `osztaly` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

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
(5, 'Csehország'),
(6, 'Dánia'),
(7, 'Észtország'),
(8, 'Finnország'),
(9, 'Franciaország'),
(10, 'Görögország'),
(11, 'Horvátország'),
(12, 'Írország'),
(13, 'Lengyelország'),
(14, 'Lettország'),
(15, 'Litvánia'),
(16, 'Luxemburg'),
(17, 'Magyarország'),
(18, 'Málta'),
(19, 'Németország'),
(20, 'Hollandia'),
(21, 'Portugália'),
(22, 'Románia'),
(23, 'Spanyolország'),
(24, 'Svédország'),
(25, 'Szlovákia'),
(26, 'Szlovénia');

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
  MODIFY `jegy_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=146;

--
-- AUTO_INCREMENT a táblához `jegyek`
--
ALTER TABLE `jegyek`
  MODIFY `jegy_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
