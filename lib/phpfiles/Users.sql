---- Database: `food_app`
--

-- --------------------------------------------------------

--
-- Table structure for table `Users`
--

CREATE TABLE `Users` (
  `user_id` int auto_increment primary key,
  `user_name` varchar(100),
  `user_email` varchar(100),
  `user_province` varchar(30),
  `user_gender` varchar(10),
  `user_password` text);