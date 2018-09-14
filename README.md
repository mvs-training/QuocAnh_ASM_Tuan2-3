# 1. Cấu trúc vật lý của ổ đĩa

### 1.1. Track - Side - Cylinder - Sector

#### 1.1.1. Track
- Trên một mặt làm việc của đĩa từ chia ra nhiều vòng tròn đồng tâm thành các track. Track có thể được hiểu đơn giản giống các rãnh ghi dữ liệu giống như các đĩa nhựa (ghi âm nhạc trước đây) nhưng sự cách biệt của các rãnh ghi này không có các gờ phân biệt và chúng là các vòng tròn đồng tâm chứ không nối tiếp nhau thành dạng xoắn trôn ốc như đĩa nhựa. Track trên ổ đĩa cứng không cố định từ khi sản xuất, chúng có thể thay đổi vị trí khi định dạng cấp thấp ổ đĩa (low format ).
#### 1.1.2. Side
- Bất kì một đĩa nào cũng có 2 mặt (side), không ai bắt buộc chúng ta sử dụng 1 mặt đĩa. Ghi dữ liệu lên 2 mặt đĩa mang lại tính kinh tế hơn vì khả năng chứa dữ liệu của đĩa tăng lên gấp đôi mà không cần tốn thêm ổ đĩa thứ 2. Đơn giản là đặt thêm 1 đầu đọc thứ 2 ở phía bên kia, 2 mặt được đánh số lần lượt là mặt 1 và mặt 0.
#### 1.1.3. Cylinder
- Tập hợp các track cùng bán kính (cùng số hiệu trên) ở các mặt đĩa khác nhau thành các cylinder. Nói một cách chính xác hơn thì: khi đầu đọc/ghi đầu tiên làm việc tại một track nào thì tập hợp toàn bộ các track trên các bề mặt đĩa còn lại mà các đầu đọc còn lại đang làm việc tại đó gọi là cylinder. Trên một ổ đĩa cứng có nhiều cylinder bởi có nhiều track trên mỗi mặt đĩa từ.
#### 1.1.4. Sector
- Bộ điều khiển đĩa thường được thiết kế để đọc và ghi một lần chỉ từng phân đoạn của Track. Số byte trong 1 phân đoạn, được gọi là Sector, phụ thuộc vào phần cứng mà của bộ điều khiển đĩa và hệ điều hành: các nhà thiết kế sẽ tạo ra những kích thước Sector khác nhau và hệ điều hành sẽ chọn một trong các kích thước này. Đối với hệ điều hành DOS, kích thước được chọn là 512 byte cho mỗi Sector với tất cả các loại đĩa. Để tham chiếu, chúng ta phải chỉ ra cả mặt(side) và track mà còn phải chỉ ra số Sector trong track đó.

### 1.2. Đánh địa chỉ Sector
- Khi chúng ta đạt đến Track cần đọc/ghi, có 2 cách để định vị Sector đó:
- - Đánh số Sector bằng phương pháp cứng (Hard sectoring): Những lỗ đều nhau sẽ được bấm xung quanh đĩa và mỗi lỗ như thế có ý nghĩa đánh dấu sự bắt đầu 1 Sector. Phương pháp này tỏ ra không còn hiệu nghiệm khi tốc độ truy xuất đĩa ngày càng tăng.
- - Đánh số Sector bằng phương pháp mềm (Soft sectoring): Phương pháp này mã hóa địa chỉ của Sector thành dữ liệu của Sector đó và được gắn vào trước mỗi Sector. Vì Sector được đánh số tuần tự xung quanh Track nên địa chỉ của nó đơn giản là các số liên tiếp xung quanh Track.
- Hiện nay, phương pháp đánh số mềm được dùng rộng rãi. Với phương pháp này, trước khi đĩa được dùng, địa chỉ của Sector phải được ghi vao Sector (quá trình này được thực hiện bằng việc Format đĩa). Địa chỉ Sector này thực ra chỉ là một phần thông tin trong dữ liệu ở phần đầu Sector.

### 1.3. Format vật lý
- Ghi toàn bộ địa chỉ Sector, các thông tin khác vào phần đầu của Sector được gọi là format vật lý hay format ở mức thấp, vì việc này được thực hiện chỉ bằng phần cứng của bộ điều khiển đĩa. Trong quá trình format, phần mềm sẽ bắt bộ điều khiển đĩa tiến hành format với những thông số về kích thước của 1 Sector, còn công việc còn lại tự bộ điều khiển đĩa phải làm.
- Format vật lý phải được thực hiện trước khi đĩa được đưa vào sử dụng. Một quá trình độc lập thứ 2 - format logic - cũng phải được thực hiện ngay sau đó trước khi đĩa chuẩn bị chứa dữ liệu. Ở mức này, tùy theo cách tổ chức của từng hệ điều hành, nó sẽ chia đĩa thành từng vùng tương ứng.

# 2. Cấu trúc Logic

### 2.1. Boot Sector

