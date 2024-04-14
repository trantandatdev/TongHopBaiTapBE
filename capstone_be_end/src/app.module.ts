import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { ConfigModule } from '@nestjs/config';
import { AuthModule } from './auth/auth.module';
import { NguoiDungModule } from './nguoi-dung/nguoi-dung.module';
import { JwtStrategy } from './strategy/jwt.strategy';
import { BinhLuanModule } from './binh-luan/binh-luan.module';
import { ViTriModule } from './vi-tri/vi-tri.module';
import { PhongModule } from './phong/phong.module';
import { DatphongModule } from './datphong/datphong.module';

@Module({
  imports: [AuthModule, NguoiDungModule, ConfigModule.forRoot({ isGlobal: true }), BinhLuanModule, ViTriModule, PhongModule, DatphongModule],
  controllers: [AppController],
  providers: [AppService, JwtStrategy],
})
export class AppModule { }
