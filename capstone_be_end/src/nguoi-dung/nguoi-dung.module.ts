import { Module } from '@nestjs/common';
import { NguoiDungService } from './nguoi-dung.service';
import { NguoiDungController } from './nguoi-dung.controller';
import { JwtService } from '@nestjs/jwt';

@Module({
  controllers: [NguoiDungController],
  providers: [NguoiDungService, JwtService],
})
export class NguoiDungModule {}