- Luôn chiếm Sector đầu tiên trên Track 0, Side 1 của đĩa, tuy vậy, điều này cũng chỉ tuyệt đối đúng trên các đĩa mềm, còn đối với đĩa cứng, vị trí này phải nhường lại cho Partition table.
- Boot sector này sẽ được đọc vào địa chỉ 0:07C00 sau khi máy thực hiện xong quá trình POST. Quyền điều khiển sẽ được trao lại cho đoạn mó nằm trong Boot sector. Đoạn mã này có nhiệm vụ tải các file hệ thống vào nếu có. Ngoài ra, Boot sector còn chứa một bảng tham số quan trọng đến cấu trúc đĩa, bảng này được ghi vào trong quá trình format logic đĩa và ngay cả đối với những đĩa không phải là đĩa boot được.
 
 ### 2.2. FAT - Root directory
 
- FAT là hệ thống tập tin được sử dụng trên hệ điều hành MS-DOS và Windows
- Có 3 loại FAT: FAT12, FAT16, FAT32  
- Tổ chứng thành 2 vùng:
    - Vùng Hệ thống: BootSector, bảng FAT, bảng thư mục gốc
    - Vùng dữ liệu
    
- Root directory là cấu trúc bổ xung cho FAT và nằm ngay sau FAT. Nếu FAT nhằm mục đích quản lí ở mức thấp: từng sector, xem nó còn dùng được hay không, phân phối nếu cần thì Root directory không cần quan tâm mà chỉ nhằm quản lí file, một khái niệm cao hơn, mà không cần biết nó gồm những sector nào. Root có nhiệm vụ lưu giữ thông tin về file trên đĩa. Mỗi file được đặc trưng bởi một đầu vào trong Root Dir. Được tổ chức thành các entry 32 byte. Mỗi entry lưu trữ thông tin đăng ký các file, các thư mục con hoặc các nhãn đĩa.

### 2.3. Partition table

- Các thông tin về điểm bắt đầu và kích th-ớc của từng partition được phản ánh trong Partition table. Partition table này luôn tìm thấy ở sector đầu tiên trên đĩa (track 0, Side 0, sector 1) thayvì Boot sector (còn được gọi dưới tên Master boot). Sector này sẽ được đọc lên đầu tiên và trao quyền điều khiển, do đó, ngoài Partition table, Master boot còn chứa đoạn mã cho phép xác định partition nào đang hoạt động và chỉ duy nhất có một partition hoạt động mà thôi. Partition table nằm ở offset 01BE, mỗi partition được đặc trưng bằng một entry 16 byte phản ánh những thông tin về nó.


# 3. Các tác vụ truy xuất đĩa

### 3.1. Mức BIOS

- Tương ứng với mức cấu trỳc vật lớ, bộ điều khiển đĩa cũng đưa ra cỏc khả năng cho phộp truy xuất ở mức vật lớ. Các chức năng này được thực hiện thụng qua ngắt 13h, với từng chức năng con trong thanh ghi AH. Các chức năng căn bản:

    - Reset đĩa: Vào: AH=0, DL = số hiệu đĩa vật lí (0=đĩa A, 1=đĩa B ..... 080=đĩa cứng). Nếu DL là 80h hay 81h, bộ điều khiển đĩa cứng sẽ reset sau đó đến bộ điều khiển đĩa mềm. Ra: Không.
    - Lấy mã lỗi của tác vụ đĩa gần nhất: Vào: AH = 1 DL = đĩa vật lí. Nếu DL=80h lấy lỗi của đĩa mềm DL=7Fh lấy lỗi của đĩa cứng. Ra: AL chứa mã lỗi. 
    - Đọc sector: Vào: AH=2 DL=số hiệu đĩa (0=đĩa A, ..., 80h=đĩa cứng 0, 81h= đĩa cứng 1); DH=số đầu đọc ghi. CH= số track (Cylinder) CL=số sector. AL=số sector cần đọc/ghi Ra: CF=1 nếu có lỗi và mỰ lỗi chứa trong AH.
    - Ghi sector: Vào: AH=3 ES:BX trỏ đến buffer chứa dữ liệu còn lại tương tự như chức năng đọc sector. Ra: CF=1 nếu có lỗi và mã lỗi chứa trong AH.
    - Verify sector: Chức năng này cho phép kiểm tra CRC của các sector được chọn. Vào: AH=4 Ra: CF=1 nếu có lỗi và mã lỗi chứa trong AH. Vào: AH=4, các thanh ghi như C và D. Ra: CF=1 nếu có lỗi và mã lỗi chứa trong AH.
 
### 3.2. Mức DOS

- Chức năng đọc và ghi đĩa dưới DOS được phân biệt bởi hai ngắt 25h và 26h, tham số đưa vào bây giờ chỉ còn là sector logic ,gọi các đĩa theo thứ tự các chữ cái từ A đến Z . 
- Vào: AL=số đĩa (0=A, 1=B, ...), CX=số lượng sector cần đọc/ghi, DX=số sector logic bắt đầu, DS:BX=địa chỉ của buffer chứa dữ liệu cho tác vụ đọc/ghi.
- Ra: Lỗi nếu CF=1, mã lỗi trong AX. Ngược lại, tác vụ đọc/ghi được thực hiện thành công, các giá trị thanh ghi đều bị phá hủy, trừ các thanh ghi phân đoạn và một word còn sót lại trên stack.

### 3.3. Các giải thuật chuyển đổi định vị

### 3.4. Phân tích Boot
    




