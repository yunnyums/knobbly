-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 04-12-2025 a las 01:34:58
-- Versión del servidor: 8.0.43
-- Versión de PHP: 7.4.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `knobbly`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carrito_compras`
--

CREATE TABLE `carrito_compras` (
  `id` int NOT NULL,
  `usuario_id` int NOT NULL,
  `producto_id` int NOT NULL,
  `cantidad` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `imagenes`
--

CREATE TABLE `imagenes` (
  `id` int NOT NULL,
  `perfil_gato_id` int NOT NULL,
  `url_imagen` text NOT NULL,
  `descripción` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mensajes_chat`
--

CREATE TABLE `mensajes_chat` (
  `id` int NOT NULL,
  `remitente_id` int NOT NULL,
  `destinatario_id` int NOT NULL,
  `mensaje` text NOT NULL,
  `fecha_envio` timestamp NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `perfiles_gatos`
--

CREATE TABLE `perfiles_gatos` (
  `id` int NOT NULL,
  `usuario_id` int NOT NULL,
  `nombre_gato` text NOT NULL,
  `edad` int NOT NULL,
  `raza` text NOT NULL,
  `descripción` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id` int NOT NULL,
  `nombre_producto` text NOT NULL,
  `descripcion` text NOT NULL,
  `precio` float NOT NULL,
  `Imagen` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `nombre_producto`, `descripcion`, `precio`, `Imagen`) VALUES
(1, 'RoyalCanin IndoorAdult', 'Croquetas para gato adulto control de bolas de pelo RoyalCanin', 18.5, 'royalcanin_indooradult.jpg'),
(2, 'RoyalCanin KittenDry', 'Alimento seco nutricion balanceada para gatitos RoyalCanin', 16.9, 'royalcanin_kittendry.jpg'),
(3, 'Whiskas TunaBites', 'Snacks sabor atun para gato Whiskas', 4.2, 'whiskas_tunabites.jpg'),
(4, 'Whiskas ChickenCrunch', 'Premio crujiente sabor pollo Whiskas', 3.9, 'whiskas_chickencrunch.jpg'),
(5, 'Friskies OceanMix', 'Alimento seco mezcla pescado para gatos Friskies', 12.8, 'friskies_oceanmix.jpg'),
(6, 'Friskies CatParty', 'Snacks variados para gatos Friskies', 5.1, 'friskies_catparty.jpg'),
(7, 'Catit SensesBall', 'Juguete pelota interactiva para gato Catit', 8.7, 'catit_sensesball.jpg'),
(8, 'Catit TunnelPlay', 'Tunel de juego flexible para gato Catit', 14.6, 'catit_tunnelplay.jpg'),
(9, 'Kong FeatherTeaser', 'Juguete teaser con pluma para gato Kong', 9.4, 'kong_featherteaser.jpg'),
(10, 'Kong SoftMouse', 'Juguete raton suave para gatos Kong', 7.1, 'kong_softmouse.jpg'),
(11, 'Petstages TowerTracks', 'Torre de pistas para gatos Petstages', 22.9, 'petstages_towertracks.jpg'),
(12, 'Petstages ChaseBall', 'Bola ligera para juego activo Petstages', 6.5, 'petstages_chaseball.jpg'),
(13, 'Trixie PlushMouse', 'Raton de peluche para gato Trixie', 4.8, 'trixie_plushmouse.jpg'),
(14, 'Trixie CatTunnel', 'Tunel plegable para gato Trixie', 13.4, 'trixie_cattunnel.jpg'),
(15, 'Hartz CatnipToy', 'Juguete con catnip integrado Hartz', 5.6, 'hartz_catniptoy.jpg'),
(16, 'Hartz ChewMouse', 'Raton resistente con aroma a catnip Hartz', 6.2, 'hartz_chewmouse.jpg'),
(17, 'Orijen CatTreats', 'Premios naturales para gato Orijen', 9.9, 'orijen_cattreats.jpg'),
(18, 'Orijen SixFishDry', 'Alimento premium de seis pescados para gato Orijen', 24.7, 'orijen_sixfishdry.jpg'),
(19, 'BlueBuffalo CatTurkey', 'Alimento de pavo para gato BlueBuffalo', 19.3, 'bluebuffalo_catturkey.jpg'),
(20, 'BlueBuffalo IndoorMix', 'Formula interior para gato adulto BlueBuffalo', 21.1, 'bluebuffalo_indoormix.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `correo` varchar(150) NOT NULL,
  `clave` varchar(200) NOT NULL,
  `perfil` char(1) NOT NULL DEFAULT 'U'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `nombre`, `correo`, `clave`, `perfil`) VALUES
(1, 'yo', 'regina.gonzalez2795@alumnos.udg.mx', 'scrypt:32768:8:1$2coTzqQGSFKkDNYZ$f7d9d5800b8766858a4a0b52314225bbc03566ed3ac8d350c539f1505f5de614795ef2d4f642e423390bf21112f97e87cdd6a287e4c62f3fa131c9919b1be629', 'U');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int NOT NULL,
  `nombre` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `correo_electronico` text NOT NULL,
  `contrasena` text NOT NULL,
  `direccion` varchar(200) NOT NULL,
  `perfil` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `carrito_compras`
--
ALTER TABLE `carrito_compras`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `producto_id` (`producto_id`);

--
-- Indices de la tabla `imagenes`
--
ALTER TABLE `imagenes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `perfil_gato_id` (`perfil_gato_id`);

--
-- Indices de la tabla `mensajes_chat`
--
ALTER TABLE `mensajes_chat`
  ADD PRIMARY KEY (`id`),
  ADD KEY `remitente_id` (`remitente_id`),
  ADD KEY `destinatario_id` (`destinatario_id`);

--
-- Indices de la tabla `perfiles_gatos`
--
ALTER TABLE `perfiles_gatos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `correo` (`correo`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `carrito_compras`
--
ALTER TABLE `carrito_compras`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `imagenes`
--
ALTER TABLE `imagenes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `mensajes_chat`
--
ALTER TABLE `mensajes_chat`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `perfiles_gatos`
--
ALTER TABLE `perfiles_gatos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `carrito_compras`
--
ALTER TABLE `carrito_compras`
  ADD CONSTRAINT `carrito_compras_ibfk_1` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `carrito_compras_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `imagenes`
--
ALTER TABLE `imagenes`
  ADD CONSTRAINT `imagenes_ibfk_1` FOREIGN KEY (`perfil_gato_id`) REFERENCES `perfiles_gatos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
