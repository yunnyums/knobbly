-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 04-12-2025 a las 16:34:57
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
-- Estructura de tabla para la tabla `carrito`
--

CREATE TABLE `carrito` (
  `id` int NOT NULL,
  `usuario_id` int NOT NULL,
  `producto_id` int NOT NULL,
  `cantidad` int DEFAULT '1',
  `fecha` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_pedido`
--

CREATE TABLE `detalle_pedido` (
  `id` int NOT NULL,
  `pedido_id` int NOT NULL,
  `producto_id` int NOT NULL,
  `cantidad` int NOT NULL,
  `precio_unitario` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `detalle_pedido`
--

INSERT INTO `detalle_pedido` (`id`, `pedido_id`, `producto_id`, `cantidad`, `precio_unitario`) VALUES
(1, 6, 1, 1, 18.5),
(2, 6, 1, 1, 18.5),
(3, 6, 3, 1, 4.2),
(4, 7, 2, 1, 16.9),
(5, 8, 17, 1, 9.9),
(6, 8, 18, 1, 24.7),
(7, 9, 18, 1, 24.7),
(8, 9, 9, 1, 9.4),
(9, 10, 10, 1, 7.1),
(10, 11, 13, 1, 4.8),
(11, 11, 1, 1, 18.5);

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
-- Estructura de tabla para la tabla `pedidos`
--

CREATE TABLE `pedidos` (
  `id` int NOT NULL,
  `usuario_id` int NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `fecha` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `pedidos`
--

INSERT INTO `pedidos` (`id`, `usuario_id`, `total`, `fecha`) VALUES
(6, 1, 41.20, '2025-12-04 15:35:14'),
(7, 1, 16.90, '2025-12-04 15:36:26'),
(8, 1, 34.60, '2025-12-04 15:38:04'),
(9, 1, 34.10, '2025-12-04 15:44:37'),
(10, 1, 7.10, '2025-12-04 15:48:53'),
(11, 1, 23.30, '2025-12-04 16:07:33');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos_detalle`
--

CREATE TABLE `pedidos_detalle` (
  `id` int NOT NULL,
  `pedido_id` int NOT NULL,
  `producto_id` int NOT NULL,
  `cantidad` int NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL
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
  `descripcion` text,
  `foto` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `perfiles_gatos`
--

INSERT INTO `perfiles_gatos` (`id`, `usuario_id`, `nombre_gato`, `edad`, `raza`, `descripcion`, `foto`) VALUES
(1, 1, 'Mishifu', 2, 'Siames', 'Juguetón, dramatiza todo y cree que es un ninja.', 'gato1.jpg'),
(2, 1, 'Luna', 1, 'Angora', 'Cariñosa pero se siente la reina de la casa.', 'gato2.jpg'),
(3, 1, 'Toby', 4, 'Bengalí', 'Le encanta dormir, comer y observar pájaros por horas.', 'gato3.jpg'),
(4, 1, 'Nieve', 3, 'Persa', 'Suave, tierna y un poco gruñona por las mañanas.', 'gato4.jpg'),
(5, 1, 'Simba', 2, 'Maine Coon', 'Grande, peludo y protector; cree que es un león.', 'gato5.jpg'),
(6, 1, 'Kiara', 1, 'Esfinge', 'Le encanta estar cerca de humanos, muy sociable.', 'gato6.jpg'),
(7, 1, 'Copo', 5, 'British Shorthair', 'Tranquilo, elegante y siempre posa como modelo.', 'gato7.jpg'),
(8, 1, 'Minina', 2, 'Siames', 'Tierna y muy habladora; siempre maúlla por atención.', 'gato8.jpg'),
(9, 1, 'Taco', 3, 'Atigrado', 'Travieso, roba calcetines y corre como loco.', 'gato9.jpg'),
(10, 1, 'Mizu', 1, 'Abyssinian', 'Hiperactivo y curioso; explora absolutamente todo.', 'gato10.jpg'),
(11, 1, 'Perlita', 4, 'Ragdoll', 'Dulce, relajada y buena para recibir caricias.', 'gato11.jpg'),
(12, 1, 'Shadow', 2, 'Bombay', 'Sigiloso, oscuro y aparece donde menos lo esperas.', 'gato12.jpg'),
(13, 1, 'Cookie', 1, 'Calico', 'Tierna, energética y obsesionada con las cajas.', 'gato13.jpg'),
(14, 1, 'Max', 3, 'Siberiano', 'Peludo y resistente al frío; ama el agua.', 'gato14.jpg'),
(15, 1, 'Milo', 2, 'Exótico', 'Cara aplastadita, súper calmado y amoroso.', 'gato15.jpg'),
(16, 1, 'Titan', 6, 'Maine Coon', 'Gigante, noble y muy paciente con todos.', 'gato16.jpg'),
(17, 1, 'Nala', 2, 'Bengalí', 'Activa, trepadora profesional y muy cariñosa.', 'gato17.jpg'),
(18, 1, 'Chispa', 1, 'Atigrado', 'Brinca por todas partes, energía infinita.', 'gato18.jpg'),
(19, 1, 'Salem', 4, 'Bombay', 'Misterioso y siempre parece estar planeando algo.', 'gato19.jpg'),
(20, 1, 'Bella', 3, 'Persa', 'Dormilona profesional y amante de las mantas suaves.', 'gato20.jpg');

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
  `clave` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `perfil` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL DEFAULT 'U',
  `direccion` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `nombre`, `correo`, `clave`, `perfil`, `direccion`) VALUES
(1, 'prueba', 'p@gmail.com', 'scrypt:32768:8:1$nqLIxy1Rc1JfqwBy$50272b8985e4f0069b665ce8c9d1255ddbad1611e81258a4d322b8c50730b372ecc5ae83f859d7d5b3d76e5adf2c680f5354e72753f419df7347685ed81e4e73', 'U', NULL),
(2, 'prueba2', 't@gmail.com', 'scrypt:32768:8:1$A69U4GxwKk5GxwVF$787e2bd93c6caf68702e562dc9a9b0a42c1ace74b1c692ac4fbef548bf354d1c2b94ff3a527a02f185a93fbb779ecea5a2391ed2674720f52cfcd038bffa98f0', 'A', NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `carrito`
--
ALTER TABLE `carrito`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `detalle_pedido`
--
ALTER TABLE `detalle_pedido`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pedido_id` (`pedido_id`),
  ADD KEY `producto_id` (`producto_id`);

--
-- Indices de la tabla `mensajes_chat`
--
ALTER TABLE `mensajes_chat`
  ADD PRIMARY KEY (`id`),
  ADD KEY `remitente_id` (`remitente_id`),
  ADD KEY `destinatario_id` (`destinatario_id`);

--
-- Indices de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `pedidos_detalle`
--
ALTER TABLE `pedidos_detalle`
  ADD PRIMARY KEY (`id`);

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
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `carrito`
--
ALTER TABLE `carrito`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `detalle_pedido`
--
ALTER TABLE `detalle_pedido`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `mensajes_chat`
--
ALTER TABLE `mensajes_chat`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `pedidos_detalle`
--
ALTER TABLE `pedidos_detalle`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `perfiles_gatos`
--
ALTER TABLE `perfiles_gatos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

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
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalle_pedido`
--
ALTER TABLE `detalle_pedido`
  ADD CONSTRAINT `detalle_pedido_ibfk_1` FOREIGN KEY (`pedido_id`) REFERENCES `pedidos` (`id`),
  ADD CONSTRAINT `detalle_pedido_ibfk_2` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
