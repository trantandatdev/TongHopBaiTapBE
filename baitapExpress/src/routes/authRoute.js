import express from "express";
import { login, signUp } from "../Controller/authController.js";

const authRoot = express.Router();

authRoot.post("/sign-up", signUp);
authRoot.post("/login", login);

export default authRoot;
