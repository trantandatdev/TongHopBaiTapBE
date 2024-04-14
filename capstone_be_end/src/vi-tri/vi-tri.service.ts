import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { PrismaClient } from '@prisma/client';

@Injectable()
export class ViTriService {
    prisma = new PrismaClient();

    // GET Vitri
    async getVitri() {
        let data = await this.prisma.viTri.findMany()
        return data
    }
    // END

    // GET Vitri BY ID
    async getViTriById(id) {
        let data = await this.prisma.viTri.findFirst(
            {
                where: {
                    id: parseInt(id)
                }
            }
        )
        if (!data) {
            throw new HttpException('Vị trí không tồn tại', HttpStatus.BAD_REQUEST)
        }
        return data
    }
    // END

    // PUT Vitri
    private checkUpdate = (value: string | null): boolean => {
        return value !== null && value !== "" && value !== "string";
    }
    async putVitri(vitriData, id) {
        try {
            let oldData = await this.prisma.viTri.findFirst({
                where: {
                    id: parseInt(id)
                }
            })
            if (!oldData) {
                throw new HttpException(`Không tìm thấy vị trí`, HttpStatus.BAD_REQUEST)
            }
            const updateData = {};
            for (const key in vitriData) {
                if (Object.prototype.hasOwnProperty.call(vitriData, key)) {
                    // Kiểm tra điều kiện và thêm vào data nếu giá trị mới thỏa mãn
                    if (this.checkUpdate(vitriData[key])) {
                        updateData[key] = vitriData[key];
                    } else {
                        // Nếu giá trị mới không thỏa mãn, giữ nguyên giá trị cũ
                        updateData[key] = oldData[key];
                    }
                }
            }
            let data = await this.prisma.viTri.update({
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

    // POST Vitri
    async postVitri(vitri) {
        try {
            if ((vitri.ten_vi_tri === 'string' || vitri.ten_vi_tri === null) &&
                (vitri.tinh_thanh === 'string' || vitri.tinh_thanh === null) &&
                (vitri.quoc_gia === 'string' || vitri.quoc_gia === null)) {
                throw new HttpException('Vui lòng nhập dữ liệu', HttpStatus.BAD_REQUEST)
            }
            let existingVitri = await this.prisma.viTri.findFirst({
                where: {
                    ten_vi_tri: vitri.ten_vi_tri
                }
            })
            if (existingVitri) {
                throw new HttpException('Vị trí đã tồn tại', HttpStatus.BAD_REQUEST)
            }
            let newData = await this.prisma.viTri.create({ data: vitri })
            return {
                success: true,
                message: "Upload thành công",
                data: newData
            }
        } catch (error) {
            throw new HttpException(`Error: ${error.message}`, HttpStatus.INTERNAL_SERVER_ERROR)
        }
    }
    // END

    // DELETE ViTri
    async deleteVitri(id) {
        try {
            let data = await this.prisma.viTri.findFirst({
                where: {
                    id: parseInt(id)
                }
            })
            if (!data) {
                throw new HttpException('Vị trí không tồn tại', HttpStatus.BAD_REQUEST)
            }
            await this.prisma.viTri.delete({
                where: {
                    id: parseInt(id)
                }
            })
            return {
                success: true,
                message: "Xoá thành công",
            }
        } catch (error) {
            throw new HttpException(`Error: ${error.message}`, HttpStatus.INTERNAL_SERVER_ERROR)
        }
    }
    // END

    // Upload IMG ViTri
    async uploadVitriImg(files, maViTri) {
        try {
            if (files.length === 0) {
                let viTri = await this.prisma.viTri.findUnique({
                    where: {
                        id: parseInt(maViTri)
                    },
                    select: {
                        hinh_anh: true
                    }
                });
                return viTri;
            }

            const fileNames = files.map(file => file.filename).join(', ');

            let viTri = await this.prisma.viTri.findUnique({
                where: {
                    id: parseInt(maViTri)
                },
                select: {
                    hinh_anh: true
                }
            });

            let existingImages = [];
            if (viTri.hinh_anh) {
                existingImages = viTri.hinh_anh.split(', ');
            }

            let newImages = [];
            for (let fileName of fileNames.split(', ')) {
                let imageId = fileName.split('_')[1];
                if (!existingImages.includes(imageId)) {
                    newImages.push(fileName);
                }
            }

            let updatedImages = [...existingImages, ...newImages];

            let data = await this.prisma.viTri.update({
                where: {
                    id: parseInt(maViTri)
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

