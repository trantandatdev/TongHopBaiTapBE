**Capstone ExpressJs**
--
**Library**
- Express
- Dotenv
- Prisma
- Prisma@client
- Jsonwebtoken
- Bcrypt
- Cors
- Nodemone
- Multer
  
**Workspace**
--
**1. Install package:**
   ```
   yarn install
   ```
**2. Connect database:**

   - Create:
   ```
   yarn prisma init
   ```

   - Edit file ".env":
   ![alt text](https://www.prisma.io/docs/static/a3179ecce1bf20faddeb7f8c02fb2251/42cbc/mysql-connection-string.png)
   
   - Edit schema.prisma:
   ```
   generator client {
   provider = "prisma-client-js"}

   datasource db {
    provider = "mysql"
    url      = env("DATABASE_URL")}
   ```

   - Create new or Pull database:
     + Pull database "db_capstone.sql":
     ```
     yarn prisma db pull
     ```
     + Create:
     ```
     yarn prisma db push
     ```

   - Generate:
 ```
 yarn prisma generate
 ```

**3. Start project:**
   - Start:
 ```
 yarn start
 ```

**Usage**
--
- Using Postman API Platform to show method:
  > Import file "Capstone_ExpressJS.postman_collection.json" to Postman.


  

  
