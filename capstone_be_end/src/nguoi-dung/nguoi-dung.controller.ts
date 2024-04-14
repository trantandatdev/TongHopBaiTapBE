import { Body, Controller, Delete, Get, Headers, Param, Post, Put, UploadedFile, UseInterceptors } from '@nestjs/common';
import { NguoiDungService } from './nguoi-dung.service';
import { ApiBody, ApiConsumes, ApiTags } from '@nestjs/swagger';
import { UserForm } from 'src/auth/userDto';
import { uploadDto } from './uploadDto';
import { FileInterceptor } from '@nestjs/platform-express';
import { diskStorage } from 'multer';


@ApiTags("NguoiDung")
@Controller('api')
export class NguoiDungController {
  constructor(private readonly nguoiDungService: NguoiDungService) { };

  @Get("user")
  getAllUser() {
    return this.nguoiDungService.getAllUser()
  }

  @Get("user/:id")
  getUserById(@Param('id') id: number) {
    return this.nguoiDungService.getUserById(id)
  }

  @Get("user/search/:userName")
  getUserByName(@Param('userName') userName: string) {
    return this.nguoiDungService.getUserByName(userName)
  }

  @Put("user/:id")
  editUser(@Param('id') id: number, @Body() userData: UserForm) {
    return this.nguoiDungService.edit(id, userData)
  }

  @Delete("user/:id")
  delete(@Param('id') userId: number) {
    return this.nguoiDungService.delete(userId)
  }

  @ApiConsumes('multipart/form-data')
  @ApiBody({
    type: uploadDto
  })

  @Post('upload-avatar')
  @UseInterceptors(FileInterceptor('file', {
    storage: diskStorage({
      destination: process.cwd() + "/public/avatar",
      filename: (req, file, callback) => callback(null, new Date().getTime() + "_" + file.originalname)
    })
  }))
  uploadFile(@UploadedFile() file: Express.Multer.File, @Headers('token') token: string) {
    return this.nguoiDungService.upload_avatar(file, token)
  }
}