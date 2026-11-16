CREATE ROLE IF NOT EXISTS 'PapelAdm';

GRANT SELECT, INSERT, UPDATE, DELETE ON web_driver.Plano TO 'PapelAdm';

GRANT SELECT, INSERT, UPDATE, DELETE ON web_driver.Instituicao TO 'PapelAdm';

GRANT SELECT, INSERT, UPDATE, DELETE ON web_driver.Usuario TO 'PapelAdm';

GRANT SELECT, INSERT, UPDATE, DELETE ON web_driver.Administrador TO 'PapelAdm';

GRANT SELECT, INSERT, UPDATE, DELETE ON web_driver.Arquivo TO 'PapelAdm';

GRANT SELECT, INSERT, UPDATE, DELETE ON web_driver.Suporte TO 'PapelAdm';

GRANT SELECT, INSERT, UPDATE, DELETE ON web_driver.Opera TO 'PapelAdm';

GRANT SELECT, INSERT, UPDATE, DELETE ON web_driver.Comentario TO 'PapelAdm';

GRANT SELECT, INSERT, UPDATE, DELETE ON web_driver.Historico TO 'PapelAdm';

GRANT SELECT, INSERT, UPDATE, DELETE ON web_driver.Acesso_Arquivo TO 'PapelAdm';

CREATE USER IF NOT EXISTS 'administrador'@'localhost' IDENTIFIED BY 'adm123';

GRANT 'PapelAdm' TO 'administrador'@'localhost';

SET DEFAULT ROLE 'PapelAdm' TO 'administrador'@'localhost';