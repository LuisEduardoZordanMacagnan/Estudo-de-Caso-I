-- Estudantes com mais cursos matriculados

CREATE OR REPLACE VIEW vw_EstudantesMaisMatriculados AS
SELECT 
    e.EstudanteID,
    e.Nome AS Estudante,
    COUNT(m.MatriculaID) AS TotalMatriculas
FROM 
    Estudantes e
LEFT JOIN 
    Matriculas m ON e.EstudanteID = m.EstudanteID
GROUP BY 
    e.EstudanteID, e.Nome
ORDER BY 
    TotalMatriculas DESC;


--Estudantes com melhores notas médias

CREATE OR REPLACE VIEW vw_EstudantesMelhorAvaliacao AS
SELECT 
    e.EstudanteID,
    e.Nome AS Estudante,
    AVG(a.Nota) AS MediaNota
FROM 
    Estudantes e
LEFT JOIN 
    Avaliacoes a ON e.EstudanteID = a.EstudanteID
GROUP BY 
    e.EstudanteID, e.Nome
HAVING 
    AVG(a.Nota) IS NOT NULL
ORDER BY 
    MediaNota DESC;

--Cursos com mais avaliações

CREATE OR REPLACE VIEW vw_CursosMaisAvaliacoes AS
SELECT 
    c.Nome AS Curso,
    COUNT(a.AvaliacaoID) AS TotalAvaliacoes
FROM 
    Cursos c
JOIN 
    Avaliacoes a ON c.CursoID = a.CursoID
GROUP BY 
    c.Nome
ORDER BY 
    TotalAvaliacoes DESC;

--View para mostrar a média de notas de avaliações por curso.

CREATE OR REPLACE VIEW vw_MediaAvaliacoesPorCurso AS
SELECT 
    c.CursoID,
    c.Nome AS NomeCurso,
    AVG(a.Nota) AS MediaNota
FROM 
    Cursos c
JOIN 
    Avaliacoes a ON c.CursoID = a.CursoID
GROUP BY 
    c.CursoID, c.Nome;

--View para exibir cursos mais populares com base no número de matrículas.

CREATE OR REPLACE VIEW vw_CursosPopulares AS
SELECT 
    c.CursoID,
    c.Nome AS NomeCurso,
    COUNT(m.MatriculaID) AS TotalMatriculas
FROM 
    Cursos c
JOIN 
    Matriculas m ON c.CursoID = m.CursoID
GROUP BY 
    c.CursoID, c.Nome
ORDER BY 
    TotalMatriculas DESC;

--View para listar os cursos disponíveis por categoria.

CREATE OR REPLACE VIEW vw_CursosPorCategoria AS
SELECT 
    Categoria,
    CursoID,
    Nome AS NomeCurso,
    Descricao,
    Preco
FROM 
    Cursos
ORDER BY 
    Categoria, Nome;