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
- Trong thực tế, hầu như không ai chú ý đến vấn đề này vì đã có lệnh Format của DOS. Tuy nhiên để giải thích để giải thích công việc cụ thể của lệnh này thì hầu như ít ai quan tâm đến. Có giải thích như sau:
  - Với đĩa mềm: một đĩa cho dù đã được format lần nào hay chưa đều được đối xử "bình đẳng" như nhau, nghĩa là đầu tiền DOS sẽ tiến hành format vật lý, sau đó sẽ là format logic nhằm khởi tạo các vùng hệ thống và dữ liệu.
  - Với đĩa cứng: mọi đĩa cứng trước khi đưa ra thị trường đều đã được format vật lý và đó không có một lí do vào để format lại nếu không thấy cần thiết. Đối với trường hợp này, DOS không cần phải format vât lý mà đơn giản chỉ tiến hành format logic. Trong trường hợp này, tốc độ format trên đĩa cứng sẽ rất nhanh chứ không ì ạch như trên đĩa mềm. Sau khi đã qua format, đĩa của chúng ta giờ đây đã sẵn sàng chứa dữ liệu.


# 2. Cấu trúc Logic

### 2.1. Boot Sector

- Luôn chiếm Sector đầu tiên trên Track 0, Side 1 của đĩa, tuy vậy, điều này cũng chỉ tuyệt đối đúng trên các đĩa mềm, còn đối với đĩa cứng, vị trí này phải nhường lại cho Partition table.
- Boot sector này sẽ được đọc vào địa chỉ 0:07C00 sau khi máy thực hiện xong quá trình POST. Quyền điều khiển sẽ được trao lại cho đoạn mó nằm trong Boot sector. Đoạn mã này có nhiệm vụ tải các file hệ thống vào nếu có. Ngoài ra, Boot sector còn chứa một bảng tham số quan trọng đến cấu trúc đĩa, bảng này được ghi vào trong quá trình format logic đĩa và ngay cả đối với những đĩa không phải là đĩa boot được .
 
 ### 2.2. FAT
 
 - Đây là một trong hai cấu trúc quan trọng nhất (cấu trúc thứ hai là Root) mà DOS khởi tạo trong quá trình format logic đĩa. Cấu trúc này dùng để quản lí file trên đĩa cũng như cho biết sector nào đã hỏng. ở mức này DOS cũng đưa ra một số khái niệm mới :
 
     - a. Cluster: Khi đĩa được format fogic, đơn vị nhỏ nhất trên đĩa mà DOS có thể quản lí được là sector (theo DOS tự qui định - kích thước của một sector cũng đã cố định là 512 byte). Như thế, DOS có thể quản lí từng sector một xem nó còn dùng được hay không. Tuy nhiên, một đĩacó dung lượng cao (thường là đĩa cứng), số sector quá lớn không thể quản lí theo cách này mà thay vào đó, DOS đưa ra một khái niệm Cluster: là tập hợp nhiều sector, do đó, thay vì quảnquản lí nhiều sector, DOS bây giờ chỉ quản lí trên các cluster. Rõ ràng số lượng cluster sẽ giảm đi nhiều nếu ta tăng số lượng sector cho một cluster.
  
     - b. Khái niệm về FAT: Vấn đề phức tạp và then chốt của việc quản lí file trên đĩa là làm sao quản lí được sự thay đổi kích thước các file. Đây là một điều tất nhiên vì khi làm việc với máy, đòi hỏi ta phải truy xuất đến file trên đĩa.

