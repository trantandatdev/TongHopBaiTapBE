import { Sequelize } from "sequelize";

export const sequelize = new Sequelize("db_appfood", "root", "1234", {
    dialect: "mysql",
    host: "localhost",
    port: "3306",
});

// sequelize-auto -h localhost -d db_appfood -u root -x 1234 -p 3306 --dialect mysql -o ./src/models -l esm
// node_modules/.bin/sequelize-auto -h localhost -d db_appfood -u root -x 1234 -p 3306 --dialect mysql -o ./src/models -l esm
