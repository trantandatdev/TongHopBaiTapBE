import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { PrismaClient } from '@prisma/client';

@Injectable()
export class NguoiDungService {
    constructor(private readonly jwtService: JwtService) { }
    prisma = new PrismaClient();

    // GET ALL USER
    async getAllUser() {
        let data = await this.prisma.nguoiDung.findMany()
        return data
    }
    // END

    // GET USER BY ID
    async getUserById(id) {
        let data = await this.prisma.nguoiDung.findFirst({
            where: {
                id: parseInt(id)
            }
        })
        if (!data) {
            return {
                success: false,
                message: "ID không tồn tại"
            }
        }
        return {
            success: true,
            message: "Thành công",
            data: data
        }
    }
    // END

    // EDIT USER
    private checkUpdate = (value: string | null): boolean => {
        return value !== null && value !== "" && value !== "string";
    } // kiểm tra có giá trị mới không???

    async edit(id, userData) {
        try {
            let oldData = await this.prisma.nguoiDung.findFirst({
                where: {
                    id: parseInt(id)
                }
            })
            if (!oldData) {
                throw new HttpException(`Không tìm thấy người dùng`, HttpStatus.BAD_REQUEST)
            }
            const updateData = {};
            for (const key in userData) {
                if (Object.prototype.hasOwnProperty.call(userData, key)) {
                    // Kiểm tra điều kiện và thêm vào data nếu giá trị mới thỏa mãn
                    if (this.checkUpdate(userData[key])) {
                        updateData[key] = userData[key];
                    } else {
                        // Nếu giá trị mới không thỏa mãn, giữ nguyên giá trị cũ
                        updateData[key] = oldData[key];
                    }
                }
            }
            let data = await this.prisma.nguoiDung.update({
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

    // DELETE USER
    async delete(userId) {
        try {
        let data = await this.prisma.nguoiDung.findFirst({
            where: {
                id: parseInt(userId)
            }
        })
        if (!data) {
            return {
                success: false,
                message: "Không tìm thấy id",
            }
        }
        await this.prisma.nguoiDung.delete({
            where: {
                id: parseInt(userId)
            }
        })
        return {
            success: true,
            message: "Xoá thành công",
        }
        }
        catch (error) {
            throw new HttpException(`Error: ${error.message}`, HttpStatus.INTERNAL_SERVER_ERROR)
        }
    }
    // END

    // GET USER BY NAME
    async getUserByName(userName) {
        try {
            const data = await this.prisma.nguoiDung.findMany({
                where: {
                    user_name: {
                        contains: userName,
                    },
                },
            });
            return data;
        }
        catch (error) {
            throw new HttpException(`Error: ${error.message}`, HttpStatus.INTERNAL_SERVER_ERROR)
        }
    }
    // END

    // UPLOAD AVATAR
    async upload_avatar(file, token) {
        try {
            const decodeToken = this.jwtService.decode(token)
            if (!decodeToken) {
                throw new HttpException('Token không hợp lệ', HttpStatus.BAD_REQUEST);
            }
            const { id } = decodeToken.data
            let userData = await this.prisma.nguoiDung.update({
                where: {
                    id: id
                },
                data: {
                    avatar: file.filename
                }
            })
            return {
                success: true,
                message: "Upload thành công",
                data: userData
            }
        }
        catch (error) {
            throw new HttpException(`Error: ${error.message}`, HttpStatus.INTERNAL_SERVER_ERROR)
        }
    }
    // END 
}