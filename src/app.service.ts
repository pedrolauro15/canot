import { Injectable } from '@nestjs/common';
import { DatabaseService } from './database/services/database/database.service';

@Injectable()
export class AppService {
  constructor(private readonly db: DatabaseService) {}

  async getNow(): Promise<any> {
    const result = await this.db.findOne('select now()');
    return result;
  }
}
