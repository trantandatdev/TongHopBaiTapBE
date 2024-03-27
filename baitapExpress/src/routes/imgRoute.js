import express from "express";
import {
  deleteImg,
  getComment,
  getImg,
  getImgByName,
  getImgByUser,
  postComment,
} from "../Controller/imgController.js";

const imgRoute = express.Router();

// GET
imgRoute.get("/get-img", getImg);
imgRoute.get("/get-img-by-name/:imgName", getImgByName);
imgRoute.get("/getImg-byUser/:userId", getImgByUser);
imgRoute.get("/get-comment/:imgId", getComment);

// POST
imgRoute.post("/comment/:imgId", postComment);

// DELETE
imgRoute.delete("/delete-img/:imgId", deleteImg);

export default imgRoute;
