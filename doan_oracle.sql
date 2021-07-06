--Để thực hiện đề tài quản lý cà phế , đầu tiên ta cần phải tạo một database quản lý cửa hàng cà phê


--------Để thực hiện chức năng đăng nhập, ta phải có một bảng dangnhap ------
create table dangnhap
(
	taikhoan char(100) not null, --- tài khoản để đăng nhập,
	tentaikhoan nvarchar2(100) default 'Đồ Án Nhóm', -- tên hiển thị của tài khoản hay còn gọi là tên đăng nhập --
	matkhau nvarchar2(100) not null, --default 0 ,-- mật khẩu để đăng nhập, tạm để mật khẩu với giá trị mặc định là 0
	loaitk int default 0, --- loại tk, trả về giá int để phân biệt, ví dụ, trả về 1 là người quản trị về 0 là người dùng (tạm để mặc định là 0)
  primary key (taikhoan) -- với riêng mỗi id là xác định cho mỗi tài khoản đăng nhập
)

--------Ngoài chức năng đăng nhập thì ta cũng phải có một đối tượng là khách hàng để phân loại -----------
select * from nhanvien;
create table khachhang
(
	makh char(100) not null, --mã khách hàng
	tenkh nvarchar2(100) default ('Chưa đặt tên'), ---tên khách hàng
	loaikh char(100) not null , --- loại khách hàng để phân biệt
	primary key (makh) ---với khóa chính là mã khách hàng
)


-------Ngoài ra trong quán cà phê cũng phải có nhân viên nhưng trước hết cần phải có bảng chức vụ để phân loại----------

create table chucvu
(
	macv char(100) not null, -- mã chức vụ nhân viên
	tencv nvarchar2(100) not null,-- tên chức vụ nhân viên
	constraint chucvu_PK primary key (macv) ---- mỗi một chức vụ đều có một mã để phân biệt
)

-----------------bảng nhân viên, thuộc tính nhân viên trong cửa hàng cà phê ----------
delete 
create table nhanvien
(
	manv char(100) not null, --- mã nhân viên phục vụ
	tennv nvarchar2(100) not null, ---- tên nhân viên phục vụ
	macv char(100) not null, -- tên chức vụ
	ngaysinh date not null, --- ngày sinh của nhân viên
	ngayvaolam date not null, -- ngày vào làm
	ca int not null, --- số ca làm
	luong float not null, -- lương nhân viên
  imgNV BLOB NOT NULL, --- ảnh nhân viên
  primary key (manv), --- mỗi nhân viên đều có một mã nhân viên để phân biệt----
	Foreign Key (macv) references chucvu(macv) --- khóa ngoài giữa bảng nhân viên và bảng chức vụ với trường chung là mã chức vụ
)


------ Trong quán cà phê cũng sẽ có giới hạn số lượng bạn nên cần phải đặt bàn hoặc chọn bàn trống để sử dụng ------

create table datban
(
	maban char(100) not null, -- mã bàn
	tenban nvarchar2(100) not null, -- tên bàn ăn
	trangthaiban nvarchar2(100) default ('Trống'), --- trạng thái bài ăn (đã đặt hay chưa ) cho mặc định là trống
	primary key (maban) ---- mỗi bàn đều có một mã số riêng để phân biệt như bàn 1, bàn 2 ... -------
)

----------MENU của một cửa hàng cà phê -------

create table menu
(
	idmenu char(100) not null, -- meenu có một id riêng 
	tenmenu nvarchar2(100) not null , -- tên menu 
	primary key (idmenu) ---- mỗi menu phân biệt bởi id
)


---------Trong một quán cà phê luôn sẽ có bán thêm đồ ăn vì vậy càn một bảng thức ăn trong dữ liệu----------

create table thucan
(
	mathucan char(100) not null,--- mã thức ăn
	tenthucan nvarchar2(100) default 'Chưa đặt tên', --- tên thức ăn, mặc định là chưa đặt tên
	idmenu char(100) not null, --- menu
	giatien float default 0, -- giá tiền
	primary key (mathucan), --- mỗi món ăn được phân biệt bằng mã thức ăn
	Foreign Key (idmenu) references menu(idmenu) --- khóa ngoại thức ăn với bảng menu để đem thức ăn vào trong menu
)


