const express = require("express");
const sql = require("mssql");
const cors = require("cors");


const app = express();
app.use(express.json());
app.use(cors());
app.use(express.static('public'));


// Configuração do banco de dados
const dbConfig = {
    user: "sa",
    password: "password",
    server: "localhost",
    database: "DB_BIBLIOTECA",
    options: { 
        trustServerCertificate: true,
        encrypt: false,
    }
};

// Conectar ao banco
sql.connect(dbConfig)
    .then(() => console.log("Banco de dados conectado com sucesso!"))
    .catch(err => console.log("Erro ao conectar ao banco:", err));

/* ===================== CRUD - LIVROS ===================== */

// Criar livro
app.post("/api/livros", async (req, res) => {
    const { isbn, titulo, autor, editora, anoPublicacao, genero } = req.body;

    try {
        await sql.query`INSERT INTO Livros VALUES (${isbn}, ${titulo}, ${autor}, ${editora}, ${anoPublicacao}, ${genero})`;
        res.status(201).send("Livro cadastrado com sucesso!");
    } catch (error) {
        res.status(500).send("Erro ao cadastrar livro: " + error);
    }
});


// Listar livros
app.get("/api/livros", async (req, res) => {
    try {
        const result = await sql.query`SELECT * FROM Livros`;  // Certifique-se de que o nome da tabela esteja correto
        console.log(result.recordset);  // Log para verificar os dados que estão sendo retornados
        res.status(200).json(result.recordset);  // Retorna os livros como JSON
    } catch (error) {
        console.error('Erro ao buscar livros:', error);
        res.status(500).send("Erro ao buscar livros");
    }
});


// Atualizar livro
app.put("/api/livros/:isbn", async (req, res) => {
    const { isbn } = req.params;
    const { titulo, autor, editora, anoPublicacao, genero } = req.body;

    try {
        await sql.query`UPDATE Livros SET Titulo=${titulo}, Autor=${autor}, Editora=${editora}, AnoPublicacao=${anoPublicacao}, Genero=${genero} WHERE ISBN=${isbn}`;
        res.send("Livro atualizado com sucesso!");
    } catch (error) {
        res.status(500).send("Erro ao atualizar livro: " + error);
    }
});

// Buscar um único livro por ISBN
app.get("/api/livros/:isbn", async (req, res) => {
    const { isbn } = req.params;

    try {
        const result = await sql.query`
            SELECT ISBN, Titulo, Autor, Editora, AnoPublicacao, Genero
            FROM Livros
            WHERE ISBN = ${isbn}
        `;

        if (result.recordset.length > 0) {
            res.json(result.recordset[0]); // Retorna o primeiro resultado encontrado
        } else {
            res.status(404).send("Livro não encontrado.");
        }
    } catch (error) {
        console.error("Erro ao buscar livro:", error);
        res.status(500).send("Erro ao buscar livro.");
    }
});


// Deletar livro
app.delete("/api/livros/:isbn", async (req, res) => {
    const { isbn } = req.params;

    try {
        await sql.query`DELETE FROM Livros WHERE ISBN=${isbn}`;
        res.send("Livro excluído com sucesso!");
    } catch (error) {
        res.status(500).send("Erro ao excluir livro: " + error);
    }
});

/* ===================== CRUD - USUÁRIOS ===================== */

// Criar usuário
app.post("/api/usuarios", async (req, res) => {
    const { email, nome, endereco, telefone, categoria } = req.body;

    try {
        await sql.query`INSERT INTO Usuarios VALUES (${email}, ${nome}, ${endereco}, ${telefone}, ${categoria})`;
        res.status(201).send("Usuário cadastrado com sucesso!");
    } catch (error) {
        res.status(500).send("Erro ao cadastrar usuário: " + error);
    }
});

// Listar usuários
app.get("/api/usuarios", async (req, res) => {
    try {
        const result = await sql.query("SELECT * FROM Usuarios");
        res.json(result.recordset);
    } catch (error) {
        res.status(500).send("Erro ao buscar usuários: " + error);
    }
});

// Atualizar usuário
app.put("/api/usuarios/:email", async (req, res) => {
    const { email } = req.params;
    const { nome, endereco, telefone, categoria } = req.body;

    console.log("Recebendo atualização:", req.body); // ← Depuração

    try {
        await sql.query`UPDATE Usuarios SET Nome=${nome}, Endereco=${endereco}, Telefone=${telefone}, Categoria=${categoria} WHERE Email=${email}`;
        res.send("Usuário atualizado com sucesso!");
    } catch (error) {
        console.error("Erro ao atualizar usuário:", error);
        res.status(500).send("Erro ao atualizar usuário.");
    }
});


