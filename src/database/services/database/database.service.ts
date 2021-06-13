import { Injectable } from '@nestjs/common';
import { Sequelize } from 'sequelize-typescript';
import { Transaction } from 'sequelize/types';

@Injectable()
export class DatabaseService {
  constructor(private readonly db: Sequelize) {}

  async transaction() {
    return await this.db.transaction();
  }

  async query<T = any>(
    sql: string,
    params: any = {},
    transaction: Transaction = null,
  ): Promise<T[]> {
    console.time();
    const query = await this.db.query(sql, { replacements: params, transaction });
    console.timeEnd();
    return query[0] as T[];
  }

  async findOne<T = any>(
    sql: string,
    params = {},
    transaction = null,
  ): Promise<T> {
    const query = await this.query(sql, params, transaction);
    return query.length > 0 ? query[0] : null;
  }

  async execute(sql: string, bind = [], transaction = null): Promise<any> {
    const query = await this.db.query(sql, { bind: bind, transaction });
    return query.length > 0 ? query[0] : null;
  }

  toJson<T = any>(model: T): string {
    const keys = Object.keys(model);
    keys.forEach((key) => {
      if (typeof model[key] == 'string') {
        model[key] = model[key]
          .replace(/[\n\r]/g, '\\n')
          .replace(/[\""]/g, '\\"');
      }
    });
    return JSON.stringify(model);
  }
}
