CREATE TABLE Instrutores(
    InstrutorID NUMBER GENERATED ALWAYS AS IDENTITY,
    Nome VARCHAR2(200) NOT NULL,
    Especialidade VARCHAR2(200) NOT NULL,
    Email VARCHAR2(300) NOT NULL,
    CONSTRAINT pk_Instrutores PRIMARY KEY (InstrutorId)
);
    
CREATE TABLE Cursos(
    CursoID NUMBER GENERATED ALWAYS AS IDENTITY,
    Nome VARCHAR2(200) NOT NULL,
    Descricao VARCHAR2(600) NOT NULL,
    Preco DECIMAL(6,2) NOT NULL,
    CONSTRAINT pk_Cursos PRIMARY KEY (CursoID)
);

CREATE TABLE Instrui(
    InstrutorID NUMBER
    	CONSTRAINT fk_Instrui_Instrutores REFERENCES Instrutores(InstrutorID),
    CursoID NUMBER 
    	CONSTRAINT fk_Instrui_Cursos REFERENCES Cursos(CursoID)
);

CREATE TABLE Estudantes(
    EstudanteID NUMBER GENERATED ALWAYS AS IDENTITY,
    Nome VARCHAR2(200) NOT NULL,
    Email VARCHAR2(300) NOT NULL,
    DataNascimento DATE NOT NULL,
    CONSTRAINT pk_Estudantes PRIMARY KEY (EstudanteID)
);

CREATE TABLE Matriculas(
    MatriculaID NUMBER GENERATED ALWAYS AS IDENTITY,
    DataMatricula DATE NOT NULL,
    Status VARCHAR2(8),
    EstudanteID NUMBER
    	CONSTRAINT fk_Matriculas_Estudantes REFERENCES Estudantes(EstudanteID),
    CursoID NUMBER
    	CONSTRAINT fk_Matriculas_Cursos REFERENCES Cursos(CursoID),
    CONSTRAINT check_status
    	CHECK (Status IN ('Ativo', 'Inativo', 'Trancado')),
    CONSTRAINT pk_Matriculas PRIMARY KEY (MatriculaID)
);

CREATE TABLE Avaliacoes(
    AvaliacaoID NUMBER GENERATED ALWAYS AS IDENTITY, 
    Nota DECIMAL(4,2) NOT NULL, 
    Comentario VARCHAR2(600),
    CursoID NUMBER
    	CONSTRAINT fk_Avaliacoes_Cursos REFERENCES Cursos(CursoID),
    EstudanteID NUMBER
    	CONSTRAINT fk_Avaliacoes_Estudantes REFERENCES Estudantes(EstudanteID),
    CONSTRAINT pk_Avaliacoes PRIMARY KEY (AvaliacaoID)
);