// Deletar usuário
app.delete("/api/usuarios/:email", async (req, res) => {
    const { email } = req.params;

    try {
        await sql.query`DELETE FROM Usuarios WHERE Email=${email}`;
        res.send("Usuário excluído com sucesso!");
    } catch (error) {
        res.status(500).send("Erro ao excluir usuário: " + error);
    }
});

/* ===================== CRUD - EMPRÉSTIMOS ===================== */

// Criar empréstimo
app.post("/api/emprestimos", async (req, res) => {
    const { isbn, emailUsuario, dataRetirada, dataDevolucaoPrevista } = req.body;

    console.log("Recebendo novo empréstimo:", req.body); // Depuração

    try {
        // Verifique se os campos estão vindo corretamente
        if (!isbn || !emailUsuario || !dataRetirada || !dataDevolucaoPrevista) {
            return res.status(400).send("Erro: Dados incompletos.");
        }

        // Verifica se o livro e o usuário existem
        const livroExiste = await sql.query`SELECT * FROM Livros WHERE ISBN = ${isbn}`;
        if (livroExiste.recordset.length === 0) {
            return res.status(400).send("Erro: Livro não encontrado.");
        }

        const usuarioExiste = await sql.query`SELECT * FROM Usuarios WHERE Email = ${emailUsuario}`;
        if (usuarioExiste.recordset.length === 0) {
            return res.status(400).send("Erro: Usuário não encontrado.");
        }

        // Agora, inserimos o empréstimo
        await sql.query`
            INSERT INTO Emprestimos (ISBN, EmailUsuario, DataRetirada, DataDevolucaoPrevista)
            VALUES (${isbn}, ${emailUsuario}, ${dataRetirada}, ${dataDevolucaoPrevista})
        `;

        res.status(201).send("Empréstimo registrado com sucesso!");
    } catch (error) {
        console.error("Erro ao registrar empréstimo:", error);
        res.status(500).send("Erro ao registrar empréstimo.");
    }
});

const formatDate = (date) => {
    if (!date) return null;
    const d = new Date(date);
    // Garantir que a data está no formato DD-MM-YYYY, ajustando para o fuso horário local
    const day = String(d.getUTCDate()).padStart(2, '0'); // Dia
    const month = String(d.getUTCMonth() + 1).padStart(2, '0'); // Mês
    const year = String(d.getUTCFullYear()).padStart(4, '0'); // Ano com 4 dígitos
    return `${day}-${month}-${year}`;
};


// Listar empréstimos
app.get("/api/emprestimos", async (req, res) => {
    try {
        const result = await sql.query("SELECT * FROM Emprestimos");

        // Formatar as datas para o formato DD-MM-YYYY
        const emprestimos = result.recordset.map(emprestimo => {
            return {
                ...emprestimo,
                DataRetirada: formatDate(emprestimo.DataRetirada),
                DataDevolucaoPrevista: formatDate(emprestimo.DataDevolucaoPrevista),
                DataDevolucaoReal: emprestimo.DataDevolucaoReal ? formatDate(emprestimo.DataDevolucaoReal) : null
            };
        });

        res.json(emprestimos);
    } catch (error) {
        res.status(500).send("Erro ao buscar empréstimos: " + error);
    }
});



// Atualizar empréstimo (adicionar DataDevolucaoReal)
app.put("/api/emprestimos/:id", async (req, res) => {
    const { id } = req.params;
    const { dataDevolucaoReal } = req.body;

    console.log("Recebendo atualização:", req.body); // ← Depuração

    try {
        await sql.query`UPDATE Emprestimos SET DataDevolucaoReal=${dataDevolucaoReal} WHERE ID=${id}`;
        res.send("Empréstimo atualizado com sucesso!");
    } catch (error) {
        console.error("Erro ao atualizar empréstimo:", error);
        res.status(500).send("Erro ao atualizar empréstimo.");
    }
});


// Deletar empréstimo
app.delete("/api/emprestimos/:id", async (req, res) => {
    const { id } = req.params;

    try {
        await sql.query`DELETE FROM Emprestimos WHERE ID=${id}`;
        res.send("Empréstimo excluído com sucesso!");
    } catch (error) {
        res.status(500).send("Erro ao excluir empréstimo: " + error);
    }
});

/* ===================== INICIAR SERVIDOR ===================== */

const PORT = 3000;
app.listen(PORT, () => console.log(`Servidor rodando na porta ${PORT}`));
