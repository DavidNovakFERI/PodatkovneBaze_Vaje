CREATE USER 'superman'@'%' IDENTIFIED BY 'geslo';	

ALTER USER 'superman'@'%' IDENTIFIED BY 'novo_geslo';
FLUSH PRIVILEGES;


SHOW GRANTS for 'superman'@'%';

CREATE DATABASE nova_baza;
GRANT ALL PRIVILEGES ON nova_baza.* TO 'superman'@'%';	
SHOW GRANTS for 'superman'@'%';
REVOKE ALL PRIVILEGES ON nova_baza.* FROM 'superman'@'%';
SHOW GRANTS for 'superman'@'%';


DROP DATABASE nova_baza;

DROP USER 'superman'@'%';