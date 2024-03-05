import express from "express";
import { login, order, register } from "../controllers/userController.js";
import { protect } from "../controllers/tokenController.js";

const userRoute = express.Router();

userRoute.post("/login", login);

userRoute.post("/register", register);

// XỬ LÝ USER ĐẶT MÓN ----------------------
userRoute.post("/order/:food_id", protect, order); // Đặt món

export default userRoute;
