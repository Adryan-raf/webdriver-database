# UNIVERSIDADE CATÓLICA DE PERNAMBUCO
<p align="center">
   <img src="http://www1.unicap.br/icam/wp-content/uploads/2019/06/marca_nova.svg" />
  </p>

# WebDriver | Banco de Dados

Este é o projeto final para a disciplina de Projeto de Banco de Dados, no qual desenvolvemos um banco de dados para um sistema CRUD utilizando o SGBD MySQL. O projeto abrange todo o ciclo de vida de um banco de dados, incluindo criação de diagramas, scripts,cmanipulação e documentação detalhada.

## Fluxo de desenvolvimento

Este repositório foi organizado em uma branch de feature para a interface web e em branches de apoio para a modelagem do banco.

A estrutura atual combina:
- a base de dados em `database/`
- a aplicação em `web/`
- a organização de documentação e dependências na raiz do projeto

Para uso local, a sequência normal é:
1. criar as tabelas e views do banco
2. configurar o arquivo `.env`
3. instalar dependências com `pip install -r requirements.txt`
4. iniciar a aplicação com `python web/app.py`

## Diagramas

### Diagrama Conceitual do Banco de Dados
---

![Diagrama de Esquema](https://github.com/Adryan-raf/webdriver-database/blob/fix/diagrama/Diagramas/DiagramaConceitualBD.drawio.png)

---

### Diagrama Lógico do Banco de Dados
---

![Diagrama Logico](https://github.com/Adryan-raf/webdriver-database/blob/fix/diagrama/Diagramas/DiagramaLogicoBD.drawio.png)

---

## Tecnologias
 
| Tecnologia | Uso |
|---|---|
| MySQL | Sistema gerenciador de banco de dados |
| SQL | Criação, manipulação e consulta dos dados |
| Flask | Linguagem de apoio utilizada |
| `<fix/diagramas>` | Modelagem dos diagramas conceitual e lógico |

## Scripts SQL

Os scripts SQL estão organizados no diretório `scripts/`. Destacamos alguns dos principais scripts:

- `/Criação/`: 
- `/População/`: 
- `/Consulta/`:

---

## Autoria
* Autor: Luana Larissa
* Autor: Adryan Rafael
* Autor: Jonas Mendes
* Autor: Lucas Vinicius
