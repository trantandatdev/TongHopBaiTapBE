import multer from "multer";

let storage = multer.diskStorage({
  destination: process.cwd() + "/public/img",
  filename: (req, file, callback) => {
    let imgName = new Date().getTime() + "_" + file.originalname;
    callback(null, imgName);
  },
});
let upload = multer({ storage });

export default upload;
