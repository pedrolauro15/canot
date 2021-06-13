-- DROP TABLE app.dispositivos;

CREATE TABLE app.dispositivos (
	id uuid NOT NULL DEFAULT gen_random_uuid(),
	modelo varchar(60) NULL,
	sistema varchar(10) NULL,
	ativo bool NOT NULL DEFAULT true,
	versao_sistema varchar(40) NULL,
	criado_em timestamptz(0) NOT NULL DEFAULT now(),
	notificacao_id varchar(60) NULL,
	usuario_id bigserial NOT NULL,
	CONSTRAINT dispositivos_pk PRIMARY KEY (id),
	CONSTRAINT dispositivos_fk FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON UPDATE CASCADE
);
