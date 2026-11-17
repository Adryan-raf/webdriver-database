# Interface web (Flask) — Web Driver

Interface minima para demonstrar o CRUD do banco `web_driver`.
Feita de proposito bem simples: HTML basico, poucas rotas e SQL
parametrizado. Serve para apresentar a Parte 1/2 do projeto e explicar
cada operacao em sala.

## O que esta pasta tem

| Arquivo / pasta | Funcao |
| --- | --- |
| `app.py` | Rotas Flask (listar, inserir, atualizar, excluir) |
| `db.py` | Conexao MySQL e funcoes `consultar` / `executar` |
| `templates/` | Paginas HTML |
| `static/style.css` | CSS simples |
| `README.md` | Este guia |

## Tabelas cobertas

- **Plano** — cadastrar, listar, excluir
- **Instituicao** — cadastrar, listar, excluir
- **Usuario** — cadastrar, listar, editar, excluir
- **Arquivo** — cadastrar, listar, editar, excluir
- **Acesso_Arquivo** — compartilhar, listar, remover
- **Comentario** — cadastrar, listar, excluir
- **Suporte** — criar admin, cadastrar solicitacao, listar, excluir
- **Historico** — somente leitura

Nao ha login na aplicacao. A conexao usa o usuario do MySQL do arquivo `.env`.

## Pre-requisitos

1. MySQL 8 com o schema do projeto criado.
2. Scripts em `database/` executados na ordem do `database/README.md`
   (pelo menos `ddl/01_criacao-bd.sql` e `ddl/02_criacao-entidade.sql`).
3. Python 3 com `venv`.

## Configuracao

Na raiz do repositorio:

```powershell
copy .env.example .env
```

Edite `.env`. O banco correto agora e `web_driver`:

```text
MYSQL_HOST=127.0.0.1
MYSQL_PORT=3306
MYSQL_USER=root
MYSQL_PASSWORD=sua_senha
MYSQL_DATABASE=web_driver
```

Instale as dependencias:

```powershell
python -m venv venv
.\venv\Scripts\activate
pip install -r requirements.txt
```

## Como rodar

```powershell
cd web
python app.py
```

Abra: http://127.0.0.1:5000/

## Ordem sugerida de teste

1. Criar um **Plano**
2. Criar uma **Instituicao** ligada ao plano
3. Criar um **Usuario**
4. Criar um **Arquivo** (evite extensao `.exe` — a trigger `Safe_security` bloqueia)
5. Testar compartilhamento, comentario e suporte
6. Conferir **Historico** (pode estar vazio se nada gravou la ainda)

## Como o codigo funciona (para explicar)

1. O navegador chama uma rota em `app.py`.
2. A rota monta um SQL com `%s` (nunca concatena input na string).
3. `db.py` abre a conexao, executa e fecha.
4. Erros do MySQL (FK, UNIQUE, trigger) aparecem na propria pagina.

Exemplo: excluir um usuario que ainda tem arquivo deve falhar por FK.
Isso e esperado e mostra a integridade do banco.

## Limitacoes (proposital)

- Visual bem basico
- Senha do usuario salva como digitada (igual aos exemplos do `dml/`)
- Sem upload real de arquivo — so metadados
- Sem Roles/Views na interface (isso fica no MySQL)
- Delete por link GET (ok para demo academica; em producao usaria POST)

## Problemas comuns

- `Unknown database 'web_driver'` → rode o DDL ou ajuste o `.env`
- `Unknown database 'webdriver_db'` → nome antigo; troque para `web_driver`
- Dropdown vazio → cadastre plano/instituicao/usuario antes
- Erro ao salvar `.exe` → trigger de seguranca do banco
