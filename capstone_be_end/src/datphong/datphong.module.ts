import { Module } from '@nestjs/common';
import { DatphongService } from './datphong.service';
import { DatphongController } from './datphong.controller';

@Module({
  controllers: [DatphongController],
  providers: [DatphongService],
})
export class DatphongModule {}
