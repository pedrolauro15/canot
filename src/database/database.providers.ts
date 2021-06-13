import { Sequelize } from 'sequelize-typescript';
import { SEQUELIZE, DEVELOPMENT, TEST, PRODUCTION } from './constants';
import { databaseConfig } from './database.config';

export const databaseProviders = [
  {
    provide: SEQUELIZE,
    useFactory: async () => {
      let config: any;
      switch (process.env.NODE_ENV) {
        case DEVELOPMENT:
          config = databaseConfig.development;
          break;
        case TEST:
          config = databaseConfig.test;
          break;
        case PRODUCTION:
          config = databaseConfig.production;
          break;
        default:
          config = databaseConfig.development;
      }

      config.logging = true;
      config.dialectOptions = {
        useUTC: true,
        dateStrings: true,
        typeCast: true,
      };
      //config.timezone = 'America/Fortaleza';
      config.timezone = '+03:00';
      const sequelize = new Sequelize(config);
      return sequelize;
    },
  },
];
