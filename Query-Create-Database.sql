CREATE DATABASE DB_BIBLIOTECA 
USE DB_BIBLIOTECA

CREATE TABLE Livros (
    ISBN VARCHAR(13) PRIMARY KEY, -- ISBN único do livro
    Titulo VARCHAR(255) NOT NULL, -- Título do livro
    Autor VARCHAR(255) NOT NULL,  -- Autor do livro
    Editora VARCHAR(255) NOT NULL, -- Editora do livro
    AnoPublicacao INT NOT NULL,   -- Ano de publicação
    Genero VARCHAR(100) NOT NULL  -- Gênero do livro
);

CREATE TABLE Usuarios (
    Email VARCHAR(255) PRIMARY KEY, -- Email único do usuário
    Nome VARCHAR(255) NOT NULL,     -- Nome do usuário
    Endereco VARCHAR(255) NOT NULL, -- Endereço do usuário
    Telefone VARCHAR(15) NOT NULL,  -- Telefone do usuário
    Categoria VARCHAR(50) NOT NULL  -- Categoria do usuário (ex: estudante, professor)
);

CREATE TABLE Emprestimos (
    ID INT PRIMARY KEY IDENTITY (0,1), -- ID único do empréstimo
    ISBN VARCHAR(13) NOT NULL,         -- ISBN do livro emprestado
    EmailUsuario VARCHAR(255) NOT NULL, -- Email do usuário que fez o empréstimo
    DataRetirada DATE NOT NULL,        -- Data de retirada do livro
    DataDevolucaoPrevista DATE NOT NULL, -- Data prevista para devolução
    DataDevolucaoReal DATE,            -- Data real de devolução (pode ser nula)
    FOREIGN KEY (ISBN) REFERENCES Livros(ISBN), -- Chave estrangeira para a tabela Livros
    FOREIGN KEY (EmailUsuario) REFERENCES Usuarios(Email) -- Chave estrangeira para a tabela Usuarios
);

