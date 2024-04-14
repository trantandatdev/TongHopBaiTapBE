import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { PrismaClient } from '@prisma/client';

@Injectable()
export class BinhLuanService {
    prisma = new PrismaClient();

    // GET COMMENT
    async getBinhLuan() {
        let data = await this.prisma.binhLuan.findMany()
        return data
    }
    // END

    // POST COMMENT
    async postBinhLuan(comment) {
        try {
            let checkPhong = await this.prisma.phong.findFirst({
                where: {
                    id: parseInt(comment.ma_phong)
                }
            })
            if (!checkPhong) {
                throw new HttpException('Không tìm thấy phòng', HttpStatus.BAD_REQUEST)
            }
            let checkNguoiBinhLuan = await this.prisma.nguoiDung.findFirst({
                where: {
                    id: parseInt(comment.ma_nguoi_binh_luan)
                }
            })
            if (!checkNguoiBinhLuan) {
                throw new HttpException('Không tìm thấy người dùng', HttpStatus.BAD_REQUEST)
            }
            let newData = await this.prisma.binhLuan.create({ data: comment })
            return newData
        } catch (error) {
            throw new HttpException(`Error: ${error.message}`, HttpStatus.INTERNAL_SERVER_ERROR)
        }
    }
    // END

    // PUT COMMENT
    private checkUpdate = (value: string | number | null): boolean => {
        return value !== null && value !== "" && value !== "string" && value !== 0;
    }
    async putBinhLuan(comment, id) {
        try {
            let oldData = await this.prisma.binhLuan.findFirst({
                where: {
                    id: parseInt(id)
                }
            })
            if (!oldData) {
                throw new HttpException('Không tìm thấy comment', HttpStatus.BAD_REQUEST)
            }
            const updateData = {};
            for (const key in comment) {
                if (Object.prototype.hasOwnProperty.call(comment, key)) {
                    // Kiểm tra điều kiện và thêm vào data nếu giá trị mới thỏa mãn
                    if (this.checkUpdate(comment[key])) {
                        updateData[key] = comment[key];
                    } else {
                        // Nếu giá trị mới không thỏa mãn, giữ nguyên giá trị cũ
                        updateData[key] = oldData[key];
                    }
                }
            }
            let data = await this.prisma.binhLuan.update({
                where: {
                    id: parseInt(id)
                },
                data: updateData
            })
            return {
                success: true,
                message: "Cập nhật thành công",
                data: data
            }
        } catch (error) {
            throw new HttpException(`Error: ${error.message}`, HttpStatus.INTERNAL_SERVER_ERROR)
        }
    }
    // END
    // DELETE COMMENT
    async deleteBinhluan(id) {
        try {
            let checkid = await this.prisma.binhLuan.findFirst({
                where: {
                    id: parseInt(id)
                }
            })
            if (!checkid) {
                throw new HttpException('Không tìm thấy bình luận', HttpStatus.BAD_REQUEST)
            }
            await this.prisma.binhLuan.delete({
                where: {
                    id: parseFloat(id)
                }
            })
            return {
                message: "Xoá thành công"
            }
        } catch (error) {
            throw new HttpException(`Error: ${error.message}`, HttpStatus.INTERNAL_SERVER_ERROR)
        }
    }
    // END

    // GET COMMENT BY USER
    async getBinhLuanByUser(id) {
        try {
            let data = await this.prisma.binhLuan.findMany({
                where: {
                    ma_phong: parseInt(id)
                }
            })
            if (!data) {
                throw new HttpException('Không tìm thấy dữ liệu', HttpStatus.BAD_REQUEST)
            }
            return {
                success: true,
                message: "Thành công",
                data: data
            }
        } catch (error) {
            throw new HttpException(`Error: ${error.message}`, HttpStatus.INTERNAL_SERVER_ERROR)
        }
    }
    // END

}
