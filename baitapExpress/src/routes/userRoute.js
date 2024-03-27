import express from "express";
import {
  checkSave,
  deleteSave,
  editUser,
  getSaveImg_byUser,
  getUserInfo,
  uploadImg,
  userSaveImg,
} from "../Controller/userController.js";
import upload from "../config/uploadImg-multerSetup.js";

const userRoot = express.Router();

// GET
userRoot.get("/info/:userId", getUserInfo);
userRoot.get("/checkSave/:imgId", checkSave);
userRoot.get("/getSave-byUser", getSaveImg_byUser);

// POST
userRoot.post("/upload-img", upload.single("userImg"), uploadImg);
userRoot.post("/save-img/:imgId", userSaveImg);

// PUT
userRoot.put("/edit-profile", upload.single("userAvatar"), editUser);

// DELETE
userRoot.delete("/unsave/:imgId", deleteSave);

export default userRoot;
