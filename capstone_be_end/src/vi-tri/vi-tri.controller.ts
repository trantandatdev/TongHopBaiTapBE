import { Body, Controller, Delete, Get, Param, Post, Put, Query, UploadedFiles, UseInterceptors } from '@nestjs/common';
import { ViTriService } from './vi-tri.service';
import { diskStorage } from 'multer';
import { FilesInterceptor } from '@nestjs/platform-express';
import { ApiBody, ApiConsumes, ApiTags } from '@nestjs/swagger';
import { ViTriDto, VitriImgDto } from './ViTriDto';

@ApiTags("ViTri")
@Controller('api')
export class ViTriController {
  constructor(private readonly viTriService: ViTriService) { }

  @Get('vitri')
  getVitri() {
    return this.viTriService.getVitri()
  }

  @Get('vitri/:id')
  getViTriById(@Param('id') id: number) {
    return this.viTriService.getViTriById(id)
  }

  @Post('vitri')
  postVitri(@Body() vitri: ViTriDto) {
    return this.viTriService.postVitri(vitri)
  }

  @Put('vitri/:id')
  putVitri(@Body() vitriData: ViTriDto, @Param('id') id: number) {
    return this.viTriService.putVitri(vitriData, id)
  }

  @Delete('vitri/:id')
  deleteVitri(@Param('id') id: number) {
    return this.viTriService.deleteVitri(id)
  }

  @ApiConsumes('multipart/form-data')
  @ApiBody({
    type: VitriImgDto
  })
  @Post('upload-image')
  @UseInterceptors(FilesInterceptor('files', 5, {
    storage: diskStorage({
      destination: process.cwd() + '/public/vitri_img',
      filename: (req, file, callback) => callback(null, new Date().getTime() + "_" + file.originalname)
    }),
  }))
  uploadImg(@UploadedFiles() files: Array<Express.Multer.File>, @Query('ma_vi_tri') maViTri: number) {
    return this.viTriService.uploadVitriImg(files, maViTri)
  }
}
