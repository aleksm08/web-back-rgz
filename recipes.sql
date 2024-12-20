-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Апр 18 2022 г., 23:13
-- Версия сервера: 5.6.51
-- Версия PHP: 7.1.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `recipes`
--

-- --------------------------------------------------------

--
-- Структура таблицы `main`
--

CREATE TABLE `main` (
  `id` int(11) NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `country` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `ingredients` varchar(1000) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cooking` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `main`
--

INSERT INTO `main` (`id`, `name`, `type`, `country`, `ingredients`, `cooking`, `user_id`) VALUES
(1, 'Борщ', 'Суп', 'Русской', 'капуста, картошка', 'Нарезать и сварить', 1),
(2, 'Хачапури', 'Горячее', 'Грузинской', 'тесто,сыр', 'как-то готовиться. Скорее всего, на тандыре', 1),
(16, 'Суши', 'Горячее', 'Японская', 'asd', 'asd', 1),
(17, 'Рамэн', 'Суп', 'Японской', 'яйцо, лапша, курица и тд', 'какой-то очень длинный рецепт от том, как это готовить', 1),
(18, 'Пицца', 'Гарнир', 'Итальянской', 'тесто, соус, остальное по вкусу', 'все на тесто и в духовку', 1),
(19, 'Оливье', 'Салат', 'Испанской', 'картошка, колбаса, яйца, огурец', 'какой-то очень длинный рецепт от том, как это готовить', 1),
(20, 'Латте', 'Напиток', 'Испанской', 'кофе, молоко', 'глвное - взбить молоко', 1),
(21, 'Сок', 'Напиток', 'Русской', 'любой фрукт', 'прогнать через соковыжималку', 1),
(22, 'Чизкейк', 'Десерт', 'Итальянской', 'знать бы....', 'как-то....', 1),
(23, 'Эклер', 'Десерт', 'Казахской', 'крем и тесто', 'в духовке', 1),
(24, 'Пюрешка', 'Гарнир', 'Русской', 'картошка, масло', 'сварить картоху, расточлочь', 1),
(25, 'Карбонара', 'Гарнир', 'Итальянской', 'спагетти, сыр, бекон, сливки, яйца', 'Поджаренный бекон смешать с варенными спагетти и смешать с соусом из сивок и сыра', 1),
(26, 'Крабовый салат', 'Салат', 'Японской', 'крабовые полочки, кукуруза и тп', 'как-то....', 1),
(30, 'Gloria', 'Суп', 'Грузинской', 'картошка, колбаса, яйца, огурец', 'какой-то очень длинный рецепт от том, как это готовить', 13);

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`) VALUES
(1, 'admin', 'NON', 'NON'),
(4, 'Суши', 'ilya2208200217@gmail.com', 'pbkdf2:sha256:260000$7mnoIXAdBWi9B5W6$ebb6a5460e1dd662f1e806d7b964d9511233e57eb61763010793badf0a3b18ee'),
(13, 'Sofi', 'post@mail.ru', 'pbkdf2:sha256:260000$ssJqiZskoB2LXGVM$31296aa520c4bb67792bc26ff99e391c4a9270fb8e1eba0e3a4e741972abfb14');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `main`
--
ALTER TABLE `main`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `main`
--
ALTER TABLE `main`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `main`
--
ALTER TABLE `main`
  ADD CONSTRAINT `main_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