INSERT INTO Usuarios (Email, Nome, Endereco, Telefone, Categoria) VALUES 
('maria.santos@email.com', 'Maria Santos', 'Avenida Paulista, 456', '11976543210', 'Professor'),
('carlos.oliveira@email.com', 'Carlos Oliveira', 'Rua das Flores, 789', '11985432178', 'Visitante'),
('ana.lima@email.com', 'Ana Lima', 'Rua do Sol, 321', '11998765432', 'Estudante'),
('fernando.martins@email.com', 'Fernando Martins', 'Praça Central, 15', '11992345678', 'Professor'),
('lucas.rodrigues@email.com', 'Lucas Rodrigues', 'Avenida Brasil, 852', '11981234567', 'Estudante'),
('patricia.ferreira@email.com', 'Patrícia Ferreira', 'Rua das Árvores, 159', '11993456789', 'Visitante'),
('joana.costa@email.com', 'Joana Costa', 'Travessa Rio Branco, 753', '11999887766', 'Professor'),
('andre.silva@email.com', 'André Silva', 'Rua Azul, 951', '11987651234', 'Estudante'),
('renata.pereira@email.com', 'Renata Pereira', 'Avenida das Nações, 369', '11976549876', 'Visitante'),
('marcelo.alves@email.com', 'Marcelo Alves', 'Rua das Palmeiras, 258', '11985473219', 'Professor'),
('juliana.souza@email.com', 'Juliana Souza', 'Vila Verde, 852', '11992387456', 'Estudante'),
('roberto.mendes@email.com', 'Roberto Mendes', 'Avenida Boa Vista, 147', '11981235674', 'Visitante'),
('camila.barros@email.com', 'Camila Barros', 'Rua Alegre, 632', '11999841236', 'Professor'),
('eduardo.carvalho@email.com', 'Eduardo Carvalho', 'Largo da Paz, 741', '11988762345', 'Estudante'),
('daniela.gomes@email.com', 'Daniela Gomes', 'Rua do Comércio, 369', '11992233456', 'Visitante'),
('felipe.santos@email.com', 'Felipe Santos', 'Rua das Acácias, 123', '11993421765', 'Professor'),
('bianca.oliveira@email.com', 'Bianca Oliveira', 'Rua do Lago, 852', '11984562378', 'Estudante'),
('gustavo.machado@email.com', 'Gustavo Machado', 'Avenida Central, 741', '11996781234', 'Visitante'),
('luciana.ferreira@email.com', 'Luciana Ferreira', 'Rua das Pedras, 369', '11992348756', 'Professor'),
('antonio.rocha@email.com', 'Antonio Rocha', 'Travessa do Bosque, 456', '11997654321', 'Estudante'),
('sandra.lima@email.com', 'Sandra Lima', 'Praça das Rosas, 753', '11991234567', 'Visitante'),
('ricardo.souza@email.com', 'Ricardo Souza', 'Rua Aurora, 147', '11986543219', 'Professor'),
('julio.almeida@email.com', 'Julio Almeida', 'Avenida Primavera, 852', '11993456782', 'Estudante'),
('elaine.moura@email.com', 'Elaine Moura', 'Rua Bela Vista, 369', '11998765421', 'Visitante'),
('paulo.costa@email.com', 'Paulo Costa', 'Travessa da Liberdade, 741', '11992345789', 'Professor'),
('mariana.ramos@email.com', 'Mariana Ramos', 'Rua Rio Negro, 951', '11994561234', 'Estudante'),
('vinicius.melo@email.com', 'Vinicius Melo', 'Avenida Atlântica, 123', '11981234598', 'Visitante'),
('jessica.teixeira@email.com', 'Jessica Teixeira', 'Rua Verde, 753', '11987654329', 'Professor'),
('rodrigo.pires@email.com', 'Rodrigo Pires', 'Largo da Liberdade, 852', '11993457821', 'Estudante'),
('tania.cardoso@email.com', 'Tânia Cardoso', 'Rua Estrela, 369', '11992348792', 'Visitante'),
('claudio.barbosa@email.com', 'Claudio Barbosa', 'Praça da República, 147', '11997654398', 'Professor'),
('aline.cavalcante@email.com', 'Aline Cavalcante', 'Rua Azul, 951', '11998765489', 'Estudante'),
('daniel.monteiro@email.com', 'Daniel Monteiro', 'Avenida São João, 456', '11993457623', 'Visitante'),
('regina.silveira@email.com', 'Regina Silveira', 'Rua Jardim, 852', '11992345674', 'Professor'),
('fabiola.mendes@email.com', 'Fabíola Mendes', 'Travessa Azul, 369', '11981235467', 'Estudante'),
('roberto.cavalcante@email.com', 'Roberto Cavalcante', 'Rua Esperança, 753', '11999887755', 'Visitante'),
('marta.andrade@email.com', 'Marta Andrade', 'Avenida Bela Vista, 123', '11993456799', 'Professor'),
('joao.batista@email.com', 'João Batista', 'Rua do Comércio, 852', '11984561234', 'Estudante'),
('silvana.ferreira@email.com', 'Silvana Ferreira', 'Travessa Central, 369', '11992348753', 'Visitante'),
('osvaldo.souza@email.com', 'Osvaldo Souza', 'Rua da Paz, 741', '11998765422', 'Professor'),
('heloisa.campos@email.com', 'Heloísa Campos', 'Praça das Águas, 951', '11987654310', 'Estudante'),
('thiago.araujo@email.com', 'Thiago Araújo', 'Rua Boa Vista, 852', '11993457688', 'Visitante'),
('fernanda.martins@email.com', 'Fernanda Martins', 'Avenida Paulista, 369', '11992345987', 'Professor'),
('adriana.lima@email.com', 'Adriana Lima', 'Travessa dos Pássaros, 753', '11981236547', 'Estudante'),
('raul.fonseca@email.com', 'Raul Fonseca', 'Rua Bela Alvorada, 456', '11997654432', 'Visitante'),
('cintia.morais@email.com', 'Cíntia Morais', 'Rua da Liberdade, 852', '11998765499', 'Professor'),
('fabio.almeida@email.com', 'Fábio Almeida', 'Avenida São Pedro, 741', '11993457893', 'Estudante'),
('monica.torres@email.com', 'Mônica Torres', 'Rua das Palmeiras, 369', '11992346785', 'Visitante');

