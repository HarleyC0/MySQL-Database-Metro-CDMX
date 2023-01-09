-- Crear tablas

USE metro_cdmx;

-- LINEAS 

create table `lines` (

    `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,

    `name` varchar(10) NOT NULL,
    `color` varchar(20) NOT NULL,

    `created_at` timestamp NOT NULL default current_timestamp,
    `updated_at` timestamp NOT NULL default current_timestamp,

    primary key (id)

)
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci; 

-- ESTACIONES 

create table `stations` (
    `id` bigint(20),
    `name` varchar(20) not null,

    `created_at` timestamp NOT NULL default current_timestamp,
    `updated_at` timestamp NOT NULL default current_timestamp,

    primary key(id)
)
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci; 

-- TRENES 

create table `trains` (
    `serial_number` varchar(10) not null,
    `line_id` bigint(20) UNSIGNED NOT NULL,
    `type` tinyint(4) not null,
    `year` int(4) not null,

    `created_at` timestamp NOT NULL default current_timestamp,
    `updated_at` timestamp NOT NULL default current_timestamp,

    primary key(serial_number),
    constraint `trains_line_id_foreign`
    foreign key (`line_id`) references `lines` (`id`)
)
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci; 
