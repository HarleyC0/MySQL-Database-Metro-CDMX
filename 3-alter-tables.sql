USE metro_cdmx;

Alter table `stations` 
modify `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

Alter table `stations` 
modify `name` varchar(50) not null;

