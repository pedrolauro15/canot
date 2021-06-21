
create or replace function app.dmlapi_dispositivos_j2r(
    fv_jsonb jsonb
)
    returns app.dispositivos
    language plpgsql
    security definer
as $function$
------------------------------------------------------------------
-- (c) Copyright 2021 Antoniel Lima (antonielliimma@gmail.com)
-- (c) Copyright 2021 desenroladev.com.br
------------------------------------------------------------------
-- app.dispositivos: jsonb to record
------------------------------------------------------------------
declare
    lv_data             app.dispositivos;
begin
    ------------------------------------------------------------
    lv_data.id                                        = fv_jsonb ->> 'id';                                        --001 uuid
    lv_data.modelo                                    = fv_jsonb ->> 'modelo';                                    --002 character varying(60) not null
    lv_data.sistema                                   = fv_jsonb ->> 'sistema';                                   --003 character varying(10) not null
    lv_data.ativo                                     = fv_jsonb ->> 'ativo';                                     --004 boolean
    lv_data.versao_sistema                            = fv_jsonb ->> 'versao_sistema';                            --005 character varying(40) not null
    lv_data.criado_em                                 = fv_jsonb ->> 'criado_em';                                 --006 timestamp with time zone
    lv_data.notificacao_id                            = fv_jsonb ->> 'notificacao_id';                            --007 character varying(60) not null
    lv_data.usuario_id                                = fv_jsonb ->> 'usuario_id';                                --008 bigint
    ------------------------------------------------------------
    return lv_data;
end;
$function$;