----------Thức uống trong 1 quán cà phê ---------------

create table thucuong
(
	mathucuong char(100) not null,--- mã thức uống
	tenthucuong nvarchar2(100) default 'Chưa đặt tên', --- tên thức uống 
	idmenu char(100) not null,	----menu
	giatien float not null, -- giá tiền
	primary key (mathucuong), --- mỗi đồ uống có một ma đồ uống duy nhất để phân biệt
	Foreign Key (idmenu) references menu(idmenu) --- khóa ngoại thức uống là idmenu để đem thức uống vào trong menu
)


-------Trong một quán cà phê cần phải có một bảng hóa đơn để xác định trạng thái hóa đơn ----------

create table hoadon
(
	mahd char(100) not null, --mã hóa đơn
	ngaylap date, ---ngày lập hóa đơn
	ngayxuat date, --- ngày xuất hóa đơn
	makh char(100) not null, -- mã khách hàng mua
	manv char(100) not null, -- mã nhân viên bán hàng
	trangthai nvarchar2(100) default 'Chưa thanh toán', --trạng thái hóa đơn đã thanh toán hay chưa
	primary key (mahd), ---mỗi hóa đơn có duy nhất một mã hóa đơn để phân biệt
	Foreign Key (manv) references nhanvien(manv)---- khóa ngoại với bảng nhân viên với trường chung là mã nhân viên
)


-----Sau khi đã có bảng hóa đơn và các trạng thái cơ bản, bây giờ ta sẽ tạo một bảng chi tiết hóa đơn như một bill giúp in ra chi tiết người bán,khách hàng gì, trạng thái hóa đơn, tổng thức ăn và thức uống và số tiền phải trả. ------------
---drop table chitiethoadon;
create table chitiethoadon
(
  mahd char(100) not null, --mã hóa đơn
	maban char(100) not null, -- mã bàn sử dụng
	mathucan char(100) not null,--- mã thức ăn đã gọi
  mathucuong char(100) not null,--- mã thức uống đã dùng
	count1 int  default 0,	--- đếm tổng thức ăn
	count2 int  default 0, --- đếm tổng  thức uống
	tongtien float default 0,--- tổng tiền cần thanh toán
  primary key (mahd,maban), ---- mỗi một hóa đơn in ra chỉ duy nhất một hóa đơn cho riêng một khách hàng
	---- khóa ngoại ---
	Foreign Key (mathucuong) references thucuong(mathucuong), --- khóa ngoại giữa bảng hóa đơn và thức uống sẽ có trường chung là mã thức uống
	Foreign Key (mathucan) references thucan(mathucan), --- khóa ngoại giữa bảng hóa đơn và thức ăn sẽ có trường chung là mã thức ăn
	Foreign Key (maban) references datban(maban), ---khóa ngoại với bảng đặt bàn trường chung là mã đặt bàn
	Foreign Key (mahd) references hoadon(mahd) ---khóa ngoại với bảng đặt bàn trường chung là mã đặt bàn
)


------ràng buộc điều kiện cơ bản cho database để thực hiện được đồ án quản lý cà phế -------
alter table dangnhap
Add constraint uni_taikhoan unique(taikhoan);   ---->> mỗi một tài khoản đăng nhập là duy nhất không thể trùng nhau <<----

ALTER table khachhang
Add constraint uni_khachhang unique(makh);	----->> mỗi một khách hàng chỉ có thể tồn tội một mã khách hàng duy nhất xác định để có thể tận hưởng quyền lợi của cửa hàng tùy theo mã và loại khách hàng <<---


alter table chucvu
Add constraint uni_chucvu unique(macv);		--->> mỗi chức vụ chỉ có một mã chức vụ duy nhất <<---


alter table nhanvien
Add constraint uni_nhanvien unique(manv);	--->>Mỗi một nhân viên sẽ có một mã nhân viên duy nhất không thế trùng nhau <<----


