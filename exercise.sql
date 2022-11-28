
--base de datos creacion

CREATE DATABASE test_carolina_venegas_379

-- conectamos a la base de datos
\c test_carolina_venegas_379


1.- Creamos el modelo peliculas y tags 

CREATE TABLE movie (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR (255),
    anno INT
);

CREATE TABLE tags (
    id SERIAL PRIMARY KEY,
    tag VARCHAR(32)
);

CREATE TABLE movie_tags (
    movie_id BIGINT,
    tag_id BIGINT,
    FOREIGN KEY (movie_id) REFERENCES movie (id),
    FOREIGN KEY (tag_id) REFERENCES tags (id)
);

2.- Insertamos valores movie y tags

INSERT INTO movie (nombre, anno) VALUES ('avatar', 2009);
INSERT INTO movie (nombre, anno) VALUES ('avengers', 2012);
INSERT INTO movie (nombre, anno) VALUES ('1917', 2019);
INSERT INTO movie (nombre, anno) VALUES ('son como niños', 2010);
INSERT INTO movie (nombre, anno) VALUES ('jumanji', 2017);

--SELECT * FROM MOVIE; 

INSERT INTO tags (tag) VALUES ('accion');
INSERT INTO tags (tag) VALUES ('comedia');
INSERT INTO tags (tag) VALUES ('suspenso');
INSERT INTO tags (tag) VALUES ('fantasy');
INSERT INTO tags (tag) VALUES ('drama');

--SELECT * FROM TAGS; 


INSERT INTO movie_tags (movie_id, tag_id) VALUES (1,1);
INSERT INTO movie_tags (movie_id, tag_id) VALUES (1,4);
INSERT INTO movie_tags (movie_id, tag_id) VALUES (2,1);
INSERT INTO movie_tags (movie_id, tag_id) VALUES (1,2);
INSERT INTO movie_tags (movie_id, tag_id) VALUES (2,2);

--SELECT * FROM MOVIE_TAGS; 


3.- contamos la cantidad de tags
SELECT movie.nombre, COUNT(movie_tags.tag_id)
FROM movie LEFT JOIN movie_tags on movie_id = movie_tags.movie_id
GROUP BY movie.nombre;

4.-creamos el 2º modelo preguntas,repuestas y usuarios

CREATE TABLE questions (
    id SERIAL PRIMARY KEY,
    question VARCHAR(255),
    correct_answer VARCHAR
);

CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255),
    edad INT
);

CREATE TABLE answers (
    id SERIAL PRIMARY KEY,
    answer VARCHAR(255),
    usuario_id BIGINT,
    question_id BIGINT,
    FOREIGN KEY (usuario_id) REFERENCES usuarios (id),
    FOREIGN KEY (question_id) REFERENCES questions (id)
);


5.- Insertamos datos

INSERT INTO usuarios (nombre, edad) VALUES ('juan', 25);
INSERT INTO usuarios (nombre, edad) VALUES ('ibai', 27);
INSERT INTO usuarios (nombre, edad) VALUES ('laura', 30);
INSERT INTO usuarios (nombre, edad) VALUES ('isa', 20);
INSERT INTO usuarios (nombre, edad) VALUES ('genesis', 28);

INSERT INTO questions (question, correct_answer) VALUES ('¿Cuál es el país más grande y el más pequeño del mundo?','Rusia y el vaticano');
INSERT INTO questions (question, correct_answer) VALUES ('¿Cuál es el libro más vendido en el mundo después de la Biblia?','Don Quijote de la Mancha');
INSERT INTO questions (question, correct_answer) VALUES ('¿Cuántos decimales tiene el número pi?','infinitos');
INSERT INTO questions (question, correct_answer) VALUES ('¿Cuánto tiempo tarda la luz del Sol en llegar a la Tierra?','8 minutos');
INSERT INTO questions (question, correct_answer) VALUES ('¿Quien esta actualmente es el soberano de la realeza britanica?','rey carlos III');

INSERT INTO answers (answer, usuario_id, question_id) VALUES ('rey carlos III', 5, 5);
INSERT INTO answers (answer, usuario_id, question_id) VALUES ('Rusia y el vaticano', 4, 1);
INSERT INTO answers (answer, usuario_id, question_id) VALUES ('Rusia y el vaticano', 3, 1);
INSERT INTO answers (answer, usuario_id, question_id) VALUES ('infinitos', 2, 3);
INSERT INTO answers (answer, usuario_id, question_id) VALUES ('8 minutos', 1, 4);

6.- Contamos la cantidad total de respuestas correctas totales por usuarios

SELECT usuarios.nombre, COUNT (questions.correct_answer) as correct_answer
FROM questions RIGHT JOIN answers on answers.answer = questions.correct_answer 
JOIN usuarios ON usuarios.id = answers.usuario_id 
GROUP BY  usuarios.nombre ,usuario_id ;

7.- total de usuarios que tuvieron respuesta correcta

SELECT questions.question,COUNT(answers.usuario_id) as Respuesta_correctas 
FROM answers
RIGHT JOIN questions on answers.question_id = questions.id
group BY
  questions.question;


8.- Implementa borrado en cascada de las respuestas al borrar un usuario y borrar el primer usuario para probar la implementación. 

DELETE FROM usuarios WHERE id = 3;

ALTER TABLE answers DROP CONSTRAINT answers_usuario_id_fkey, ADD FOREIGN KEY (usuario_id) 
REFERENCES usuarios(id) ON DELETE CASCADE;


9.- Creando restricción que impida insertar usuarios menores de 18 años

ALTER TABLE usuario ADD CHECK (edad > 18);

10.-Altera la tabla existente de usuarios agregando el campo email con la restricción de único

ALTER TABLE usuarios ADD email VARCHAR(100) UNIQUE;

