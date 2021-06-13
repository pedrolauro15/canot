import { Module } from '@nestjs/common';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { SequelizeModule } from '@nestjs/sequelize';
import { DatabaseService } from './services/database/database.service';

@Module({
    imports:[
        SequelizeModule.forRootAsync({
            imports: [ConfigModule],
            inject: [ConfigService],
            useFactory: async (configService: ConfigService) => ({
                dialect: 'postgres',
                host: configService.get('DB_HOST'),
                port: parseInt(configService.get('DB_PORT')),
                username: configService.get('DB_USER'),
                password: configService.get('DB_PASSWORD'),
                database: configService.get('DB_DATABASE'),
                logging: (sql, timing) => {
                  console.log(sql);
                },
                dialectOptions: {
                  useUTC: true,
                  dateStrings: true,
                  typeCast: true,
                },
                timezone: '-03:00',
                pool: {
                  max: 10,
                  min: 2,
                  acquire: 30000,
                  idle: 10000,
                }
            })
          })
    ],
    providers: [DatabaseService],
    exports: [DatabaseService]
})
export class DatabaseModule {}
