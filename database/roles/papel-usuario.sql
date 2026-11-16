CREATE ROLE IF NOT EXISTS 'PapelUsuario';

GRANT SELECT ON web_driver.view_usuario TO 'PapelUsuario';

GRANT SELECT ON web_driver.view_usuario_historico TO 'PapelUsuario';

GRANT INSERT, UPDATE ON web_driver.Arquivo TO 'PapelUsuario';

CREATE USER IF NOT EXISTS 'usuario'@'localhost' IDENTIFIED BY 'usuario123';

GRANT 'PapelUsuario' TO 'usuario'@'localhost';

SET DEFAULT ROLE 'PapelUsuario' TO 'usuario'@'localhost';