INSERT INTO Livros (ISBN, Titulo, Autor, Editora, AnoPublicacao, Genero) VALUES 
('9788535914849', '1984', 'George Orwell', 'Companhia das Letras', 1949, 'Ficção Científica'),
('9788582850853', 'Admirável Mundo Novo', 'Aldous Huxley', 'Biblioteca Azul', 1932, 'Ficção Científica'),
('9786558300402', 'O Conto da Aia', 'Margaret Atwood', 'Rocco', 1985, 'Distopia'),
('9788580419152', 'O Senhor dos Anéis', 'J.R.R. Tolkien', 'HarperCollins', 1954, 'Fantasia'),
('9786555320388', 'Duna', 'Frank Herbert', 'Aleph', 1965, 'Ficção Científica'),
('9786555320052', 'Neuromancer', 'William Gibson', 'Aleph', 1984, 'Cyberpunk'),
('9788594318882', 'Fundação', 'Isaac Asimov', 'Aleph', 1951, 'Ficção Científica'),
('9788556510994', 'O Hobbit', 'J.R.R. Tolkien', 'HarperCollins', 1937, 'Fantasia'),
('9788528613837', 'As Crônicas de Nárnia', 'C.S. Lewis', 'Martins Fontes', 1950, 'Fantasia'),
('9788595081518', 'O Nome do Vento', 'Patrick Rothfuss', 'Arqueiro', 2007, 'Fantasia'),
('9786555600994', 'A Guerra dos Tronos', 'George R.R. Martin', 'Suma', 1996, 'Fantasia'),
('9786555602684', 'O Temor do Sábio', 'Patrick Rothfuss', 'Arqueiro', 2011, 'Fantasia'),
('9786555600413', 'O Problema dos Três Corpos', 'Liu Cixin', 'Suma', 2008, 'Ficção Científica'),
('9788576573136', 'A Máquina do Tempo', 'H.G. Wells', 'Zahar', 1895, 'Ficção Científica'),
('9788556510017', 'Os Miseráveis', 'Victor Hugo', 'Martin Claret', 1862, 'Romance'),
('9788532529825', 'Crime e Castigo', 'Fiódor Dostoiévski', 'Martin Claret', 1866, 'Romance'),
('9788525413218', 'Dom Quixote', 'Miguel de Cervantes', 'Nova Fronteira', 1605, 'Romance'),
('9788577991496', 'O Pequeno Príncipe', 'Antoine de Saint-Exupéry', 'Agir', 1943, 'Infantil'),
('9786555640358', 'Harry Potter e a Pedra Filosofal', 'J.K. Rowling', 'Rocco', 1997, 'Fantasia'),
('9788576571568', 'O Código Da Vinci', 'Dan Brown', 'Arqueiro', 2003, 'Suspense'),
('9788595080467', 'Inferno', 'Dan Brown', 'Arqueiro', 2013, 'Suspense'),
('9788595081990', 'Origem', 'Dan Brown', 'Arqueiro', 2017, 'Suspense'),
('9788532529788', 'O Morro dos Ventos Uivantes', 'Emily Brontë', 'Martin Claret', 1847, 'Romance'),
('9788577993178', 'Orgulho e Preconceito', 'Jane Austen', 'Martin Claret', 1813, 'Romance'),
('9786555602691', 'It: A Coisa', 'Stephen King', 'Suma', 1986, 'Terror'),
('9788532529801', 'Drácula', 'Bram Stoker', 'Martin Claret', 1897, 'Terror'),
('9788556510995', 'Frankenstein', 'Mary Shelley', 'DarkSide', 1818, 'Terror'),
('9788501078844', 'O Iluminado', 'Stephen King', 'Suma', 1977, 'Terror'),
('9788580415147', 'O Chamado de Cthulhu', 'H.P. Lovecraft', 'Pandorga', 1928, 'Terror'),
('9786555610085', 'Cem Anos de Solidão', 'Gabriel García Márquez', 'Record', 1967, 'Realismo Mágico'),
('9788532529771', 'O Grande Gatsby', 'F. Scott Fitzgerald', 'Penguin Companhia', 1925, 'Romance'),
('9786555602677', 'A Revolução dos Bichos', 'George Orwell', 'Companhia das Letras', 1945, 'Satírico'),
('9788580419039', 'Moby Dick', 'Herman Melville', 'Principis', 1851, 'Aventura'),
('9788576572673', 'As Aventuras de Sherlock Holmes', 'Arthur Conan Doyle', 'Zahar', 1892, 'Mistério'),
('9788594318851', 'O Alienista', 'Machado de Assis', 'Penguin Companhia', 1882, 'Clássico'),
('9788532529764', 'Dom Casmurro', 'Machado de Assis', 'Penguin Companhia', 1899, 'Clássico'),
('9788580419299', 'Memórias Póstumas de Brás Cubas', 'Machado de Assis', 'Principis', 1881, 'Clássico'),
('9788576573128', 'Senhora', 'José de Alencar', 'Martin Claret', 1875, 'Romance'),
('9788577991771', 'Iracema', 'José de Alencar', 'Martin Claret', 1865, 'Romance'),
('9786559600144', 'O Guarani', 'José de Alencar', 'Martin Claret', 1857, 'Aventura'),
('9786559640300', 'Capitães da Areia', 'Jorge Amado', 'Companhia das Letras', 1937, 'Romance'),
('9786558300014', 'Gabriela, Cravo e Canela', 'Jorge Amado', 'Companhia das Letras', 1958, 'Romance'),
('9788532529757', 'O Primo Basílio', 'Eça de Queirós', 'Penguin Companhia', 1878, 'Romance'),
('9786555640353', 'Ensaio Sobre a Cegueira', 'José Saramago', 'Companhia das Letras', 1995, 'Ficção'),
('9788576573207', 'A Metamorfose', 'Franz Kafka', 'Antofágica', 1915, 'Ficção'),
('9786558300498', 'O Processo', 'Franz Kafka', 'Companhia das Letras', 1925, 'Ficção'),
('9788532529748', 'A Divina Comédia', 'Dante Alighieri', 'Penguin Companhia', 1320, 'Épico'),
('9788576572873', 'Odisseia', 'Homero', 'Martin Claret', -800, 'Épico'),
('9786558300605', 'Ilíada', 'Homero', 'Companhia das Letras', -750, 'Épico');