alter table datban
Add constraint uni_datban unique(maban); --->>> một bàn sẽ có một mã số để phân biệt như bàn 1, bàn 2 , bàn 3.... nhưng không thể trùng nhau <<<---


alter table hoadon
Add constraint uni_hoadon unique(mahd); ---->> mỗi mã hóa đơn không thể trùng nhau  <<<----

alter table thucuong
Add constraint uni_thucuong unique(mathucuong); -->>> mỗi thức uống là duy nhất không thể trùng <<<---


alter table thucan
Add constraint uni_thucan unique(mathucan); ---->>> mỗi thức ăn là duy nhất, không thể trùng <<<---


alter table chitiethoadon
add constraint check_tongtien check(tongtien>=0); --->>> tông tiền phải trả không thể là số âm <<---

alter table thucan
add constraint check_giatienthucan check(giatien>0); --->>> giá tiền của thức ăn không thể nhỏ hơn 0 <<<<----

alter table thucuong
add constraint check_giatienthucuong check(giatien>=0); ----->>> Giá tiền của thức uống không thể nhỏ hơn 0 <<<----


--alter table nhanvien
--add constraint check_vaolam check(ngayvaolam < SYSDATE); ----->>> ngày lập hóa đơn không thể bé hơn ngày hiện tại  <<<----


--alter table nhanvien
--add constraint check_ngaysinh check((sysdate()-ngaysinh) > 18); ----->>> nhân viên vào làm không thể nhỏ hơn 18 tuổi  <<<----


ALTER TABLE hoadon
MODIFY ngaylap DEFAULT SYSDATE; --->> Ngày lập hóa đơn sẽ là ngày hôm nay nếu k có giá trị xác định <<---


ALTER TABLE hoadon
MODIFY ngayxuat DEFAULT SYSDATE; --->> Ngày xuất hóa đơn sẽ là ngày hôm nay nếu k có giá trị xác định <<---


ALTER TABLE datban
ADD CONSTRAINT check_bàn CHECK (trangthaiban ='TRỐNG' or trangthaiban = 'CÓ NGƯỜI' );--->> trạng trái của bàn chỉ có thể trống hoặc đã có người <<<-----


