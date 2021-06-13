--drop table mensageria.mensagens

CREATE TABLE mensageria.mensagens (
	id serial NOT NULL,
	mensagem varchar NOT NULL,
	titulo_padrao varchar NULL,
	CONSTRAINT mensagens_pk PRIMARY KEY (id)
);
