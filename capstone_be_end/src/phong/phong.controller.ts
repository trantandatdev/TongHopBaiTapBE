import { Body, Controller, Delete, Get, Param, Post, Put, Query, UploadedFiles, UseInterceptors } from '@nestjs/common';
import { PhongService } from './phong.service';
import { ApiBody, ApiConsumes, ApiTags } from '@nestjs/swagger';
import { PhongDto, PhongImgDto } from './phongDto';
import { FilesInterceptor } from '@nestjs/platform-express';
import { diskStorage } from 'multer';

@ApiTags('Phong')
@Controller('api')
export class PhongController {
  constructor(private readonly phongService: PhongService) { }
  @Get('phong-thue')
  getPhong() {
    return this.phongService.getPhong()
  }

  @Get('phong-thue/lay-phong-theo-ma-vi-tri')
  getPhongByVitriId(@Query('id') id: number) {
    return this.phongService.getPhongByVitriId(id)
  }

  @Get('phong-thue/:id')
  getPhongThueById(@Param('id') id: number) {
    return this.phongService.getPhongThueById(id)
  }

  @Post('phong-thue')
  postPhong(@Body() createPhong: PhongDto) {
    return this.phongService.postPhong(createPhong)
  }

  @Put('phong-thue/:id')
  putPhong(@Body() updatePhong: PhongDto, @Param('id') id: number) {
    return this.phongService.putPhong(updatePhong, id)
  }


  @ApiConsumes('multipart/form-data')
  @ApiBody({
    type: PhongImgDto
  })
  @Post('phong-thue/upload-image')
  @UseInterceptors(FilesInterceptor('files', 5, {
    storage: diskStorage({
      destination: process.cwd() + '/public/vitri_img',
      filename: (req, file, callback) => callback(null, new Date().getTime() + "_" + file.originalname)
    }),
  }))
  uploadImg(@UploadedFiles() files: Array<Express.Multer.File>, @Query('maPhong') maPhong: number) {
    return this.phongService.uploadPhongImg(files, maPhong)
  }

  @Delete('phong-thue/:id')
  deletePhong(@Param('id') id: number) {
    return this.phongService.deletePhong(id)
  }
}
