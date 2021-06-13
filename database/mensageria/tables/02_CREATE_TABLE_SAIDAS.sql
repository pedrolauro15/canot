--drop table mensageria.saidas;

CREATE TABLE mensageria.saidas (
	id uuid NOT NULL DEFAULT gen_random_uuid(),
	tipo varchar(1) NOT NULL DEFAULT 'N',
	titulo varchar NULL,
	descricao varchar NULL,
	mensagem varchar NULL,
	mensagem_id int8 NULL,
	status varchar(1) NOT NULL DEFAULT 'N',
	criado_em timestamptz(0) NOT NULL DEFAULT now(),
	enviado_em timestamptz(0) NULL,
	link varchar NULL,
	remetente_id int8 NULL,
	destinatario_id int8 NULL,
	CONSTRAINT saidas_pk PRIMARY KEY (id),
	CONSTRAINT mensagens_fk FOREIGN KEY (mensagem_id) REFERENCES mensageria.mensagens(id) ON UPDATE CASCADE,
	CONSTRAINT destinatario_fk FOREIGN KEY (destinatario_id) REFERENCES public.usuarios(id) ON UPDATE CASCADE,
	CONSTRAINT remetente_id FOREIGN KEY (remetente_id) REFERENCES public.usuarios(id) ON UPDATE CASCADE
);

-- Column comments

COMMENT ON COLUMN mensageria.saidas.tipo IS 'N - Notificação push, E - Email, S - SMS';
COMMENT ON COLUMN mensageria.saidas.link IS 'Link para o qual a notificação redirecionará o usuário';
