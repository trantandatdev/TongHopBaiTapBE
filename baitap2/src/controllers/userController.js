import { createToken } from "../helpers/jwtToken.js";
import { sequelize } from "./../models/connect.js";
import initModels from "./../models/init-models.js";
import bcrypt from "bcrypt";

const model = initModels(sequelize);

const login = async (req, res) => {
    try {
        const { email, password } = req.body;

        const userExist = await model.users.findOne({ where: { email } }); // tìm user theo email

        if (!userExist) return res.status(400).json({ message: "Email không đúng" }); // nếu email chưa tồn tại

        let isPassword = bcrypt.compareSync(password, userExist.password); // kiểm tra password

        if (!isPassword) return res.status(400).json({ message: "Mật khẩu không đúng" }); // nếu password không đúng

        let token = createToken({ user_id: userExist.user_id, full_name: userExist.full_name, email: userExist.email }); // tạo token

        res.status(200).json({
            message: "Đăng nhập thành công",
            data: {
                token,
            },
        });
    } catch (error) {
        console.error("login:", error);

        res.status(400).json({ message: "Xử lý không thành công" });
    }
};

const register = async (req, res) => {
    try {
        const { full_name, email, password } = req.body;

        const userExist = await model.users.findOne({ where: { email } }); // tìm user theo email

        if (userExist) return res.status(400).json({ message: "Người dùng đã tồn tại" }); // nếu người dùng đã tồn tại

        let passwordHash = bcrypt.hashSync(password, 10); // mã hoá password

        const newUser = await model.users.create({
            full_name,
            email,
            password: passwordHash,
        });

        res.status(200).json({
            message: "Đăng ký thành công",
            data: {
                full_name: newUser.full_name,
                email: newUser.email,
            },
        });
    } catch (error) {
        console.error("register", error);

        res.status(400).json({
            message: "Đăng ký không thành công",
        });
    }
};

const order = async (req, res) => {
    try {
        const { food_id } = req.params;
        const { user_id, amount, code, arr_sub_id } = req.body;

        const foodExist = await model.food.findOne({ where: { food_id } });

        if (!foodExist) return res.status(400).json({ message: "Food không tồn tại" }); // nếu food chưa tồn tại

        const orderCreate = await model.orders.create({
            user_id,
            food_id: foodExist.food_id,
            amount,
            code,
            arr_sub_id,
        });

        const data = await model.orders.findOne({
            attributes: {
                exclude: ["user_id", "food_id"],
            },
            where: {
                orders_id: orderCreate.orders_id,
            },
            include: [
                {
                    model: model.food,
                    as: "food",
                },
            ],
        });

        res.status(200).json({
            message: "Xử lý thành công",
            data,
        });
    } catch (error) {
        console.error("order", error);

        res.status(400).json({
            message: "Xử lý không thành công",
        });
    }
};

export { login, register, order };
