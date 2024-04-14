import { Body, Controller, Delete, Get, Param, Post, Put } from '@nestjs/common';
import { BinhLuanService } from './binh-luan.service';
import { BinhLuanForm } from './BinhLuanDto';
import { ApiTags } from '@nestjs/swagger';

@ApiTags('BinhLuan')
@Controller('api')
export class BinhLuanController {
  constructor(private readonly binhLuanService: BinhLuanService) { }

  @Get('comment')
  getBinhLuan() {
    return this.binhLuanService.getBinhLuan()
  }

  @Get('comment/:MaPhong')
  getBinhLuanByUser(@Param('MaPhong') id: number) {
    return this.binhLuanService.getBinhLuanByUser(id)
  }

  @Post('comment')
  postBinhLuan(@Body() comment: BinhLuanForm) {
    return this.binhLuanService.postBinhLuan(comment);
  }

  @Put('comment/:id')
  putBinhLuan(@Param('id') id: number, @Body() comment: BinhLuanForm) {
    return this.binhLuanService.putBinhLuan(comment, id);
  }

  @Delete('comment/:id')
  deleteBinhLuan(@Param('id') id: number) {
    return this.binhLuanService.deleteBinhluan(id)
  }

}
