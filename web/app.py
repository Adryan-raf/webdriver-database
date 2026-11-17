from datetime import date, datetime

from flask import Flask, redirect, render_template, request, url_for
import mysql.connector

from db import consultar, executar, get_connection

app = Flask(__name__)


def formatar_data(valor):
    if valor is None:
        return ""
    if isinstance(valor, (date, datetime)):
        return valor.strftime("%Y-%m-%d")
    return str(valor)


def formatar_datetime(valor):
    if valor is None:
        return ""
    if isinstance(valor, datetime):
        return valor.strftime("%Y-%m-%d %H:%M:%S")
    return str(valor)


@app.route("/")
def inicio():
    try:
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT 1")
        cursor.fetchone()
        cursor.close()
        conn.close()
        ok, msg = True, "Conexao com web_driver ok."
    except mysql.connector.Error as erro:
        ok, msg = False, str(erro)
    return render_template("inicio.html", conexao_ok=ok, mensagem_conexao=msg)


@app.route("/planos", methods=["GET", "POST"])
def planos():
    mensagem = None
    ok = True
    if request.method == "POST":
        ok, mensagem = executar(
            """
            INSERT INTO Plano (nome, duracao, data_aquisicao, espaco_por_usuario)
            VALUES (%s, %s, %s, %s)
            """,
            (
                request.form["nome"],
                request.form["duracao"],
                request.form["data_aquisicao"],
                request.form["espaco_por_usuario"],
            ),
        )
    itens = consultar("SELECT * FROM Plano ORDER BY id")
    return render_template("planos.html", itens=itens, mensagem=mensagem, ok=ok)


@app.route("/planos/<int:id>/excluir")
def planos_excluir(id):
    ok, mensagem = executar("DELETE FROM Plano WHERE id = %s", (id,))
    itens = consultar("SELECT * FROM Plano ORDER BY id")
    return render_template("planos.html", itens=itens, mensagem=mensagem, ok=ok)


@app.route("/instituicoes", methods=["GET", "POST"])
def instituicoes():
    mensagem = None
    ok = True
    if request.method == "POST":
        ok, mensagem = executar(
            """
            INSERT INTO Instituicao (nome, endereco, causa_social, id_plano)
            VALUES (%s, %s, %s, %s)
            """,
            (
                request.form["nome"],
                request.form["endereco"],
                request.form["causa_social"],
                request.form["id_plano"],
            ),
        )
    itens = consultar("SELECT * FROM Instituicao ORDER BY id")
    planos_lista = consultar("SELECT id, nome FROM Plano ORDER BY id")
    return render_template(
        "instituicoes.html",
        itens=itens,
        planos=planos_lista,
        mensagem=mensagem,
        ok=ok,
    )


@app.route("/instituicoes/<int:id>/excluir")
def instituicoes_excluir(id):
    ok, mensagem = executar("DELETE FROM Instituicao WHERE id = %s", (id,))
    itens = consultar("SELECT * FROM Instituicao ORDER BY id")
    planos_lista = consultar("SELECT id, nome FROM Plano ORDER BY id")
    return render_template(
        "instituicoes.html",
        itens=itens,
        planos=planos_lista,
        mensagem=mensagem,
        ok=ok,
    )


@app.route("/usuarios", methods=["GET", "POST"])
def usuarios():
    mensagem = None
    ok = True
    if request.method == "POST":
        if request.form.get("id"):
            ok, mensagem = executar(
                """
                UPDATE Usuario
                SET login=%s, senha=%s, nome=%s, email=%s,
                    data_ingresso=%s, id_instituicao=%s
                WHERE id=%s
                """,
                (
                    request.form["login"],
                    request.form["senha"],
                    request.form["nome"],
                    request.form["email"],
                    request.form["data_ingresso"],
                    request.form["id_instituicao"],
                    request.form["id"],
                ),
            )
        else:
            ok, mensagem = executar(
                """
                INSERT INTO Usuario
                    (login, senha, data_ingresso, email, nome, id_instituicao)
                VALUES (%s, %s, %s, %s, %s, %s)
                """,
                (
                    request.form["login"],
                    request.form["senha"],
                    request.form["data_ingresso"],
                    request.form["email"],
                    request.form["nome"],
                    request.form["id_instituicao"],
                ),
            )
        if ok and request.form.get("id"):
            return redirect(url_for("usuarios"))

    itens = consultar("SELECT * FROM Usuario ORDER BY id")
    for u in itens:
        u["data_ingresso"] = formatar_data(u["data_ingresso"])
    instituicoes = consultar("SELECT id, nome FROM Instituicao ORDER BY id")
    return render_template(
        "usuarios.html",
        itens=itens,
        instituicoes=instituicoes,
        editando=None,
        mensagem=mensagem,
        ok=ok,
    )