insert all
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH001','Nguyễn Văn Tùng','VIP')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH002','Trần Lâm Ánh','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH003','Nguyễn Ngân Long','FAMILIAR')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH004','Hà Hồ An','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES ('KH005','Trọng Trình Chung','VIP')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH006','Ngô Tố Lâm','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH007','Đặng Kiều Như','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH008','Nguyễn Xuân Phúc','FAMILIAR')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH009','Ngô Tố Như','FAMILIAR')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH010','Vũ Văn Lộc','VIP')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH011','Trần Thị Thúy Vy','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH012','Nguyễn Ngô Như Ý','FAMILIAR')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH013','Hà Minh Hồ','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH014','Lâm Chí Vĩ','VIP')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH015','Vũ Ngọc Thúy','FAMILIAR')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH016','Trần Minh Hưng ','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH017','Hồ Ngọc Hà','FAMILIAR')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH018','Võ Minh Nhật','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH019','Võ Thị Tú Quyên','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH020','Phan Nhật Long','FAMILIAR')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH021','Nguyễn Minh Cường','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH022','Phạm Thị Thúy Nga','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH023','Đỗ Ngọc Long An','VIP')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH024','Hoàng Nhật Minh','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH025','Ngô Minh An Thần','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH026','Trần Ngõ Đô','FAMILIAR')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH027','Nguyễn Thị Thùy Dương','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH028','Võ Châu Minh Cường','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH029','Võ Thị Hà My','VIP')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH030','Đinh Huyền My','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH031','Hoàng Tâm Ân','FAMILIAR')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH032','Nhật Đặng Minh Quân','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH033','Đinh Ngô Nhật Quỳnh','VIP')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH034','Dương Minh Nhật','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH035','Hoàng Văn Chính','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH036','Phạm Hạ My','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH037','Đặng Nhật Kiên','VIP')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH038','Phan Huyền Trang','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH039','Nguyễn Thảo Anh','VIP')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH040','Nguyễn Thị Mai Thảo','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH041','Thẩm Tú Quỳnh','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH042','Ngô Minh Hoàng Quân','FAMILIAR')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH043','Hoàng Vân Anh','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH044','Nhật Minh Ngô','FAMILIAR')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH045','Lò Văn Khải','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH046','Hà Thị Phương','FAMILIAR')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH047','Nông Văn Dương','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH048','Hà Đỗ Thị An','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH049','Lù Thị Lý','FAMILIAR')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH050','Ưng Hoàng Phúc','VIP')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH051','Nghiêm Ngọc Hà','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH052','Lưu Văn Hiếu','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH053','Văn Mai Hương','FAMILIAR')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH054','Trần Thủy Trúc','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH055','Lê Ngô Gia Bảo','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH056','Phan Nguyễn Trúc Linh','FAMILIAR')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH057','Ngân Văn Lâm','FAMILIAR')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH058','Nguyễn Hà My','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH059','Đoàn Chí Bảo','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH060','Vũ Hoàng Quân','VIP')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH061','Dương Mai Hương','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH062','Trần Thị Trà My','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH063','Ngô Hương Lan','FAMILIAR')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH064','Vũ Thị Hải My','VIP')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH065','Nguyễn Ngọc Minh','FAMILIAR')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH066','Đào Linh Anh','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH067','Nguyễn Hương Ly','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH068','Lê Nguyễn Thị Tú ','FAMILIAR')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH069','Huỳnh Ngọc Diệp','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH070','Đoàn Diễm Quỳnh','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH071','Vũ Thị Mai','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH072','Trương Hoàng Linh','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH073','Trần Kim Ngân','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH074','Mai Tú Hảo','VIP')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH075','Châu Thị Mỹ Ngân','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH076','Phạm Thị Thúy Nga','FAMILIAR')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH077','Nguyễn Bảo Ngọc','VIP')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH078','Trần Quốc Toản','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH079','Trần Đăng Khôi','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH080','Hà Thị Tuyết Nhung','VIP')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH081','Hoa Phong Lan','FAMILIAR')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH082','Đỗ Kỳ Duyên','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH083','Đàm Thị Hạ','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH084','Nguyễn Ngọc Vũ','VIP')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH085','Võ Đình Sơn Lâm','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH086','Nguyễn Thu Thùy','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH087','Trần Hương Quỳnh','VIP')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH088','Đặng Thị Thư','FAMILIAR')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH089','Trần Minh Thư','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH090','Đoàn Diễm Tú Quỳnh','FAMILIAR')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH091','Trần Tuyết Nam','FAMILIAR')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH092','Nguyễn Văn Tài','NORMAL')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH093','Bùi Thành Lộc','FAMILIAR')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH094','Nguyễn Văn Triều','VIP')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH095','Hoàng Đàm Hoài Lâm','FAMILIAR')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH096','Phạm Tuấn Khang','VIP')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH097','Đinh Hồng Ánh','VIP')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH098','Ngô Thị Bích','FAMILIAR')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH099','Tống Mỹ Duyên','FAMILIAR')
INTO KHACHHANG (makh,tenkh,loaikh) VALUES('KH100','Lê Văn Bình','FAMILIAR')
SELECT * FROM dual;
select * from khachhang; ---câu lệnh để kiểm tra

insert all
insert into chucvu values('QL01','QUẢN LÝ');
insert into chucvu values('NV01','NHÂN VIÊN PHA CHẾ');
insert into chucvu values('NV02','NHÂN VIÊN THU NGÂN');
insert into chucvu values('NV03','NHÂN VIÊN BÀN');
insert into chucvu values('NV04','NHÂN VIÊN VỆ SINH');
insert into chucvu values('NV05','NHÂN VIÊN BẢO VỆ');
SELECT * FROM dual;

select * from chucvu; -- lệnh kiểm tra


