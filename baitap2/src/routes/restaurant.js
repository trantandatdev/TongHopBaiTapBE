import express from "express";
import { addRate, getLikeOfRestaurant, getLikeOfUser, getRateOfRestaurant, getRateOfUser, likeAndDisLike } from "../controllers/restaurantController.js";
import { protect } from "../controllers/tokenController.js";

const restaurantRoute = express.Router();

// XỬ LÝ LIKE NHÀ HÀNG ----------------------
restaurantRoute.post("/likeAndDisLike", protect, likeAndDisLike); // Xử lý like nhà hàng (like, unlike)

restaurantRoute.get("/getLikeOfRestaurant/:res_id", getLikeOfRestaurant); // lấy danh sách like theo nhà hàng

restaurantRoute.get("/getLikeOfUser/:user_id", getLikeOfUser); // lấy danh sách like theo user

// XỬ LÝ ĐÁNH GIÁ NHÀ HÀNG ----------------------
restaurantRoute.post("/addRate", protect, addRate); // Xử lý thêm đánh giá

restaurantRoute.get("/getRateOfRestaurant/:res_id", getRateOfRestaurant); // lấy danh sách đánh giá theo nhà hàng

restaurantRoute.get("/getRateOfUser/:user_id", getRateOfUser); // lấy danh sách đánh giá theo user

export default restaurantRoute;
