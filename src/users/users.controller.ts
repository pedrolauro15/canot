import { CreateDeviceDTO } from './dto/create-device-dto';
import { Body, Controller, Get, Param, Post } from '@nestjs/common';
import { UsersService } from './users.service';

@Controller('users')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @Get()
  async index() {
    return await this.usersService.findAll();
  }

  @Post('/:id/devices')
  createDevice(@Body() body: CreateDeviceDTO) {}
}