insert all;
insert into nhanvien2 values('NV001','Trương Văn Bá','QL01','30/Jan/1999','23/Aug/2018',4,'9000000','C:\Users\lenovo\Desktop\dan_ong1');
insert into nhanvien values('NV002','Ngọ Lâm Chung','NV01','23/Dec/1999','21/Oct/2018',3,'8500000');
insert into nhanvien values('NV003','Bùi Thị Minh Ánh','NV01','4/Jul/1998','17/Dec/2018',3,'8000000');
insert into nhanvien values('NV004','Ngõ Ngô Tố Quỳnh','NV02','23/Jul/2000','3/Jan/2019',3,'7500000');
insert into nhanvien values('NV005','Đặng Phùng Bích Ngân','NV03','13/Sep/2000','8/Apr/2019',3,'7000000');
insert into nhanvien values('NV006','Võ Văn Song Toàn','NV03','29/Aug/2001','23/Jul/2019',2,'6500000');
insert into nhanvien values('NV007','Tôn Hốt Cốt','NV04','21/Mar/2002','25/Mar/2020',2,'6000000');
insert into nhanvien values('NV008','Mã Thị Yến Nhi','NV04','19/Oct/2002','13/Apr/2020',2,'5500000');
insert into nhanvien values('NV009','Đặng Trọng Phương Anh','NV03','19/Sep/2001','8/Apr/2019',3,'7000000');
insert into nhanvien values('NV010','Võ Song Quỳnh Nhi','NV03','29/May/2001','23/Sep/2019',2,'7500000');
insert into nhanvien values('NV011','Tôn Nhật Đại','NV05','21/Apr/2002','22/Apr/2020',2,'6000000');
SELECT * FROM dual;

select * from nhanvien; -- lệnh kiểm tra

insert all
insert into menu values('MENU01','CÁC LOẠI BÁNH VÀ THỨC ĂN NHANH');
insert into menu values('MENU02','THỨC ĂN ĐIỂM TÂM');
insert into menu values('MENU03','CÁC LOẠI COFFE');
insert into menu values('MENU04','CÁC LOẠI SINH TỐ');
insert into menu values('MENU05','CÁC LOẠI TRÀ SỮA');
SELECT * FROM dual;

select * from menu; -- lệnh kiểm tra

insert all
--delete from thucan;
--delete from hoadon;

insert into thucan values('TA01','BÁNH FLAN','MENU01','10000');
insert into thucan values('TA02','BÁNH BÔNG LAN TRỨNG MUỐI','MENU01','15000');
insert into thucan values('TA03','BÁNH SU KEM','MENU01','10000');
insert into thucan values('TA04','BÁNH TIRAMISU','MENU01','25000');
insert into thucan values('TA05','BÁNH CUPCAKE','MENU01','25000');
insert into thucan values('TA06','BÁNH MATCHA','MENU01','29000');
insert into thucan values('TA07','BÁNH MÌ CHÀ BÔNG PHÔ MAI CHEESE','MENU01','32000');
insert into thucan values('TA08','BÁNH PASSION CHEESE','MENU01','29000');
insert into thucan values('TA09','BÁNH GẤU CHOCOLATE','MENU01','24000');
insert into thucan values('TA10','BÁNH MOUSSE CAKE','MENU01','19000');
insert into thucan values('TA11','BÁNH KEM ĐẬU XANH','MENU01','20000');
insert into thucan values('TA12','BÁNH MACARON','MENU01','20000');
-------vì để có lợi ích cao và độ lợi nhuận cao, quán cà phê sẽ kinh doanh các bữa ăn sáng - trưa hoặc tối phục vụ cho một bộ phận khách hàng nhất định--------
insert into thucan values('TA13','MÌ XÀO GIÒN','MENU02','50000');
insert into thucan values('TA14','CƠM CHIÊN DƯƠNG CHÂU','MENU02','43000');
insert into thucan values('TA15','MÌ ỐNG SỐT THỊT SPAGHETTI,','MENU02','70000');
insert into thucan values('TA16','CƠM XỐI MỠ GÀ','MENU02','47000');
insert into thucan values('TA17','TRỨNG CUỘN OMURICE','MENU02','42000');
SELECT * FROM dual;

select * from thucan; -- kiểm tra dữ liệu

