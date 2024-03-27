import { PrismaClient } from "@prisma/client";
import { responseData } from "../config/Response.js";
import fs from "fs";
import path from "path";
import { decodeToken } from "../config/jwt.js";
let prisma = new PrismaClient();

/*-------------------------- GET IMG --------------------------*/
export const getImg = async (req, res) => {
  try {
    let data = await prisma.hinh_anh.findMany();
    if (data) {
      responseData(res, "Thành công", data, 200);
    } else {
      responseData(res, "Không tìm thấy hình ảnh", null, 400);
    }
  } catch {
    responseData(res, "Lỗi", "", 500);
  }
};
/*-------------------------- END ----------------------------*/

/*-------------------------- GET IMG BY USER ID --------------------------*/
export const getImgByUser = async (req, res) => {
  try {
    let { userId } = req.params;
    userId = parseInt(userId);
    let data = await prisma.hinh_anh.findMany({
      where: {
        nguoi_dung_id: userId,
      },
      include: {
        nguoi_dung: true,
      },
    });
    if (data) {
      responseData(res, "Thành công", data, 200);
    } else {
      responseData(res, "Không tìm thấy dữ liệu", null, 400);
      return;
    }
  } catch {
    responseData(res, "Lỗi", "", 500);
  }
};
/*-------------------------- END ----------------------------*/

/*-------------------------- GET IMG BY NAME --------------------------*/
export const getImgByName = async (req, res) => {
  try {
    let { imgName } = req.params;
    let data = await prisma.hinh_anh.findMany({
      where: {
        ten_hinh: {
          contains: imgName,
        },
      },
    });
    responseData(res, "Thành công", data, 200);
  } catch {
    responseData(res, "Lỗi", "", 500);
  }
};
/*-------------------------- END ----------------------------*/

/*-------------------------- DELETE IMG --------------------------*/
export const deleteImg = async (req, res) => {
  try {
    let { imgId } = req.params;
    imgId = parseInt(imgId);
    let data = await prisma.hinh_anh.findFirst({
      where: {
        hinh_id: imgId,
      },
    });

    if (data) {
      await prisma.hinh_anh.delete({
        where: {
          hinh_id: imgId,
        },
      });
      let pathImg = process.cwd() + "/public/img";
      fs.unlinkSync(pathImg);
      responseData(res, "Xoá thành công", "", 200);
    } else {
      responseData(res, "Không tìm thấy hình ảnh", null, 400);
    }
  } catch (error) {
    responseData(res, "Lỗi", error.message, 500);
  }
};
/*-------------------------- END ----------------------------*/

/*-------------------------- POST COMMENT --------------------------*/
export const postComment = async (req, res) => {
  try {
    let { imgId } = req.params;
    let { token } = req.headers;
    let dToken = decodeToken(token);
    let { nguoi_dung_id } = dToken.data;
    let { noi_dung } = req.body;
    imgId = parseInt(imgId);
    let idAnh = await prisma.hinh_anh.findFirst({
      where: {
        hinh_id: imgId,
      },
    });
    if (idAnh == null) {
      responseData(res, "Không tìm thấy ảnh", "", 400);
      return;
    }
    let newData = {
      nguoi_dung_id,
      hinh_id: idAnh.hinh_id,
      ngay_binh_luan: new Date(),
      noi_dung,
    };
    console.log(newData);
    await prisma.binh_luan.create({ data: newData });
    responseData(res, "Post thành công", newData, 200);
  } catch {
    responseData(res, "Lỗi", "", 500);
  }
};
/*-------------------------- END ----------------------------*/

/*-------------------------- GET COMMENT --------------------------*/
export const getComment = async (req, res) => {
  let { imgId } = req.params;
  imgId = parseInt(imgId);
  let data = await prisma.binh_luan.findMany({
    where: {
      hinh_id: imgId,
    },
  });
  responseData(res, "Thành công", data, 200);
};
/*-------------------------- END ----------------------------*/
