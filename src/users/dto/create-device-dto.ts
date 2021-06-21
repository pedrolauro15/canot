import { IsNotEmpty, IsNumber, IsOptional, IsString } from 'class-validator';

export class CreateDeviceDTO {
  @IsNumber()
  @IsNotEmpty()
  usuario_id: string;

  @IsString()
  @IsOptional()
  sistema: string;

  @IsString()
  @IsOptional()
  modelo: string;

  @IsString()
  @IsOptional()
  versao_sistema: string;

  @IsString()
  @IsNotEmpty()
  notificacao_id: string;
}
