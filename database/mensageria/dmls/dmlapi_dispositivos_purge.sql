
create or replace function app.dmlapi_dispositivos_purge(
    fv_id uuid,
    fv_usuario_id uuid,
    fv_inativo_id int default 0
)
    returns void 
    language plpgsql
    security definer
as $function$
------------------------------------------------------------------
-- (c) Copyright 2021 Antoniel Lima (antonielliimma@gmail.com)
-- (c) Copyright 2021 desenroladev.com.br
------------------------------------------------------------------
-- dmlapi_dispositivos_purge: inactive record
------------------------------------------------------------------
declare
    lr_data    app.dispositivos;
begin
    if (fv_id is not null) then
        lr_data := app.dmlapi_dispositivos_select(fv_id      => fv_id,
                                                                fv_locking => true);
        if (lr_data.id is not null) then
            ------------------------------------
            lr_data.ativo               := false;
            lr_data.data_inativacao     := now(); 
            lr_data.inativo_id          := fv_inativo_id;
            lr_data.usuario_inativou_id := fv_usuario_id;
            ------------------------------------
            perform app.dmlapi_dispositivos_merge(fr_data => lr_data);
            ------------------------------------
        end if;
    end if;
exception when others then
    raise;
end;
$function$
;