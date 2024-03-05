import initModels from "../models/init-models.js";
import { sequelize } from "./../models/connect.js";

const model = initModels(sequelize);

const likeAndDisLike = async (req, res) => {
    try {
        const { user_id, date_like, res_id } = req.body;

        const resExist = await model.restaurant.findOne({ where: { res_id } });

        if (!resExist) return res.status(400).json({ message: "Restaurant không tồn tại" });

        const likeExist = await model.like_res.findOne({ where: { user_id, res_id } });

        // nếu đã tồn tại => like hoặc dislike
        if (likeExist) {
            // nếu đã like => dislike
            if (!likeExist.dis_like) {
                await model.like_res.update(
                    { ...likeExist, dis_like: 1 },
                    {
                        where: {
                            like_res_id: likeExist.like_res_id,
                        },
                        returning: true,
                    }
                );

                const data = await model.like_res.findOne({
                    attributes: ["like_res_id", "date_like", "dis_like"],
                    where: {
                        like_res_id: likeExist.like_res_id,
                    },
                    include: [
                        {
                            model: model.restaurant,
                            as: "re",
                        },
                    ],
                });

                res.status(200).json({
                    message: "dislike thành công",
                    data,
                });
            }

            // nếu chưa like => like
            if (likeExist.dis_like) {
                await model.like_res.update(
                    { ...likeExist, dis_like: 0 },
                    {
                        where: {
                            like_res_id: likeExist.like_res_id,
                        },
                    }
                );

                const data = await model.like_res.findOne({
                    attributes: ["like_res_id", "date_like", "dis_like"],
                    where: {
                        like_res_id: likeExist.like_res_id,
                    },
                    include: [
                        {
                            model: model.restaurant,
                            as: "re",
                        },
                    ],
                });

                res.status(200).json({
                    message: "like thành công",
                    data,
                });
            }
        }

        // nếu chưa tồn tại => tạo mới (default = like)
        if (!likeExist) {
            const createdLike = await model.like_res.create({
                user_id,
                res_id: +res_id,
                date_like,
            });

            const data = await model.like_res.findOne({
                attributes: ["like_res_id", "date_like", "dis_like"],
                where: {
                    like_res_id: createdLike.like_res_id,
                },
                include: [
                    {
                        model: model.restaurant,
                        as: "re",
                    },
                ],
            });

            res.status(200).json({
                message: "like thành công",
                data,
            });
        }
    } catch (error) {
        console.error("likeAndDisLike:", error);

        res.status(400).json({ message: "Xử lý không thành công" });
    }
};

const getLikeOfRestaurant = async (req, res) => {
    try {
        const { res_id } = req.params;

        const resExist = await model.restaurant.findOne({ where: { res_id } });

        if (!resExist) return res.status(400).json({ message: "Restaurant không tồn tại" });

        const listLikeOfRes = await model.like_res.findAll({
            attributes: ["like_res_id", "date_like", "dis_like"],
            where: {
                res_id: resExist.res_id,
                dis_like: 0,
            },
            include: [
                {
                    model: model.users,
                    as: "user",
                    attributes: {
                        exclude: ["password"],
                    },
                },
            ],
        });

        res.status(200).json({
            message: "Xử lý thành công",
            data: {
                ...resExist.dataValues,
                listLikeOfRes,
            },
        });
    } catch (error) {
        console.error("getLikeOfRestaurant:", error);

        res.status(400).json({ message: "Xử lý không thành công" });
    }
};

const getLikeOfUser = async (req, res) => {
    try {
        const { user_id } = req.params;

        const userExist = await model.users.findOne({
            attributes: {
                exclude: ["password"],
            },
            where: { user_id },
        });

        if (!userExist) return res.status(400).json({ message: "User không tồn tại" });

        const likeOfUser = await model.like_res.findAll({
            attributes: ["like_res_id", "date_like", "dis_like"],
            where: {
                user_id: userExist.user_id,
                dis_like: 0,
            },
            include: [
                {
                    model: model.restaurant,
                    as: "re",
                },
            ],
        });

        res.status(200).json({
            message: "Xử lý thành công",
            data: {
                ...userExist.dataValues,
                likeOfUser,
            },
        });
    } catch (error) {
        console.error("getLikeOfUser:", error);

        res.status(400).json({ message: "Xử lý không thành công" });
    }
};

const addRate = async (req, res) => {
    try {
        const { user_id, date_rate, amount, res_id } = req.body;

        const resExist = await model.restaurant.findOne({ where: { res_id } });

        if (!resExist) return res.status(400).json({ message: "Restaurant không tồn tại" });

        const createRate = await model.rate_res.create({
            user_id,
            res_id,
            amount,
            date_rate,
        });

        const data = await model.rate_res.findOne({
            attributes: ["rate_res_id", "amount", "date_rate"],
            where: {
                rate_res_id: createRate.rate_res_id,
            },
            include: [
                {
                    model: model.restaurant,
                    as: "re",
                },
            ],
        });

        res.status(200).json({
            message: "Xử lý thành công",
            data,
        });
    } catch (error) {
        console.error("addRate:", error);

        res.status(400).json({ message: "Xử lý không thành công" });
    }
};

const getRateOfRestaurant = async (req, res) => {
    try {
        const { res_id } = req.params;

        const resExist = await model.restaurant.findOne({ where: { res_id } });

        if (!resExist) return res.status(400).json({ message: "Restaurant không tồn tại" });

        const listRateOfRes = await model.rate_res.findAll({
            attributes: ["rate_res_id", "amount", "date_rate"],
            where: {
                res_id: resExist.res_id,
            },
            include: [
                {
                    model: model.users,
                    as: "user",
                    attributes: {
                        exclude: ["password"],
                    },
                },
            ],
        });

        res.status(200).json({
            message: "getRateOfRestaurant",
            data: {
                ...resExist.dataValues,
                listRateOfRes,
            },
        });
    } catch (error) {
        console.error("getRateOfRestaurant:", error);

        res.status(400).json({ message: "Xử lý không thành công" });
    }
};

const getRateOfUser = async (req, res) => {
    try {
        const { user_id } = req.params;

        const userExist = await model.users.findOne({
            attributes: {
                exclude: ["password"],
            },
            where: { user_id },
        });

        if (!userExist) return res.status(400).json({ message: "User không tồn tại" });

        const rateOfUser = await model.rate_res.findAll({
            attributes: ["rate_res_id", "amount", "date_rate"],
            where: {
                user_id: userExist.user_id,
            },
            include: [
                {
                    model: model.restaurant,
                    as: "re",
                },
            ],
        });

        res.status(200).json({
            message: "Xử lý thành công",
            data: {
                ...userExist.dataValues,
                rateOfUser,
            },
        });
    } catch (error) {
        console.error("getRateOfUser:", error);

        res.status(400).json({ message: "Xử lý không thành công" });
    }
};

export { likeAndDisLike, getLikeOfRestaurant, getLikeOfUser, addRate, getRateOfRestaurant, getRateOfUser };