@app.route("/usuarios/<int:id>/editar")
def usuarios_editar(id):
    itens = consultar("SELECT * FROM Usuario ORDER BY id")
    for u in itens:
        u["data_ingresso"] = formatar_data(u["data_ingresso"])
    editando = consultar("SELECT * FROM Usuario WHERE id = %s", (id,))
    editando = editando[0] if editando else None
    if editando:
        editando["data_ingresso"] = formatar_data(editando["data_ingresso"])
    instituicoes = consultar("SELECT id, nome FROM Instituicao ORDER BY id")
    return render_template(
        "usuarios.html",
        itens=itens,
        instituicoes=instituicoes,
        editando=editando,
        mensagem=None,
        ok=True,
    )


@app.route("/usuarios/<int:id>/excluir")
def usuarios_excluir(id):
    ok, mensagem = executar("DELETE FROM Usuario WHERE id = %s", (id,))
    itens = consultar("SELECT * FROM Usuario ORDER BY id")
    for u in itens:
        u["data_ingresso"] = formatar_data(u["data_ingresso"])
    instituicoes = consultar("SELECT id, nome FROM Instituicao ORDER BY id")
    return render_template(
        "usuarios.html",
        itens=itens,
        instituicoes=instituicoes,
        editando=None,
        mensagem=mensagem,
        ok=ok,
    )


@app.route("/arquivos", methods=["GET", "POST"])
def arquivos():
    mensagem = None
    ok = True
    if request.method == "POST":
        dados = (
            request.form["nome"],
            request.form["tipo"],
            int(request.form["permissao_acesso"]),
            request.form["tamanho"],
            request.form["data_ultima_mod"],
            request.form["localizacao"],
            request.form["url"],
            request.form["id_usuario"],
        )
        if request.form.get("id"):
            ok, mensagem = executar(
                """
                UPDATE Arquivo
                SET nome=%s, tipo=%s, permissao_acesso=%s, tamanho=%s,
                    data_ultima_mod=%s, localizacao=%s, url=%s, id_usuario=%s
                WHERE id=%s
                """,
                dados + (request.form["id"],),
            )
            if ok:
                return redirect(url_for("arquivos"))
        else:
            ok, mensagem = executar(
                """
                INSERT INTO Arquivo
                    (nome, tipo, permissao_acesso, tamanho, data_ultima_mod,
                     localizacao, url, id_usuario)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
                """,
                dados,
            )

    itens = consultar("SELECT * FROM Arquivo ORDER BY id")
    for a in itens:
        a["data_ultima_mod"] = formatar_datetime(a["data_ultima_mod"])
    usuarios = consultar("SELECT id, login FROM Usuario ORDER BY id")
    return render_template(
        "arquivos.html",
        itens=itens,
        usuarios=usuarios,
        editando=None,
        mensagem=mensagem,
        ok=ok,
    )


@app.route("/arquivos/<int:id>/editar")
def arquivos_editar(id):
    itens = consultar("SELECT * FROM Arquivo ORDER BY id")
    for a in itens:
        a["data_ultima_mod"] = formatar_datetime(a["data_ultima_mod"])
    editando = consultar("SELECT * FROM Arquivo WHERE id = %s", (id,))
    editando = editando[0] if editando else None
    if editando:
        editando["data_ultima_mod"] = formatar_datetime(editando["data_ultima_mod"])
    usuarios = consultar("SELECT id, login FROM Usuario ORDER BY id")
    return render_template(
        "arquivos.html",
        itens=itens,
        usuarios=usuarios,
        editando=editando,
        mensagem=None,
        ok=True,
    )


@app.route("/arquivos/<int:id>/excluir")
def arquivos_excluir(id):
    ok, mensagem = executar("DELETE FROM Arquivo WHERE id = %s", (id,))
    itens = consultar("SELECT * FROM Arquivo ORDER BY id")
    for a in itens:
        a["data_ultima_mod"] = formatar_datetime(a["data_ultima_mod"])
    usuarios = consultar("SELECT id, login FROM Usuario ORDER BY id")
    return render_template(
        "arquivos.html",
        itens=itens,
        usuarios=usuarios,
        editando=None,
        mensagem=mensagem,
        ok=ok,
    )


@app.route("/compartilhamentos", methods=["GET", "POST"])
def compartilhamentos():
    mensagem = None
    ok = True
    if request.method == "POST":
        ok, mensagem = executar(
            """
            INSERT INTO Acesso_Arquivo (id_usuario, id_arquivo)
            VALUES (%s, %s)
            """,
            (request.form["id_usuario"], request.form["id_arquivo"]),
        )
    itens = consultar("SELECT * FROM Acesso_Arquivo ORDER BY id_arquivo, id_usuario")
    usuarios = consultar("SELECT id, login FROM Usuario ORDER BY id")
    arquivos_lista = consultar("SELECT id, nome FROM Arquivo ORDER BY id")
    return render_template(
        "compartilhamentos.html",
        itens=itens,
        usuarios=usuarios,
        arquivos=arquivos_lista,
        mensagem=mensagem,
        ok=ok,
    )


