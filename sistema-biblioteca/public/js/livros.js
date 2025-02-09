document.getElementById("livroForm").addEventListener("submit", async function(event) {
    event.preventDefault();
    
    const livro = {
        isbn: document.getElementById("isbn").value,
        titulo: document.getElementById("titulo").value,
        autor: document.getElementById("autor").value,
        editora: document.getElementById("editora").value,
        anoPublicacao: document.getElementById("anoPublicacao").value,
        genero: document.getElementById("genero").value
    };

    try {
        const response = await fetch("/api/livros", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(livro)
        });

        if (response.ok) {
            alert("Livro cadastrado com sucesso!");
            location.reload();
        } else {
            const errorMessage = await response.text();
            alert("Erro ao cadastrar livro: " + errorMessage);
        }
    } catch (error) {
        console.error("Erro ao enviar dados:", error);
        alert("Erro ao enviar dados.");
    }
});

document.addEventListener("DOMContentLoaded", async function() {
    // Função para carregar os livros na tabela
    async function carregarLivros() {
        try {
            const response = await fetch("/api/livros");
            if (response.ok) {
                const livros = await response.json();  // Recebe os livros como JSON
                
                const tabelaLivros = document.getElementById("tabelaLivros").getElementsByTagName('tbody')[0];
                tabelaLivros.innerHTML = ""; // Limpa a tabela antes de adicionar os livros

                livros.forEach(livro => {
                    const row = tabelaLivros.insertRow();
                    row.innerHTML = `
                        <td>${livro.ISBN}</td>
                        <td>${livro.Titulo}</td>
                        <td>${livro.Autor}</td>
                        <td>${livro.Editora}</td>
                        <td>${livro.AnoPublicacao}</td>
                        <td>${livro.Genero}</td>
                        <td>
                            <button onclick="editarLivro('${livro.ISBN}')">Editar</button>
                            <button onclick="deletarLivro('${livro.ISBN}')">Deletar</button>
                        </td>
                    `;
                });
            } else {
                alert("Erro ao carregar livros.");
            }
        } catch (error) {
            console.error("Erro ao carregar livros:", error);
            alert("Erro ao carregar livros.");
        }
    }

    // Chama a função para carregar os livros assim que a página for carregada
    carregarLivros();
});

async function deletarLivro(isbn) {
    if (!confirm("Tem certeza que deseja excluir este livro?")) return;

    try {
        const response = await fetch(`/api/livros/${isbn}`, {
            method: "DELETE"
        });

        if (response.ok) {
            alert("Livro excluído com sucesso!");
            location.reload();
        } else {
            alert("Erro ao excluir livro.");
        }
    } catch (error) {
        console.error("Erro ao excluir livro:", error);
        alert("Erro ao excluir livro.");
    }
}

async function editarLivro(isbn) {
    try {
        const response = await fetch(`/api/livros/${isbn}`);
        if (response.ok) {
            const livro = await response.json();

            // Preenche os campos do formulário
            document.getElementById("isbn").value = livro.ISBN;
            document.getElementById("titulo").value = livro.Titulo;
            document.getElementById("autor").value = livro.Autor;
            document.getElementById("editora").value = livro.Editora;
            document.getElementById("anoPublicacao").value = livro.AnoPublicacao;
            document.getElementById("genero").value = livro.Genero;

            // Desabilita o campo ISBN para evitar alterações
            document.getElementById("isbn").disabled = true;

            // Altera o título do formulário para "Atualizando Livro"
            document.getElementById("titulo-form").textContent = "Atualizando Livro";

            // Muda o botão para "Atualizar Livro"
            const botao = document.querySelector("#livroForm button");
            botao.textContent = "Atualizar Livro";
            botao.onclick = async function (event) {
                event.preventDefault();
                await atualizarLivro(isbn);
            };
        } else {
            alert("Erro ao buscar livro para edição.");
        }
    } catch (error) {
        console.error("Erro ao buscar livro:", error);
        alert("Erro ao buscar livro.");
    }
}

async function atualizarLivro(isbn) {
    const livro = {
        titulo: document.getElementById("titulo").value,
        autor: document.getElementById("autor").value,
        editora: document.getElementById("editora").value,
        anoPublicacao: document.getElementById("anoPublicacao").value,
        genero: document.getElementById("genero").value
    };

    try {
        const response = await fetch(`/api/livros/${isbn}`, {
            method: "PUT",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(livro)
        });

        if (response.ok) {
            alert("Livro atualizado com sucesso!");

            document.getElementById("titulo-form").textContent = "Adicionar Livro";

            location.reload();
        } else {
            alert("Erro ao atualizar livro.");
        }
    } catch (error) {
        console.error("Erro ao atualizar livro:", error);
        alert("Erro ao atualizar livro.");
    }
}
