CREATE ROLE IF NOT EXISTS 'PapelUsuario';

GRANT SELECT ON web_driver.view_usuario TO 'PapelUsuario';

GRANT INSERT, UPDATE ON web_driver.Arquivo TO 'PapelUsuario';

GRANT SELECT ON web_driver.view_usuario_historico TO 'PapelUsuario';