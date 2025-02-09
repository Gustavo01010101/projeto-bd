document.addEventListener("DOMContentLoaded", carregarUsuarios);

const usuarioForm = document.getElementById("usuarioForm");
const tituloForm = document.querySelector("h2"); 
let usuarioEditando = null; 

async function carregarUsuarios() {
    const resposta = await fetch("/api/usuarios");
    const usuarios = await resposta.json();
    const tabela = document.querySelector("#tabelaUsuarios tbody");
    tabela.innerHTML = ""; 

    usuarios.forEach(usuario => {
        const linha = tabela.insertRow();
        linha.innerHTML = `
            <td>${usuario.Email}</td>
            <td>${usuario.Nome}</td>
            <td>${usuario.Endereco}</td>
            <td>${usuario.Telefone}</td>
            <td>${usuario.Categoria}</td>
            <td>
                <button onclick="editarUsuario('${usuario.Email}', '${usuario.Nome}', '${usuario.Endereco}', '${usuario.Telefone}', '${usuario.Categoria}')">Editar</button>
                <button onclick="excluirUsuario('${usuario.Email}')">Deletar</button>
            </td>
        `;
    });
}

usuarioForm.addEventListener("submit", async function (event) {
    event.preventDefault();

    const usuario = {
        nome: document.getElementById("nome").value,
        endereco: document.getElementById("endereco").value,
        telefone: document.getElementById("telefone").value,
        categoria: document.getElementById("categoria").value
    };

    if (usuarioEditando) {
        await fetch(`/api/usuarios/${usuarioEditando}`, { 
            method: "PUT",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(usuario)
        });
    } else {
        await fetch("/api/usuarios", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ email: document.getElementById("email").value, ...usuario }) 
        });
    }

    usuarioEditando = null;
    tituloForm.textContent = "Adicionar Usuário";
    usuarioForm.reset();
    carregarUsuarios();
});

function editarUsuario(email, nome, endereco, telefone, categoria) {
    document.getElementById("email").value = email;
    document.getElementById("nome").value = nome;
    document.getElementById("endereco").value = endereco;
    document.getElementById("telefone").value = telefone;
    document.getElementById("categoria").value = categoria;
    
    document.getElementById("email").disabled = true;

    usuarioEditando = email;
    tituloForm.textContent = "Atualizando Usuário";
}

async function excluirUsuario(email) {
    if (confirm("Tem certeza que deseja excluir este usuário?")) {
        await fetch(`/api/usuarios/${email}`, { method: "DELETE" });
        carregarUsuarios();
    }
}
