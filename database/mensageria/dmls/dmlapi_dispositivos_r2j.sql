
create or replace function app.dmlapi_dispositivos_r2j(
    fr_data app.dispositivos
)
    returns jsonb
    language plpgsql
    security definer
AS $function$
------------------------------------------------------------------
-- (c) Copyright 2021 Antoniel Lima (antonielliimma@gmail.com)
-- (c) Copyright 2021 desenroladev.com.br
------------------------------------------------------------------
-- app.dispositivos: record to jsonb
------------------------------------------------------------------
declare
    lv_jsonb jsonb;
begin
    lv_jsonb := row_to_json(fr_data,  -- record
                            true);    -- pretty_bool
    return lv_jsonb;
end;
$function$;