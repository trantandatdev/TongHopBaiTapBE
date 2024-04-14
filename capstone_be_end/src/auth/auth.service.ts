import { Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { PrismaClient } from '@prisma/client';

@Injectable()
export class AuthService {
    constructor(
        private jwtService: JwtService
    ) { }
    prisma = new PrismaClient();
    // SIGN UP
    async create(userData) {
        try {
            if (userData.role === "string" || userData.role === "") {
                userData.role = "USER"
            }
            const existingUser = await this.prisma.nguoiDung.findFirst({
                where: {
                    email: userData.email
                }
            });
            if (existingUser) {
                return {
                    success: false,
                    message: 'Tài khoản đã tồn tại'
                };
            }
            const createdUser = await this.prisma.nguoiDung.create({
                data: userData,
            });
            return {
                success: true,
                message: "Đăng ký thành công",
                data: createdUser
            };
        } catch (error) {
            return {
                success: false,
                message: `Error in creating user: ${error.message}`
            };
        }
    }
    // END

    // LOGIN
    async login(user) {
        try {
            let checkUser = await this.prisma.nguoiDung.findFirst({
                where: {
                    email: user.email,
                    pass_word: user.pass_word,
                }
            });
            console.log(checkUser);

            if (!checkUser) {
                return {
                    success: false,
                    message: "Sai tài khoản hoặc mật khẩu"
                };
            } else {
                let token = await this.jwtService.signAsync({ data: { id: checkUser.id } }, { secret: "BI_MAT" })
                return {
                    success: true,
                    message: "Đăng nhập thành công",
                    token: token

                };
            }
        } catch (error) {
            return {
                success: false,
                message: `Error in finding user: ${error.message}`
            };
        }
    }
    // END
}