select * from thucuong;
insert all;
insert into thucuong values('TU01','CÀ PHÊ PHIN SỮA ĐÁ BẠC XỈU','MENU03','32000');
insert into thucuong values('TU02','CÀ PHÊ PHIN ĐEN ĐÁ','MENU03','27000');
insert into thucuong values('TU03','CÀ PHÊ TRUNG NGUYÊN','MENU03','40000');
insert into thucuong values('TU04','CÀ PHÊ CHỒN','MENU03','79000');
insert into thucuong values('TU05','COFFEE KEM ESPRESSO','MENU03','37000');
insert into thucuong values('TU06','COFFEE ROBUSTA','MENU03','38000');
insert into thucuong values('TU07','COFFEE CHÈ ARABICA','MENU03','34000');
insert into thucuong values('TU08','COFFEE CULI ĐẬM ĐẶC','MENU03','41000');
insert into thucuong values('TU09','COFFEE MOKA','MENU03','40000');
insert into thucuong values('TU10','COFFE KEM MACCHIATO','MENU03','42000');
insert into thucuong values('TU11','COFFEE SỮA CAPPUCCINO','MENU03','53000');
insert into thucuong values('TU12','COFFEE NÓNG MOCHA','MENU03','52000');
insert into thucuong values('TU13','SINH TỐ VIỆT QUẤT','MENU04','43000');
insert into thucuong values('TU14','SINH TỐ CAM XOÀI','MENU04','37000');
insert into thucuong values('TU15','CHANH SẢ ĐÁ XAY','MENU04','28000');
insert into thucuong values('TU16','SINH TỐ VẢI CHANH','MENU04','31000');
insert into thucuong values('TU17','SINH TỐ CAM VẮT MẬT ONG','MENU04','36000');
insert into thucuong values('TU18','SINH TỐ KEM SỮA DƯA GANG','MENU04','24000');
insert into thucuong values('TU19','TRÀ SỮA CHÂN CHÂU TRẮNG','MENU05','34000');
insert into thucuong values('TU20','TRÀ SỮA TRÂN CHÂU ĐƯỜNG ĐEN','MENU05','43000');
insert into thucuong values('TU21','TRÀ SỮA MATCHA ĐẶC','MENU05','46000');
insert into thucuong values('TU22','TRÀ SỮA HOA LÀI','MENU05','48000');
insert into thucuong values('TU23','TRÀ SỮA ANH ĐÀO','MENU05','53000');
SELECT * FROM dual;

select * from thucuong; -- lệnh kiểm tra

--delete from datban;
insert all
insert into datban values('BAN01','BÀN 1','CÓ NGƯỜI');
insert into datban values('BAN02','BÀN 2','CÓ NGƯỜI');
insert into datban values('BAN03','BÀN 3','TRỐNG');
insert into datban values('BAN04','BÀN 4','TRỐNG');
insert into datban values('BAN05','BÀN 5','TRỐNG');
insert into datban values('BAN06','BÀN 6','TRỐNG');
insert into datban values('BAN07','BÀN 7','TRỐNG');
insert into datban values('BAN08','BÀN 8','TRỐNG');
SELECT * FROM dual;

select * from datban; -- lệnh kiểm tra

