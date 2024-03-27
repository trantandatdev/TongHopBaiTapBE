import { PrismaClient } from "@prisma/client";
import { responseData } from "../config/Response.js";
import bcrypt from "bcrypt";
import { createToken } from "../config/jwt.js";
let prisma = new PrismaClient();

/*-------------------------- SIGN UP --------------------------*/
export const signUp = async (req, res) => {
  let { email, mat_khau, ho_ten, tuoi } = req.body;
  let checkUser = await prisma.nguoi_dung.findFirst({
    where: {
      email,
    },
  });
  if (checkUser) {
    responseData(res, "Email đã tồn tại", "", 400);
    return;
  }
  let newData = {
    email,
    mat_khau: bcrypt.hashSync(mat_khau, 10),
    ho_ten,
    tuoi,
  };
  await prisma.nguoi_dung.create({ data: newData });
  responseData(res, "Đăng ký thành công", "", 200);
};
/*-------------------------- END ----------------------------*/

/*-------------------------- LOGIN --------------------------*/
export const login = async (req, res) => {
  let { email, mat_khau } = req.body;
  let checkUser = await prisma.nguoi_dung.findFirst({
    where: {
      email,
    },
  });
  if (checkUser) {
    if (bcrypt.compareSync(mat_khau, checkUser.mat_khau)) {
      let token = createToken({ nguoi_dung_id: checkUser.nguoi_dung_id });
      responseData(res, "Đăng nhập thành công", { user: checkUser, token }, 200);
    } else {
      responseData(res, "Sai tài khoản hoặc mật khẩu", "", 400);
    }
  } else {
    responseData(res, "Sai tài khoản hoặc mật khẩu", "", 400);
  }
};
/*-------------------------- END ----------------------------*/
