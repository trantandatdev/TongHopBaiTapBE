import { PrismaClient } from "@prisma/client";
import { responseData } from "../config/Response.js";
import { decodeToken } from "../config/jwt.js";
import bcrypt from "bcrypt";

let prisma = new PrismaClient();

/*-------------------------- UPLOAD IMG --------------------------*/
export const uploadImg = async (req, res) => {
  try {
    let { token } = req.headers;
    let dToken = decodeToken(token);
    let { nguoi_dung_id } = dToken.data;
    let { file } = req;
    let { ten_hinh, mo_ta } = req.body;
    let newData = {
      ten_hinh,
      duong_dan: file.filename,
      mo_ta,
      nguoi_dung_id,
    };
    await prisma.hinh_anh.create({ data: newData });
    responseData(res, "Upload hình thành công", file.filename, 200);
  } catch {
    responseData(res, "Lỗi", "", 500);
  }
};
/*-------------------------- END ----------------------------*/

/*-------------------------- EDIT PROFILE --------------------------*/
export const editUser = async (req, res) => {
  try {
    let { token } = req.headers;
    let dToken = decodeToken(token);
    let { file } = req;
    let { nguoi_dung_id } = dToken.data;
    let { ho_ten, tuoi, mat_khau } = req.body;

    let newData = await prisma.nguoi_dung.update({
      where: {
        nguoi_dung_id,
      },
      data: {
        ho_ten,
        tuoi,
        mat_khau: bcrypt.hashSync(mat_khau, 10),
        anh_dai_dien: file ? file.filename : null,
      },
    });
    responseData(res, "Sửa thành công", newData, 200);
  } catch {
    responseData(res, "Lỗi", "", 500);
  }
};
/*-------------------------- END ----------------------------*/

/*-------------------------- GET USER INFO --------------------------*/
export const getUserInfo = async (req, res) => {
  try {
    let { userId } = req.params;
    userId = parseInt(userId);
    let data = await prisma.nguoi_dung.findFirst({
      where: {
        nguoi_dung_id: userId,
      },
    });
    if (data) {
      responseData(res, "Thành công", data, 200);
    } else {
      responseData(res, "Không tìm thấy người dùng", null, 400);
      return;
    }
  } catch {
    responseData(res, "Lỗi", "", 500);
  }
};
/*-------------------------- END ----------------------------*/

/*-------------------------- SAVE IMG --------------------------*/
export const userSaveImg = async (req, res) => {
  let { token } = req.headers;
  let dToken = decodeToken(token);
  try {
    let { nguoi_dung_id } = dToken.data;
    let { imgId } = req.params;
    imgId = parseInt(imgId);
    let checkUser = await prisma.luu_anh.findFirst({
      where: {
        nguoi_dung_id,
        hinh_id: imgId,
      },
    });
    if (checkUser) {
      responseData(res, "Ảnh này đã được lưu trong thư mục", "", 200);
      return;
    }
    let id_IMG = await prisma.hinh_anh.findFirst({
      where: {
        hinh_id: imgId,
      },
    });
    let newData = {
      nguoi_dung_id,
      hinh_id: id_IMG.hinh_id,
      ngay_luu: new Date(),
    };
    await prisma.luu_anh.create({ data: newData });
    responseData(res, "Lưu thành công", newData, 200);
  } catch (exception) {
    responseData(res, "Lỗi", "", 500);
  }
};
/*-------------------------- END ----------------------------*/

/*-------------------------- CHECK SAVE --------------------------*/
export const checkSave = async (req, res) => {
  let { token } = req.headers;
  let dToken = decodeToken(token);
  let { nguoi_dung_id } = dToken.data;
  let { imgId } = req.params;
  imgId = parseInt(imgId);
  let getUser = await prisma.luu_anh.findFirst({
    where: {
      nguoi_dung_id,
      hinh_id: imgId,
    },
  });
  if (!getUser) {
    responseData(res, "Chưa lưu", null, 400);
    return;
  } else {
    responseData(res, "Đã lưu", "", 200);
  }
};
/*-------------------------- END ----------------------------*/

/*-------------------------- DELETE SAVE --------------------------*/
export const deleteSave = async (req, res) => {
  try {
    let { token } = req.headers;
    let dToken = decodeToken(token);
    let { nguoi_dung_id } = dToken.data;
    let { imgId } = req.params;
    let parsedImgId = parseInt(imgId);

    await prisma.luu_anh.deleteMany({
      where: {
        nguoi_dung_id: nguoi_dung_id,
        hinh_id: parsedImgId,
      },
    });
    responseData(res, "Gỡ thành công", "", 200);
  } catch {
    responseData(res, "Lỗi", "", 500);
  }
};
/*-------------------------- END ----------------------------*/

/*-------------------------- GET SAVE IMG BY USER --------------------------*/
export const getSaveImg_byUser = async (req, res) => {
  try {
    let { token } = req.headers;
    let dToken = decodeToken(token);
    let { nguoi_dung_id } = dToken.data;
    let { imgId } = req.params;
    imgId = parseInt(imgId);

    let data = await prisma.luu_anh.findMany({
      where: {
        nguoi_dung_id: nguoi_dung_id,
      },
    });
    responseData(res, "Thành công", data, 200);
  } catch (err) {
    responseData(res, "Lỗi", err.message, 500);
  }
};
/*-------------------------- END ----------------------------*/
