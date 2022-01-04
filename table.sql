CREATE TABLE users 
            (`id` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
            name varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
            fisher_id varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
            ct varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
            job varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
            phone varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
            PRIMARY KEY(`name`));
CREATE TABLE timeRecord
     (`name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
     startTime timestamp,`finishTime` timestamp,
     workTime double,
     FOREIGN KEY(`name`) REFERENCES users(`name`));
CREATE TABLE splittime ( 
            id int not null auto_increment,
            name varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
            day varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
            storeform varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
             PRIMARY KEY (`id`) );