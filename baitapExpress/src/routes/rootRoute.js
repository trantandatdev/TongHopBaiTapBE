import express from "express";
import authRoot from "./authRoute.js";
import userRoot from "./userRoute.js";
import imgRoute from "./imgRoute.js";

const rootRoute = express.Router();

rootRoute.use("/auth", authRoot);
rootRoute.use("/user", userRoot);
rootRoute.use("/image", imgRoute);

export default rootRoute;
