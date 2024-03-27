import express from "express";
import cors from "cors";
import rootRoute from "./routes/rootRoute.js";

const app = express();

app.use(cors());
app.use(express.static("."));
app.listen(8080);
app.use(express.json());

app.use(rootRoute);