INSERT INTO Emprestimos (ISBN, EmailUsuario, DataRetirada, DataDevolucaoPrevista, DataDevolucaoReal) VALUES
('9788582850853', 'maria.santos@email.com', '2024-01-05', '2024-01-19', '2024-01-18'),
('9788582850853', 'maria.santos@email.com', '2024-01-05', '2024-01-19', '2024-01-17'),
('9788582850853', 'maria.santos@email.com', '2024-01-05', '2024-01-19', '2024-01-19'),
('9788582850853', 'maria.santos@email.com', '2024-01-05', '2024-01-19', '2024-01-20'),
('9788582850853', 'maria.santos@email.com', '2024-01-05', '2024-01-19', '2024-01-18'),
('9788582850853', 'maria.santos@email.com', '2024-01-05', '2024-01-19', '2024-01-19'),
('9786558300402', 'carlos.oliveira@email.com', '2024-01-06', '2024-01-20', '2024-01-19'),
('9786558300402', 'carlos.oliveira@email.com', '2024-01-06', '2024-01-20', '2024-01-20'),
('9786558300402', 'carlos.oliveira@email.com', '2024-01-06', '2024-01-20', '2024-01-21'),
('9786558300402', 'carlos.oliveira@email.com', '2024-01-06', '2024-01-20', '2024-01-19'),
('9786558300402', 'carlos.oliveira@email.com', '2024-01-06', '2024-01-20', '2024-01-18'),
('9786558300402', 'carlos.oliveira@email.com', '2024-01-06', '2024-01-20', '2024-01-20'),
('9788580419152', 'ana.lima@email.com', '2024-01-07', '2024-01-21', '2024-01-20'),
('9786555320388', 'fernando.martins@email.com', '2024-01-08', '2024-01-22', '2024-01-21'),
('9786555320052', 'lucas.rodrigues@email.com', '2024-01-09', '2024-01-23', '2024-01-22'),
('9788594318882', 'patricia.ferreira@email.com', '2024-01-10', '2024-01-24', '2024-01-23'),
('9788556510994', 'joana.costa@email.com', '2024-01-11', '2024-01-25', '2024-01-24'),
('9788528613837', 'andre.silva@email.com', '2024-01-12', '2024-01-26', '2024-01-25'),
('9788595081518', 'renata.pereira@email.com', '2024-01-13', '2024-01-27', '2024-01-26'),
('9786555600994', 'marcelo.alves@email.com', '2024-01-14', '2024-01-28', '2024-01-27'),
('9786555602684', 'juliana.souza@email.com', '2024-01-15', '2024-01-29', '2024-01-28'),
('9786555602684', 'juliana.souza@email.com', '2024-01-15', '2024-01-29', '2024-01-29'),
('9786555602684', 'juliana.souza@email.com', '2024-01-15', '2024-01-29', '2024-01-30'),
('9786555602684', 'juliana.souza@email.com', '2024-01-15', '2024-01-29', '2024-01-28'),
('9786555602684', 'juliana.souza@email.com', '2024-01-15', '2024-01-29', '2024-01-29'),
('9786555602684', 'juliana.souza@email.com', '2024-01-15', '2024-01-29', '2024-01-27'),
('9786555602684', 'juliana.souza@email.com', '2024-01-15', '2024-01-29', '2024-01-28'),
('9786555600413', 'roberto.mendes@email.com', '2024-01-16', '2024-01-30', '2024-01-29'),
('9788576573136', 'camila.barros@email.com', '2024-01-17', '2024-01-31', '2024-01-30'),
('9788556510017', 'eduardo.carvalho@email.com', '2024-01-18', '2024-02-01', '2024-01-31'),
('9788532529825', 'daniela.gomes@email.com', '2024-01-19', '2024-02-02', '2024-02-01'),
('9788525413218', 'felipe.santos@email.com', '2024-01-20', '2024-02-03', '2024-02-02'),
('9788577991496', 'bianca.oliveira@email.com', '2024-01-21', '2024-02-04', '2024-02-03'),
('9786555640358', 'gustavo.machado@email.com', '2024-01-22', '2024-02-05', '2024-02-04'),
('9788576571568', 'luciana.ferreira@email.com', '2024-01-23', '2024-02-06', '2024-02-05'),
('9788595080467', 'antonio.rocha@email.com', '2024-01-24', '2024-02-07', '2024-02-06'),
('9788595081990', 'sandra.lima@email.com', '2024-01-25', '2024-02-08', '2024-02-07'),
('9788595081990', 'sandra.lima@email.com', '2024-01-25', '2024-02-08', '2024-02-08'),
('9788595081990', 'sandra.lima@email.com', '2024-01-25', '2024-02-08', '2024-02-09'),
('9788595081990', 'sandra.lima@email.com', '2024-01-25', '2024-02-08', '2024-02-07'),
('9788595081990', 'sandra.lima@email.com', '2024-01-25', '2024-02-08', '2024-02-08'),
('9788595081990', 'sandra.lima@email.com', '2024-01-25', '2024-02-08', '2024-02-06'),
('9788595081990', 'sandra.lima@email.com', '2024-01-25', '2024-02-08', '2024-02-07'),
('9788532529788', 'ricardo.souza@email.com', '2024-01-26', '2024-02-09', '2024-02-08'),
('9788577993178', 'julio.almeida@email.com', '2024-01-27', '2024-02-10', '2024-02-09'),
('9786555602691', 'elaine.moura@email.com', '2024-01-28', '2024-02-11', null),
('9788532529801', 'paulo.costa@email.com', '2024-01-29', '2024-02-12', null),
('9788556510995', 'mariana.ramos@email.com', '2024-01-30', '2024-02-13', null),
('9788501078844', 'vinicius.melo@email.com', '2024-01-31', '2024-02-14', null),
('9788580415147', 'jessica.teixeira@email.com', '2024-02-01', '2024-02-15', null),
('9788580415147', 'jessica.teixeira@email.com', '2024-02-01', '2024-02-15', null),
('9788580415147', 'jessica.teixeira@email.com', '2024-02-01', '2024-02-15', null),
('9788580415147', 'jessica.teixeira@email.com', '2024-02-01', '2024-02-15', null),
('9788580415147', 'jessica.teixeira@email.com', '2024-02-01', '2024-02-15', null),
('9786555610085', 'rodrigo.pires@email.com', '2024-02-02', '2024-02-16', null),
('9788532529771', 'tania.cardoso@email.com', '2024-02-03', '2024-02-17', null),
('9786555602677', 'claudio.barbosa@email.com', '2024-02-04', '2024-02-18', null),
('9788580419039', 'aline.cavalcante@email.com', '2024-02-05', '2024-02-19', null),
('9788576572673', 'daniel.monteiro@email.com', '2024-02-06', '2024-02-20', null),
('9788594318851', 'regina.silveira@email.com', '2024-02-07', '2024-02-21', null),
('9788532529764', 'fabiola.mendes@email.com', '2024-02-08', '2024-02-22', null),
('9788580419299', 'roberto.cavalcante@email.com', '2024-02-09', '2024-02-23', null),
('9788576573128', 'marta.andrade@email.com', '2024-02-10', '2024-02-24', null),
('9788577991771', 'joao.batista@email.com', '2024-02-11', '2024-02-25', null),
('9786559600144', 'silvana.ferreira@email.com', '2024-02-12', '2024-02-26', null),
('9786559640300', 'osvaldo.souza@email.com', '2024-02-13', '2024-02-27', null),
('9786558300014', 'heloisa.campos@email.com', '2024-02-14', '2024-02-28', null),
('9788532529757', 'thiago.araujo@email.com', '2024-02-15', '2024-02-29', null),
('9786555640353', 'fernanda.martins@email.com', '2024-02-16', '2024-03-01', null),
('9788576573207', 'adriana.lima@email.com', '2024-02-17', '2024-03-02', null),
('9786558300498', 'raul.fonseca@email.com', '2024-02-18', '2024-03-03', null),
('9788532529748', 'cintia.morais@email.com', '2024-02-19', '2024-03-04', null),
('9788576572873', 'fabio.almeida@email.com', '2024-02-20', '2024-03-05', null),
('9786558300605', 'monica.torres@email.com', '2024-02-21', '2024-03-06', null);


SELECT * FROM Livros
SELECT * FROM Usuarios
SELECT * FROM Emprestimos