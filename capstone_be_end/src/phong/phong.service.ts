import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { PrismaClient } from '@prisma/client';

@Injectable()
export class PhongService {
    prisma = new PrismaClient();

    // GET Phong
    async getPhong() {
        return await this.prisma.phong.findMany()
    }
    // END

    // GET Phong BY ID 
    async getPhongThueById(id) {
        let checkPhong = await this.prisma.phong.findFirst({
            where: {
                id: parseInt(id)
            }
        })
        if (!checkPhong) {
            throw new HttpException('Phòng không tồn tại', HttpStatus.BAD_REQUEST)
        }
        return {
            success: true,
            message: "Thành công",
            data: checkPhong
        }
    }
    // END

    // GET Phong BY Vitri ID
    async getPhongByVitriId(id) {
        let checkMaVitri = await this.prisma.viTri.findFirst({
            where: {
                id: parseInt(id)
            }
        })
        if (!checkMaVitri) {
            throw new HttpException('Vị trí không tồn tại', HttpStatus.BAD_REQUEST)
        }
        let phong = await this.prisma.phong.findMany({ where: { ma_vi_tri: parseInt(id) } })
        return phong
    }
    // END

    // POST Phong
    async postPhong(createPhong) {
        try {
            let existingPhong = await this.prisma.phong.findFirst({
                where: {
                    ten_phong: createPhong.ten_phong,
                    ma_vi_tri: parseInt(createPhong.ma_vi_tri)
                }
            })
            if (existingPhong) {
                throw new HttpException('Phòng đã tồn tại', HttpStatus.BAD_REQUEST)
            }
            if (createPhong.hinh_anh === "string" || createPhong.hinh_anh === "") {
                createPhong.hinh_anh = null
            }
            if (createPhong.mo_ta === "string" || createPhong.mo_ta === "") {
                createPhong.mo_ta = null
            }
            let checkMaVitri = await this.prisma.viTri.findFirst({
                where: {
                    id: parseInt(createPhong.ma_vi_tri)
                }
            })
            if (!checkMaVitri) {
                throw new HttpException('Vị trí không tồn tại', HttpStatus.BAD_REQUEST)
            }
            let newData = await this.prisma.phong.create({ data: createPhong })
            return {
                success: true,
                message: "Tạo thành công",
                data: newData
            }
        } catch (error) {
            throw new HttpException(`Error: ${error.message}`, HttpStatus.INTERNAL_SERVER_ERROR)
        }
    }
    // END

    // PUT Phong
    private checkUpdate = (value: string | number | null): boolean => {
        return value !== null && value !== "" && value !== "string" && value !== 0;
    }
    async putPhong(updatePhong, id) {
        let oldData = await this.prisma.phong.findFirst({
            where: {
                id: parseInt(id)
            }
        })
        if (!oldData) {
            throw new HttpException(`Không tìm thấy vị trí`, HttpStatus.BAD_REQUEST)
        }
        const updateData = {};
        for (const key in updatePhong) {
            if (Object.prototype.hasOwnProperty.call(updatePhong, key)) {
                // Kiểm tra điều kiện và thêm vào data nếu giá trị mới thỏa mãn
                if (this.checkUpdate(updatePhong[key])) {
                    updateData[key] = updatePhong[key];
                } else {
                    // Nếu giá trị mới không thỏa mãn, giữ nguyên giá trị cũ
                    updateData[key] = oldData[key];
                }
            }
        }
        let checkMaVitri = await this.prisma.viTri.findFirst({
            where: {
                id: parseInt(updatePhong.ma_vi_tri)
            }
        })
        if (!checkMaVitri) {
            throw new HttpException('Vị trí không tồn tại', HttpStatus.BAD_REQUEST)
        }
        let data = await this.prisma.phong.update({
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
    }
    // END

    // DELETE PHONG
    async deletePhong(id) {
        try {
            let checkPhong = await this.prisma.phong.findFirst({
                where: {
                    id: parseInt(id)
                }
            })
            if (!checkPhong) {
                throw new HttpException('Phòng không tồn tại', HttpStatus.BAD_REQUEST)
            }
            await this.prisma.phong.delete({
                where: {
                    id: parseInt(id)
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

    // UPLOAD IMG
    async uploadPhongImg(files, maPhong) {
        try {
            if (files.length === 0) {
                let phong = await this.prisma.phong.findUnique({
                    where: {
                        id: parseInt(maPhong)
                    },
                    select: {
                        hinh_anh: true
                    }
                });
                return phong;
            }

            const fileNames = files.map(file => file.filename).join(', ');

            let phong = await this.prisma.phong.findUnique({
                where: {
                    id: parseInt(maPhong)
                },
                select: {
                    hinh_anh: true
                }
            });

            let existingImages = [];
            if (phong.hinh_anh) {
                existingImages = phong.hinh_anh.split(', ');
            }

            let newImages = [];
            for (let fileName of fileNames.split(', ')) {
                let imageId = fileName.split('_')[1];
                if (!existingImages.includes(imageId)) {
                    newImages.push(fileName);
                }
            }

            let updatedImages = [...existingImages, ...newImages];

            let data = await this.prisma.phong.update({
                where: {
                    id: parseInt(maPhong)
                },
                data: {
                    hinh_anh: updatedImages.join(', ')
                }
            });

            return {
                success: true,
                message: "Upload thành công",
                data: data
            };
        } catch (error) {
            throw new HttpException(`Error: ${error.message}`, HttpStatus.INTERNAL_SERVER_ERROR)
        }
    }
    // END
}
