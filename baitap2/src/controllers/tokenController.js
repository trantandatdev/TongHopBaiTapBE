import { checkToken, decodeToken } from "../helpers/jwtToken.js";
import { sequelize } from "../models/connect.js";
import initModels from "../models/init-models.js";

const model = initModels(sequelize);

export const protect = async (req, res, next) => {
    const { token } = req.headers;

    const isToken = checkToken(token);

    if (!isToken) return res.status(400).json("Không đủ quyền");

    const user = decodeToken(token);
    
    const userExist = await model.users.findOne({ where: { user_id: user.data.user_id } });

    req.body = {
        ...req.body,
        ...userExist.dataValues,
    };

    next();
};