--delete from hoadon;
insert all;
insert into hoadon values('HD001','3/May/2019','3/May/2019','KH001','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD002','4/May/2019','4/Nov/2019','KH002','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD003','5/May/2019','5/Nov/2019','KH003','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD004','6/May/2019','6/Nov/2019','KH004','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD005','7/May/2019','7/Nov/2019','KH005','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD006','8/May/2019','8/Nov/2019','KH006','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD007','9/Jun/2019','9/Nov/2019','KH007','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD008','10/Jun/2019','10/Dec/2019','KH008','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD009','11/Jun/2019','11/Jun/2019','KH009','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD010','12/Jun/2019','12/Jun/2019','KH010','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD011','13/Jun/2020','13/Jun/2020','KH011','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD012','14/Jul/2020','14/Jul/2020','KH012','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD013','15/Jul/2020','15/Jul/2020','KH013','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD014','16/Jul/2020','16/Jul/2020','KH014','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD015','17/Jul/2020','17/Jul/2020','KH015','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD016','18/Jul/2019','18/Jul/2019','KH016','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD017','19/Jul/2019','19/Jul/2019','KH017','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD018','20/Jul/2019','20/Jul/2019','KH018','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD019','20/Jul/2019','20/Jul/2019','KH019','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD020','21/Aug/2019','21/Jul/2019','KH020','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD021','21/Jul/2019','21/Jun/2019','KH021','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD022','22/Aug/2019','22/Aug/2019','KH022','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD023','3/Aug/2019','3/Aug/2019','KH023','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD024','7/Aug/2019','7/Aug/2019','KH024','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD025','8/Aug/2019','8/Aug/2019','KH025','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD026','9/Aug/2019','9/Aug/2019','KH026','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD027','10/Aug/2019','10/Aug/2019','KH027','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD028','11/Sep/2019','11/Sep/2019','KH028','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD029','12/Sep/2019','12/Sep/2019','KH029','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD030','17/Sep/2019','17/Sep/2019','KH030','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD031','21/Sep/2019','21/Sep/2019','KH031','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD032','21/Sep/2019','21/Sep/2019','KH032','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD033','29/Oct/2019','29/Oct/2019','KH033','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD034','7/Nov/2019','7/Nov/2019','KH034','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD035','8/Nov/2019','8/Nov/2019','KH035','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD036','9/Nov/2019','9/Nov/2019','KH036','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD037','10/Nov/2019','10/Nov/2019','KH037','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD038','11/Nov/2019','11/Nov/2019','KH038','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD039','11/Dec/2019','11/Dec/2019','KH039','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD040','12/Dec/2019','12/Dec/2019','KH040','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD041','18/Dec/2019','18/Dec/2019','KH041','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD042','23/Dec/2019','23/Dec/2019','KH042','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD043','28/Dec/2019','28/Dec/2019','KH043','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD044','30/Dec/2019','30/Dec/2019','KH044','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD045','1/Jan/2020','1/Jan/2020','KH045','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD046','9/Jan/2020','9/Nov/2020','KH046','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD047','10/Jan/2020','10/Jan/2020','KH047','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD048','11/Jan/2020','11/Jan/2020','KH048','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD049','12/Jan/2020','12/Jan/2020','KH049','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD050','16/Feb/2020','16/Feb/2020','KH050','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD051','19/Feb/2020','19/Feb/2020','KH051','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD052','21/Feb/2020','21/Feb/2020','KH052','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD053','25/Feb/2020','25/Feb/2020','KH053','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD054','7/Mar/2020','7/Mar/2020','KH054','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD055','8/Mar/2020','8/Mar/2020','KH055','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD056','9/Mar/2020','9/Mar/2020','KH056','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD057','10/Mar/2020','10/Mar/2020','KH057','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD058','11/Mar/2020','11/Mar/2020','KH058','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD059','12/Mar/2020','12/Mar/2020','KH059','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD060','3/Apr/2020','3/Apr/2020','KH060','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD061','4/Apr/2020','4/Apr/2020','KH061','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD062','5/Apr/2020','5/Apr/2020','KH062','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD063','6/Apr/2020','6/Apr/2020','KH063','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD064','7/Apr/2020','7/Apr/2020','KH064','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD065','8/Apr/2020','8/Apr/2020','KH065','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD066','9/May/2020','9/May/2020','KH066','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD067','10/May/2020','10/May/2020','KH067','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD068','11/May/2020','11/May/2020','KH068','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD069','12/May/2020','12 May/2020','KH069','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD070','12/May/2020','12/May/2020','KH070','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD071','4/May/2020','4/May/2020','KH071','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD072','5/May/2020','5/May/2020','KH072','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD073','6/May/2020','6/May/2020','KH073','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD074','7/May/2020','7/May/2020','KH074','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD075','8/May/2020','8/May/2020','KH075','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD076','9/Jun/2020','9/Jun/2020','KH076','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD077','10/Jun/2020','10/Jun/2020','KH077','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD078','11/Jun/2020','11/Jun/2020','KH078','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD079','12/Jun/2020','12/Jun/2020','KH079','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD080','13/Jun/2020','13/Jun/2020','KH080','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD081','4/Jun/2020','4/Jun/2020','KH081','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD082','5/Jun/2020','5/Jun/2020','KH082','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD083','16/Jun/2020','16/Jun/2020','KH083','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD084','7/Jun/2020','7/Jun/2020','KH084','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD085','8/Jul/2020','8/Jul/2020','KH085','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD086','9/Jul/2020','9/Jul/2020','KH086','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD087','10/Jul/2020','10/Jul/2020','KH087','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD088','11/Jul/2020','11/Jul/2020','KH088','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD089','12/Jul/2020','12/Jul/2020','KH089','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD090','3/Jul/2020','3/Jul/2020','KH090','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD091','4/Aug/2020','4/Aug/2020','KH091','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD092','5/Aug/2020','5/Aug/2020','KH092','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD093','6/Aug/2020','6/Aug/2020','KH093','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD094','27/Aug/2020','27/Aug/2020','KH094','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD095','8/Aug/2020','8/Aug/2020','KH095','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD096','9/Sep/2020','9/Sep/2020','KH096','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD097','10/Sep/2020','10/Sep/2020','KH097','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD098','11/Oct/2020','11/Oct/2020','KH098','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD099','12/Oct/2020','12/Oct/2020','KH099','NV004','ĐÃ THANH TOÁN');
insert into hoadon values('HD100','30/Oct/2020','30/Oct/2020','KH100','NV004','ĐÃ THANH TOÁN');
SELECT * FROM dual;

