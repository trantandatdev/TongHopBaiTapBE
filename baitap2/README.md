-   1 - Open docker
-   2 - Open table plus
-   3 - Create new a database in table plus
-   4 - Right click Tables => import => From SQL dump.. => select file **db_appfood.sql**
-   5 - Import file **Sequelize_app_food.postman_collection.json** in Postman

# XỬ LÝ LIKE NHÀ HÀNG

### Xử lý like nhà hàng (like, unlike)

POST: http://localhost:8080/restaurant/likeAndDisLike

### Lấy danh sách like theo nhà hàng

GET: http://localhost:8080/restaurant/getLikeOfRestaurant/:res_id

### Lấy danh sách like theo user

GET: http://localhost:8080/restaurant/getLikeOfUser/:user_id

# XỬ LÝ ĐÁNH GIÁ NHÀ HÀNG

### Xử lý thêm đánh giá

POST: http://localhost:8080/restaurant/addRate

### Lấy danh sách đánh giá theo nhà hàng

GET: http://localhost:8080/restaurant/getRateOfRestaurant/:res_id

### Lấy danh sách đánh giá theo user

GET: http://localhost:8080/restaurant/getRateOfUser/:user_id

# XỬ LÝ USER ĐẶT MÓN

### Đặt món

POST: http://localhost:8080/user/order/:food_id
