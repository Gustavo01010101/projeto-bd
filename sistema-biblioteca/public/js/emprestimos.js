document.addEventListener("DOMContentLoaded", async function () {
    await carregarEmprestimos();
});

// Captura o formulário e adiciona evento de submissão
document.getElementById("emprestimoForm").addEventListener("submit", async function (event) {
    event.preventDefault();
    
    const isbn = document.getElementById("isbn").value;
    const emailUsuario = document.getElementById("emailUsuario").value;
    const dataRetirada = document.getElementById("dataRetirada").value;
    const dataDevolucaoPrevista = document.getElementById("dataDevolucaoPrevista").value;

    if (!isbn || !emailUsuario || !dataRetirada || !dataDevolucaoPrevista) {
        alert("Por favor, preencha todos os campos.");
        return;
    }

    const emprestimo = { isbn, emailUsuario, dataRetirada, dataDevolucaoPrevista };

    console.log("Enviando para o backend:", emprestimo); // Depuração

    const response = await fetch("/api/emprestimos", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(emprestimo)
    });

    if (response.ok) {
        alert("Empréstimo registrado com sucesso!");
        await carregarEmprestimos();
        document.getElementById("emprestimoForm").reset();
    } else {
        const errorMessage = await response.text();
        alert(`Erro ao registrar empréstimo: ${errorMessage}`);
    }
});

// Função para atualizar um empréstimo (registrar devolução)
async function devolverEmprestimo(id) {
    // Exibir um campo de input para o usuário preencher a data de devolução
    const tr = document.querySelector(`#emprestimo-${id}`);
    const tdDevolucao = tr.querySelector(".dataDevolucao");

    // Criar um campo de input para a data de devolução, se não existir
    if (!tdDevolucao.querySelector("input")) {
        const inputDataDevolucao = document.createElement("input");
        inputDataDevolucao.type = "date";
        inputDataDevolucao.required = true; // Garantir que o campo seja preenchido
        tdDevolucao.innerHTML = ""; // Limpar o conteúdo
        tdDevolucao.appendChild(inputDataDevolucao);

        // Adicionar um botão para enviar a data
        const btnAtualizar = document.createElement("button");
        btnAtualizar.textContent = "Atualizar";
        btnAtualizar.onclick = async () => {
            const dataDevolucaoReal = inputDataDevolucao.value;
            if (!dataDevolucaoReal) {
                alert("Por favor, preencha a data de devolução.");
                return;
            }

            // Enviar a data de devolução para o backend
            const response = await fetch(`/api/emprestimos/${id}`, {
                method: "PUT",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ dataDevolucaoReal })
            });

            if (response.ok) {
                alert("Devolução registrada!");
                await carregarEmprestimos(); // Atualizar a lista de empréstimos
            } else {
                alert("Erro ao registrar devolução.");
            }
        };

        tdDevolucao.appendChild(btnAtualizar);
    }
}

// Atualizar a exibição na tabela com os dados do empréstimo
async function carregarEmprestimos() {
    const response = await fetch("/api/emprestimos");
    const emprestimos = await response.json();

    const tbody = document.querySelector("#tabelaEmprestimos tbody");
    tbody.innerHTML = ""; // Limpar a tabela antes de preencher

    emprestimos.forEach(emprestimo => {
        const tr = document.createElement("tr");
        tr.id = `emprestimo-${emprestimo.ID}`;

        tr.innerHTML = `
            <td>${emprestimo.ID}</td>
            <td>${emprestimo.ISBN}</td>
            <td>${emprestimo.EmailUsuario}</td>
            <td>${emprestimo.DataRetirada}</td>
            <td>${emprestimo.DataDevolucaoPrevista}</td>
            <td class="dataDevolucao">${emprestimo.DataDevolucaoReal ? emprestimo.DataDevolucaoReal : "Pendente"}</td>
            <td>
                <button onclick="devolverEmprestimo(${emprestimo.ID})">Devolver</button>
                <button onclick="excluirEmprestimo(${emprestimo.ID})">Excluir</button>
            </td>
        `;

        tbody.appendChild(tr);
    });
}


// Função para excluir um empréstimo
async function excluirEmprestimo(id) {
    if (!confirm("Tem certeza que deseja excluir este empréstimo?")) return;

    const response = await fetch(`/api/emprestimos/${id}`, {
        method: "DELETE"
    });

    if (response.ok) {
        alert("Empréstimo excluído!");
        await carregarEmprestimos();
    } else {
        alert("Erro ao excluir empréstimo.");
    }
}