select * from hoadon;

insert all;
--delete from CHITIETHOADON;
insert INTO chitiethoadon values('HD001','BAN01','TA01','TU01','1','1','42000');
insert into chitiethoadon values('HD002','BAN02','TA01','TU01','2','0','20000');
insert into chitiethoadon values('HD003','BAN03','TA03','TU01','3','0','30000');
insert into chitiethoadon values('HD004','BAN04','TA01','TU03','1','1','42000');
insert into chitiethoadon values('HD005','BAN05','TA02','TU02','2','1','52000');
insert into chitiethoadon values('HD006','BAN06','TA04','TU05','1','1','61000');
insert into chitiethoadon values('HD007','BAN07','TA05','TU02','1','1','52000');
insert into chitiethoadon values('HD008','BAN01','TA01','TU02','1','3','91000');
insert into chitiethoadon values('HD009','BAN02','TA03','TU01','1','2','62000');
insert into chitiethoadon values('HD010','BAN03','TA04','TU03','1','2','105000');
insert into chitiethoadon values('HD011','BAN04','TA06','TU05','1','2','103000');
insert into chitiethoadon values('HD012','BAN05','TA07','TU04','1','1','111000');
insert into chitiethoadon values('HD013','BAN06','TA03','TU07','1','3','112000');
insert into chitiethoadon values('HD014','BAN07','TA02','TU11','1','2','121000');
insert into chitiethoadon values('HD015','BAN01','TA12','TU10','1','3','146000');
insert into chitiethoadon values('HD016','BAN02','TA13','TU01','1','1','82000');
insert into chitiethoadon values('HD017','BAN01','TA02','TU16','2','1','61000');
insert into chitiethoadon values('HD018','BAN01','TA15','TU14','3','3','321000');
insert into chitiethoadon values('HD019','BAN02','TA17','TU20','1','2','128000');
insert into chitiethoadon values('HD020','BAN03','TA08','TU07','3','2','155000');
SELECT * FROM dual;
select * from chitiethoadon; -- lệnh kiểm tra

SELECT * FROM THUCAN JOIN MENU ON THUCAN.IDMENU = MENU.IDMENU;
JOIN 
      LOCATIONS L ON L.LOCATION_ID = DS.LOCATION_ID
      
      SELECT ES.EMPLOYEE_ID,FIRST_NAME,SALARY,DS.DEPARTMENT_ID,DEPARTMENT_NAME,CITY
FROM EMPLOYEES ES JOIN DEPARTMENTS DS ON ES.DEPARTMENT_ID = DS.DEPARTMENT_ID JOIN 
      LOCATIONS L ON L.LOCATION_ID = DS.LOCATION_ID