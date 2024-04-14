import { Body, Controller, Delete, Get, Param, Post, Put } from '@nestjs/common';
import { DatphongService } from './datphong.service';
import { ApiTags } from '@nestjs/swagger';
import { DatPhongForm } from './datPhongDto';

@ApiTags("DatPhong")
@Controller('api')
export class DatphongController {
  constructor(private readonly datphongService: DatphongService) { }
  @Get('dat-phong')
  getDatPhong() {
    return this.datphongService.getDatPhong()
  }

  @Get('dat-phong/:id')
  getDatPhongById(@Param('id') id: number) {
    return this.datphongService.getDatPhongById(id)
  }

  @Get('dat-phong/lay-phong-theo-user/:userid')
  getDatPhongByUserId(@Param('userid') user_id: number) {
    return this.datphongService.getDatPhongByUserId(user_id)
  }

  @Post('dat-phong')
  postDatPhong(@Body() datPhong: DatPhongForm) {
    return this.datphongService.postDatPhong(datPhong)
  }

  @Put('dat-phong/:id')
  putDatPhongById(@Param('id') id: number, @Body() newData: DatPhongForm) {
    return this.datphongService.putDatPhongById(id, newData)
  }

  @Delete('dat-phong/:id')
  deleteDatphong(@Param('id') id: number) {
    return this.datphongService.deleteDatphong(id)
  }
}
