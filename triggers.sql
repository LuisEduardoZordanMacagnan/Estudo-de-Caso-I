--Trigger para enviar um e-mail de boas vindas para um novo estudando cadastrado.
 
CREATE OR REPLACE TRIGGER trg_enviar_email_boasvindas
AFTER INSERT ON Matriculas 
FOR EACH ROW 
DECLARE
 
 emailEstudante VARCHAR2(255); 
 nomeEstudante VARCHAR2(255);
BEGIN
 
 SELECT Email, Nome INTO emailEstudante, nomeEstudante 
 FROM Estudantes
 WHERE EstudanteID = :NEW.EstudanteID; 
 
 -- Simulação do envio de e-mail -- Isso permite que a mensagem seja exibida no console do SQL*Plus ou em qualquer ferramenta que suporte saída 
 DBMS_OUTPUT.PUT_LINE('Enviando e-mail para: ' || emailEstudante);
 DBMS_OUTPUT.PUT_LINE('Assunto: Bem-vindo ao curso!');
 DBMS_OUTPUT.PUT_LINE('Mensagem: Olá ' || nomeEstudante || ', você foi matriculado com sucesso no curso!');
 
END;
 
 
--__________________________________
 
-- Trigger para atualizar a media de notas de um curso.
 
CREATE OR REPLACE TRIGGER trg_atualizar_media_nota
AFTER INSERT ON Avaliacoes 
FOR EACH ROW
DECLARE
 novaMedia NUMBER(4, 2);
BEGIN
 
 
 SELECT AVG(Nota) INTO novaMedia
 FROM Avaliacoes
 WHERE CursoID = :NEW.CursoID;
 
 
 UPDATE Cursos
 SET MediaNota = novaMedia
 WHERE CursoID = :NEW.CursoID;
END;
 
 
--__________________________________
 
--Trigger para validar se o estudante que for selecionado para deletar está ativo ou não. 
 
CREATE OR REPLACE TRIGGER trg_impede_exclusao_estudante
BEFORE DELETE ON Estudantes
FOR EACH ROW
DECLARE
 v_count NUMBER;
BEGIN
 
    -- Verifica se o estudante tem matrículas ativas
 SELECT COUNT(*)
 INTO v_count
 FROM Matriculas
 WHERE EstudanteID = :OLD.EstudanteID AND Status = 'Ativo';
 
 IF v_count > 0 THEN
 RAISE_APPLICATION_ERROR(-20002, 'Não é possível excluir o estudante, pois ele possui matrículas ativas.');
 END IF;
END;
 
--__________________________________
 
--Trigger para verificar se a nota inserida está dentro do padrão.
 
CREATE OR REPLACE TRIGGER trg_check_nota_avaliacoes
BEFORE INSERT OR UPDATE ON Avaliacoes
FOR EACH ROW
BEGIN
 IF :NEW.Nota < 0 OR :NEW.Nota > 10 THEN
 RAISE_APPLICATION_ERROR(-20005, 'A nota deve estar entre 0 e 10.');
 END IF;
END;
 
--__________________________________
 
--Trigger para verificar se o usuário selecionou um das 2 opções, caso não será implementado automaticamente.
 
 
CREATE OR REPLACE TRIGGER trg_default_status_matriculas
BEFORE INSERT ON Matriculas
FOR EACH ROW
BEGIN
 IF :NEW.Status IS NULL THEN
 :NEW.Status := 'Ativo';
 END IF;
END;

