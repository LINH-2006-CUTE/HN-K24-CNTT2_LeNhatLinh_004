create database hackathon;
use hackathon;

CREATE TABLE user (
    user_id varchar(5) PRIMARY KEY NOT NULL,
    user_name VARCHAR(100) NOT NULL,
    user_email VARCHAR(100) UNIQUE NOT NULL,
    user_phone VARCHAR(15) NOT NULL
);

CREATE TABLE product (
    product_id VARCHAR(5) NOT NULL PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    product_price DECIMAL(10 , 2 ) NOT NULL,
    stock_quantity INT NOT NULL
);

CREATE TABLE order_hk (
    order_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    user_id VARCHAR(5) NOT NULL,
    order_date DATE NOT NULL,
    total_price DECIMAL(10 , 2 ) NOT NULL,
    order_status VARCHAR(20) NOT NULL,
	FOREIGN KEY (user_id) REFERENCES order_hk(user_id)
);

CREATE TABLE order_detail (
    oder_detail_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id VARCHAR(5) NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10 , 2 ) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES order_hk(order_id),
	FOREIGN KEY (product_id) REFERENCES product(product_id)
);

INSERT INTO user (user_id, user_name,user_email,user_phone) VALUES
('U001', 'Nguyen Van An', 'an.nguyen@gmail.com', '0912345678'),
('U002', 'Tran Thi Bich', 'bich.tran@gmail.com', '0923456789'),
('U003', 'Le Hoang Minh', 'minh.le@gmail.com', '0934567890'),
('U004', 'Pham Thu Ha', 'ha.pham@gmail.com', '0945678901'),
('U005', 'Vo Quoc Huy', 'huy.vo@gmail.com', '0956789012');

INSERT INTO product (product_id, product_name, product_price, stock_quantity) VALUES 
('P001', 'Ao thun nam', '199000', 50),
('P002', 'Quan jean nu', '399000', 40),
('P003', 'Giay sneaker', '899000', 30),
('P004', 'Tui xach thoi trang', '599000', 20),
('P005', 'Dong ho deo tay', '1299000', 15);


INSERT INTO order_hk (order_id, user_id, order_date, total_price, order_status) VALUES 
(1, 'U001', '2025-03-01', '1098000', 'Completed'),
(2, 'U002', '2025-03-02', '399000', 'Completed'),
(3, 'U003', '2025-03-03', '1798000', 'Processing'),
(4, 'U001', '2025-03-04', '599000', 'Cancelled'),
(5, 'U004', '2025-03-05', '1299000', 'Pending');

INSERT INTO order_detail (oder_detail_id, order_id, product_id, quantity, unit_price) VALUES 
(1, 1, 'P001', 2, 199000 ),
(2, 2, 'P003', 1, 899000 ),
(3, 3, 'P002', 1, 399000 ),
(4, 4, 'P005', 1, 1299000 ),
(5, 5, 'P004', 1, 599000 );

-- Phan 1:
-- 3. Cập nhật thông tin người dùng. Hãy viết câu lệnh cập nhật số điện thoại của người dùng có user_id = 'U003' thành "096532628".
UPDATE user
SET 
    user_phone = '096532628'
WHERE
    user_id = 'U003';
-- 4. Do khách hàng đã huỷ đơn hàng có  order_id = 3 bị huỷ, Hãy viết câu lệnh cập nhật order_status thành "Cancelled".
UPDATE order_hk 
SET 
    order_status = 'Cancelled'
WHERE
    order_id = 3;
-- 5. Viết câu lệnh xóa tất cả các bản ghi trong bảng Order có order_status là "Cancelled" và order_date trước ngày "2025-03-04".
-- delete order_status = "Cancelled" 
-- PHẦN 2: Truy vấn dữ liệu cơ bản
-- 6.Liệt kê danh sách các đơn hàng gồm các cột: order_id, order_date, order_status có trạng thái là 'Completed' và ngày đặt hàng sau ngày “2025-03-01”.
SELECT 
    order_id, order_date, order_status
FROM
    order_hk
WHERE
    order_status = 'Completed'
        AND order_date > DATE('2025-03-01');
-- 7.Lấy thông tin user_name, user_phone, user_email, của những người dùng có số điện thoại bắt đầu bằng “09”.
SELECT 
    user_name, user_phone, user_email
FROM
    user
WHERE
    user_phone LIKE '09%';
-- 8.Hiển thị danh sách tất cả các đơn hàng gồm: order_id, user_id, order_date. Kết quả sắp xếp theo (order_date) giảm dần.
SELECT 
    order_id, user_id, order_date
FROM
    order_hk
ORDER BY order_date DESC;
-- 9.Lấy 3 bản ghi đầu tiên trong bảng Order có order_status là 'Completed'.
SELECT 
    *
FROM
    order_hk
WHERE
    order_status = 'Completed'
ORDER BY order_status
LIMIT 3;
-- 10.Hiển thị thông tin gồm mã người dùng (user_id) và tên người dùng (user_name) từ bảng User, bỏ qua 2 bản ghi đầu tiên và lấy 3 bản ghi tiếp theo (sử dụng LIMIT và OFFSET).
SELECT 
    user_id, user_name
FROM
    user
LIMIT 3 OFFSET 2;

-- PHẦN 3: Truy vấn dữ liệu nâng cao
-- 11.Hiển thị danh sách đơn hàng gồm: order_id, user_name (từ bảng User), order_date và total_price. Chỉ lấy những đơn hàng có order_status = 'Completed'.
SELECT 
    order_id, user_name, order_date, total_price
FROM
    order_hk o
        JOIN
    user u ON o.user_id = u.user_id
WHERE
    o.order_status = 'Completed';
-- 12.Liệt kê tất cả các sản phẩm trong hệ thống gồm: product_id, product_name và order_id tương ứng (nếu có). Kết quả phải bao gồm cả những sản phẩm chưa từng được bán.
select product_id, product_name, order_id from product  inner join product as p on p.


-- 13.Tính tổng số đơn hàng theo từng (order_status). Kết quả hiển thị 2 cột: order_status và Total_Order.
-- 14.Thống kê số lượng đơn hàng của mỗi người dùng. Hiển thị user_id và Count_Order. Chỉ hiện những người dùng có từ 2 đơn hàng trở lên.
-- 15.Lấy thông tin các đơn hàng gồm: (order_id, order_date, total_price) có total_price lớn hơn giá trị trung bình của tất cả các đơn hàng trong bảng Order.
-- 16.Hiển thị user_name và user_phone ủa những người dùng đã từng mua sản phẩm có product_name là “Giày sneaker”.
-- ￮     Gợi ý: Truy vấn product_id từ bảng Product kết hợp với Order_Detail và Order để lấy danh sách user_id.

-- 17. Hiển thị thông tin tổng hợp gồm: order_id, user_name, product_name, quantity và unit_price.
-- ￮     Gợi ý : Yêu cầu cần kết hợp dữ liệu từ cả 4 bảng: User, Order, Order_Detail, Product.
