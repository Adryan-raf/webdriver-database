CREATE ROLE IF NOT EXISTS 'PapelEmpresa';

GRANT SELECT ON web_driver.view_empresa_usuarios TO 'PapelEmpresa';

GRANT SELECT ON web_driver.view_empresa_arquivos TO 'PapelEmpresa';

CREATE USER IF NOT EXISTS 'empresa'@'localhost' IDENTIFIED BY 'empresa123';

GRANT 'PapelEmpresa' TO 'empresa'@'localhost';

SET DEFAULT ROLE 'PapelEmpresa' TO 'empresa'@'localhost';
