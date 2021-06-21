
create or replace function app.dmlapi_dispositivos_merge(
    fr_data app.dispositivos,
    fv_old_id uuid default null
) 
    returns app.dispositivos
    language plpgsql
    security definer
as $function$
------------------------------------------------------------------
-- (c) Copyright 2021 Antoniel Lima (antonielliimma@gmail.com)
-- (c) Copyright 2021 desenroladev.com.br
------------------------------------------------------------------
-- dmlapi_dispositivos_merge: insert or update
------------------------------------------------------------------
declare
    lr_data    app.dispositivos;
begin
    -------------------------------------------------------------------------------------
    -- UPDATE FROM PK WITH OLD ID
    -------------------------------------------------------------------------------------
    if fv_old_id is null then
        fv_old_id := fr_data.id;
    end if;
    -------------------------------------------------------------------------------------
    if (fr_data.id is not null) then
    lr_data := app.dmlapi_dispositivos_select(fv_id      => fv_old_id,
                                                                fv_locking => true);
    if (lr_data.id is not null) then
        update --+ qb_name(dmlapi_dispositivos_merge)
                app.dispositivos
            set 
            id                                        = fr_data.id,                                        --001 uuid
            modelo                                    = fr_data.modelo,                                    --002 character varying(60) not null
            sistema                                   = fr_data.sistema,                                   --003 character varying(10) not null
            ativo                                     = fr_data.ativo,                                     --004 boolean
            versao_sistema                            = fr_data.versao_sistema,                            --005 character varying(40) not null
            criado_em                                 = fr_data.criado_em,                                 --006 timestamp with time zone
            notificacao_id                            = fr_data.notificacao_id,                            --007 character varying(60) not null
            usuario_id                                = fr_data.usuario_id                                 --008 bigint
        where 1e1 = 1e1
            and id = fv_old_id
        returning * into fr_data;
    else
        insert --+ qb_name(dmlapi_dispositivos_merge)
        into app.dispositivos
            (
                id,                                        --001 uuid
              modelo,                                    --002 character varying(60) not null
              sistema,                                   --003 character varying(10) not null
              ativo,                                     --004 boolean
              versao_sistema,                            --005 character varying(40) not null
              criado_em,                                 --006 timestamp with time zone
              notificacao_id,                            --007 character varying(60) not null
              usuario_id                                 --008 bigint
            )
        values(
                fr_data.id,                                        --001 uuid
              fr_data.modelo,                                    --002 character varying(60) not null
              fr_data.sistema,                                   --003 character varying(10) not null
              fr_data.ativo,                                     --004 boolean
              fr_data.versao_sistema,                            --005 character varying(40) not null
              fr_data.criado_em,                                 --006 timestamp with time zone
              fr_data.notificacao_id,                            --007 character varying(60) not null
              fr_data.usuario_id                                 --008 bigint
            ) 
        returning *
            into fr_data;
    end if;
    else
    insert --+ qb_name(dmlapi_dispositivos_merge)
        into app.dispositivos
            (
            id,                                        --001 uuid
              modelo,                                    --002 character varying(60) not null
              sistema,                                   --003 character varying(10) not null
              ativo,                                     --004 boolean
              versao_sistema,                            --005 character varying(40) not null
              criado_em,                                 --006 timestamp with time zone
              notificacao_id,                            --007 character varying(60) not null
              usuario_id                                 --008 bigint  
            )
    values(
            fr_data.id,                                        --001 uuid
              fr_data.modelo,                                    --002 character varying(60) not null
              fr_data.sistema,                                   --003 character varying(10) not null
              fr_data.ativo,                                     --004 boolean
              fr_data.versao_sistema,                            --005 character varying(40) not null
              fr_data.criado_em,                                 --006 timestamp with time zone
              fr_data.notificacao_id,                            --007 character varying(60) not null
              fr_data.usuario_id                                 --008 bigint
            )
    returning *
        into fr_data;
    end if;
    return fr_data;
exception when others then
    raise;
end;
$function$
;


----------------------------------------------------
create or replace function app.dmlapi_dispositivos_merge(fr_data jsonb)
returns app.dispositivos
language plpgsql
security definer
as $function$
------------------------------------------------------------------
-- (c) Copyright 2021 Antoniel Lima (antonielliimma@gmail.com)
-- (c) Copyright 2021 desenroladev.com.br
------------------------------------------------------------------
-- dmlapi_dispositivos_merge: insert or update collection
------------------------------------------------------------------
declare
    lr_data           app.dispositivos;
begin
    lr_data := app.dmlapi_dispositivos_j2r(fv_jsonb => fr_data);
    if lr_data.id is null then
        lr_data.id := gen_random_uuid();
    end if;
    return app.dmlapi_dispositivos_merge(fr_data => lr_data, fv_old_id => (fr_data->>'old_id')::uuid);
exception when others then
raise;
end; $function$;