-- CREATE USER 'nome de usuario'@'local' IDENTIFIED BY 'senha';
SET GLOBAL validate_password_policy = LOW;
-- CREATE USER 'luciano'@'127.450.204.812' IDENTIFIED BY 'admin'; -- localidade especifica 
-- CREATE USER 'luciano'@'%' IDENTIFIED BY 'admin'; -- qualquer localização
CREATE USER 'luciano'@'localhost' IDENTIFIED BY 'erick123456'; -- minha maquina 
GRANT ALL ON curso_sql.* TO 'luciano'@'localhost'; -- dá total acesso ao banco a partir da minha maquina
 
CREATE USER 'luciano'@'%' IDENTIFIED BY 'luciano.viagem';
GRANT SELECT ON curso_sql.* TO 'luciano'@'%'; -- dá acesso só ao select [vizualização] 
-- GRANT INSERT ON curso_sql.* TO 'luciano'@'%'; 

GRANT INSERT ON curso_sql.funcionarios TO 'luciano'@'%';


REVOKE INSERT ON curso_sql.funcionarios FROM 'luciano'@'%';
REVOKE SELECT ON curso_sql.* FROM 'luciano'@'%';

GRANT SELECT ON curso_sql.funcionarios TO 'luciano'@'%';
GRANT SELECT ON curso_sql.veiculos TO 'luciano'@'%';

REVOKE ALL ON curso_sql.* FROM 'luciano'@'localhost';

DROP USER 'luciano'@'%';
DROP USER 'luciano'@'localhost';

SELECT User FROM mysql.user;
SHOW GRANTS FOR 'luciano'@'%';