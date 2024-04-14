import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { PrismaClient } from '@prisma/client';

@Injectable()
export class DatphongService {
    prisma = new PrismaClient()
    // GET DatPhong
    async getDatPhong() {
        let data = await this.prisma.datPhong.findMany()
        return data
    }
    // END

    // POST DatPhong
    async postDatPhong(datPhong) {
        let checkPhong = await this.prisma.phong.findFirst({
            where: {
                id: parseInt(datPhong.ma_phong)
            }
        })
        if (!checkPhong) {
            throw new HttpException('Không tìm thấy phòng', HttpStatus.BAD_REQUEST)
        }
        let checkUser = await this.prisma.nguoiDung.findFirst({
            where: {
                id: parseInt(datPhong.ma_nguoi_dat)
            }
        })
        if (!checkUser) {
            throw new HttpException('Không tìm người dùng', HttpStatus.BAD_REQUEST)
        }
        if (datPhong.ngay_den === "string" || datPhong.ngay_den === "" || datPhong.ngay_di === "string" || datPhong.ngay_di === "") {
            throw new HttpException('Vui lòng nhập ngày', HttpStatus.BAD_REQUEST)
        }
        const checkDatPhong = await this.prisma.datPhong.findFirst({
            where: {
                ma_phong: parseInt(datPhong.ma_phong),
                ngay_den: datPhong.ngay_den
            }
        });
        if (checkDatPhong) {
            return { message: "Phòng đã được đặt trước" };
        }
        let data = await this.prisma.datPhong.create({ data: datPhong })
        return data
    }
    // END

    // GET DatPhong BY ID
    async getDatPhongById(id) {
        let data = await this.prisma.datPhong.findFirst({
            where: {
                id: parseInt(id)
            }
        })
        if (!data) {
            throw new HttpException('Không tìm thấy dữ liệu', HttpStatus.BAD_REQUEST)
        }
        return data
    }
    // END

    // PUT DatPhong
    private checkUpdate = (value: string | number | null): boolean => {
        return value !== null && value !== "" && value !== "string" && value !== 0;
    }
    async putDatPhongById(id, newData) {
        try {
            let oldData = await this.prisma.datPhong.findFirst({
                where: {
                    id: parseInt(id)
                }
            })
            if (!oldData) {
                throw new HttpException('Không tìm thấy người dùng', HttpStatus.BAD_REQUEST)
            }
            const updateData = {};
            for (const key in newData) {
                if (Object.prototype.hasOwnProperty.call(newData, key)) {
                    // Kiểm tra điều kiện và thêm vào data nếu giá trị mới thỏa mãn
                    if (this.checkUpdate(newData[key])) {
                        updateData[key] = newData[key];
                    } else {
                        // Nếu giá trị mới không thỏa mãn, giữ nguyên giá trị cũ
                        updateData[key] = oldData[key];
                    }
                }
            }
            let data = await this.prisma.datPhong.update({
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

    // DELETE DatPhong
    async deleteDatphong(id) {
        try {
            let checkid = await this.prisma.datPhong.findFirst({
                where: {
                    id: parseInt(id)
                }
            })
            if (!checkid) {
                throw new HttpException('Không tìm thấy dữ liệu', HttpStatus.BAD_REQUEST)
            }
            await this.prisma.datPhong.delete({
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

    // 
    async getDatPhongByUserId(id) {
        try {
            let data = await this.prisma.datPhong.findMany({
                where: {
                    ma_nguoi_dat: parseInt(id)
                }
            })
            if (!data) {
                throw new HttpException('Không tìm thấy dữ liệu', HttpStatus.BAD_REQUEST)
            }
            return data
        }
        catch (error) {
            throw new HttpException(`Error: ${error.message}`, HttpStatus.INTERNAL_SERVER_ERROR)
        }
    }
    // 
}