@app.route("/compartilhamentos/<int:id_usuario>/<int:id_arquivo>/excluir")
def compartilhamentos_excluir(id_usuario, id_arquivo):
    ok, mensagem = executar(
        """
        DELETE FROM Acesso_Arquivo
        WHERE id_usuario = %s AND id_arquivo = %s
        """,
        (id_usuario, id_arquivo),
    )
    itens = consultar("SELECT * FROM Acesso_Arquivo ORDER BY id_arquivo, id_usuario")
    usuarios = consultar("SELECT id, login FROM Usuario ORDER BY id")
    arquivos_lista = consultar("SELECT id, nome FROM Arquivo ORDER BY id")
    return render_template(
        "compartilhamentos.html",
        itens=itens,
        usuarios=usuarios,
        arquivos=arquivos_lista,
        mensagem=mensagem,
        ok=ok,
    )


@app.route("/comentarios", methods=["GET", "POST"])
def comentarios():
    mensagem = None
    ok = True
    if request.method == "POST":
        ok, mensagem = executar(
            """
            INSERT INTO Comentario (data, hora, conteudo, id_usuario, id_arquivo)
            VALUES (%s, %s, %s, %s, %s)
            """,
            (
                request.form["data"],
                request.form["hora"],
                request.form["conteudo"],
                request.form["id_usuario"],
                request.form["id_arquivo"],
            ),
        )
    itens = consultar("SELECT * FROM Comentario ORDER BY id DESC")
    usuarios = consultar("SELECT id, login FROM Usuario ORDER BY id")
    arquivos_lista = consultar("SELECT id, nome FROM Arquivo ORDER BY id")
    return render_template(
        "comentarios.html",
        itens=itens,
        usuarios=usuarios,
        arquivos=arquivos_lista,
        mensagem=mensagem,
        ok=ok,
    )


@app.route("/comentarios/<int:id>/excluir")
def comentarios_excluir(id):
    ok, mensagem = executar("DELETE FROM Comentario WHERE id = %s", (id,))
    itens = consultar("SELECT * FROM Comentario ORDER BY id DESC")
    usuarios = consultar("SELECT id, login FROM Usuario ORDER BY id")
    arquivos_lista = consultar("SELECT id, nome FROM Arquivo ORDER BY id")
    return render_template(
        "comentarios.html",
        itens=itens,
        usuarios=usuarios,
        arquivos=arquivos_lista,
        mensagem=mensagem,
        ok=ok,
    )


@app.route("/suporte", methods=["GET", "POST"])
def suporte():
    mensagem = None
    ok = True
    if request.method == "POST":
        id_arquivo = request.form.get("id_arquivo") or None
        ok, mensagem = executar(
            """
            INSERT INTO Suporte
                (dia, hora, descricao, id_usuario, id_admin, id_arquivo)
            VALUES (%s, %s, %s, %s, %s, %s)
            """,
            (
                request.form["dia"],
                request.form["hora"],
                request.form["descricao"],
                request.form["id_usuario"],
                request.form["id_admin"],
                id_arquivo,
            ),
        )
    itens = consultar("SELECT * FROM Suporte ORDER BY id DESC")
    usuarios = consultar("SELECT id, login FROM Usuario ORDER BY id")
    admins = consultar("SELECT id, id_usuario FROM Administrador ORDER BY id")
    arquivos_lista = consultar("SELECT id, nome FROM Arquivo ORDER BY id")
    return render_template(
        "suporte.html",
        itens=itens,
        usuarios=usuarios,
        admins=admins,
        arquivos=arquivos_lista,
        mensagem=mensagem,
        ok=ok,
    )


@app.route("/suporte/admin", methods=["POST"])
def suporte_criar_admin():
    ok, mensagem = executar(
        "INSERT INTO Administrador (id_usuario) VALUES (%s)",
        (request.form["id_usuario"],),
    )
    itens = consultar("SELECT * FROM Suporte ORDER BY id DESC")
    usuarios = consultar("SELECT id, login FROM Usuario ORDER BY id")
    admins = consultar("SELECT id, id_usuario FROM Administrador ORDER BY id")
    arquivos_lista = consultar("SELECT id, nome FROM Arquivo ORDER BY id")
    return render_template(
        "suporte.html",
        itens=itens,
        usuarios=usuarios,
        admins=admins,
        arquivos=arquivos_lista,
        mensagem=mensagem,
        ok=ok,
    )


@app.route("/suporte/<int:id>/excluir")
def suporte_excluir(id):
    ok, mensagem = executar("DELETE FROM Suporte WHERE id = %s", (id,))
    itens = consultar("SELECT * FROM Suporte ORDER BY id DESC")
    usuarios = consultar("SELECT id, login FROM Usuario ORDER BY id")
    admins = consultar("SELECT id, id_usuario FROM Administrador ORDER BY id")
    arquivos_lista = consultar("SELECT id, nome FROM Arquivo ORDER BY id")
    return render_template(
        "suporte.html",
        itens=itens,
        usuarios=usuarios,
        admins=admins,
        arquivos=arquivos_lista,
        mensagem=mensagem,
        ok=ok,
    )


@app.route("/historico")
def historico():
    itens = consultar("SELECT * FROM Historico ORDER BY id DESC")
    return render_template("historico.html", itens=itens, mensagem=None, ok=True)


if __name__ == "__main__":
    app.run(debug=True)
