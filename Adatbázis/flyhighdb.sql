-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2024. Már 08. 20:34
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
(2, 'ZF-870', 43, 63, 4, 34543),
(3, 'RTG-820', 54, 84, 12, 13),
(4, 'M-900', 32, 76, 12, 23),
(5, 'sfgdg', 44, 3, 3, 11);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `userdata`
--

CREATE TABLE `userdata` (
  `Id` int(11) NOT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Password` varchar(255) DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `userdata`
--

INSERT INTO `userdata` (`Id`, `Name`, `Password`, `Email`) VALUES
(1, 'teszt', 'tesztjelszo123', 'teszt@teszt.hu'),
(5, 'sadasd', 'asdasdad', 'saasd@sdda.hu');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `gepadatok`
--
ALTER TABLE `gepadatok`
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
-- AUTO_INCREMENT a táblához `userdata`
--
ALTER TABLE `userdata`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
