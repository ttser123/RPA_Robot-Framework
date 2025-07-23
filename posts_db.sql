-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 23, 2025 at 07:13 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `posts_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(5, 'การศึกษา'),
(12, 'การเงิน'),
(2, 'กีฬา'),
(13, 'ครอบครัว'),
(11, 'ดนตรี'),
(1, 'ท่องเที่ยว'),
(15, 'ธรรมะ'),
(3, 'บันเทิง'),
(6, 'วิทยาศาสตร์'),
(10, 'ศิลปะ'),
(14, 'สังคม'),
(4, 'สุขภาพ'),
(8, 'อาสา/จิตอาสา'),
(9, 'อาหาร'),
(7, 'เทคโนโลยี');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `user_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `title`, `content`, `user_id`, `category_id`, `created_at`) VALUES
(4, 'test1', 'test1', 1, 5, '2025-07-23 16:32:12'),
(5, 'ข่าวใหม่', 'ข่าวใหม่', 4, 12, '2025-07-23 17:11:53');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `f_name` varchar(100) DEFAULT NULL,
  `l_name` varchar(100) DEFAULT NULL,
  `role` enum('member','admin') NOT NULL DEFAULT 'member',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `phone`, `f_name`, `l_name`, `role`, `created_at`) VALUES
(1, 'admin', 'admin@gmail.com', '$2b$10$9DyxdRkN88c0a0OW7o3imO4Hp7jcVsVLOQkmUs0i2HcT9CACWxJLe', '0957743139', 'admin', 'admin', 'admin', '2025-07-23 14:28:42'),
(2, 'user1', 'user1@gmail.com', '$2b$10$xmWFGJK7QZzR05muVXFeX.MPipsV.A.SMivEtq.hWHH0iwqyiztJ6', '0957743131', 'user1', 'user1', 'member', '2025-07-23 14:29:19'),
(3, 'user2', 'user2@gmail.com', '$2b$10$earXNvz0rRXdImNEUsZQYOLRmqEOck1TgLEO/iQVmY6X.hjgrtZTm', '0957743132', 'user2', 'user2', 'member', '2025-07-23 14:29:37'),
(4, 'user3', 'user3@gmail.com', '$2b$10$VAviCZnYEY20pTjLvyebNeyan4F3i1BlAPsMgPq4QUxybmYKpDsqK', '0957743133', 'user3', 'user3', 'member', '2025-07-23 14:30:07'),
(25, 'user4', 'user4@gmail.com', '$2b$10$jNFh3b3sJ5Zq0Pyc/QGkYOODSFbPIVRn60y0PSK8IGLvdZMXd9xea', '0957743131', 'user4', 'user4', 'member', '2025-07-23 15:31:54');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `posts_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
