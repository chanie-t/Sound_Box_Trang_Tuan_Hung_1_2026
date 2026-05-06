import 'package:flutter/material.dart';
// Bạn lưu ý đường dẫn import này nhé. Dựa theo ảnh cây thư mục của bạn:
// Từ giuaki/screens/Content.dart đi ra ngoài 2 cấp để vào thư mục widgets
import '../../widgets/sound_box_header.dart'; 

class ContentScreen extends StatelessWidget {
  const ContentScreen({Key? key}) : super(key: key);

  // Màu xanh lá chủ đạo của thiết kế nội dung bên dưới
  final Color primaryGreen = const Color(0xFF4A7A30);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Đã thay thế AppBar cũ bằng AppBar tích hợp SoundBoxHeader
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // Nút Back (quay lại trang trước) sẽ tự động hiển thị, ta set màu đen cho nó dễ nhìn:
        iconTheme: const IconThemeData(color: Colors.black87),
        title: const SoundBoxHeader(), // Nhúng component Header của bạn vào đây
        titleSpacing: 0, // Căn lề cho khớp với nút Back
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tiêu đề Basket
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  const Text(
                    'Basket',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Serif', 
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    '3 items',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Divider(thickness: 1, color: Colors.grey[300]),
              const SizedBox(height: 30),

              // Nội dung chính: Cột Sản phẩm và Cột Summary
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cột trái: Danh sách sản phẩm
                  Expanded(
                    flex: 6,
                    child: Column(
                      children: [
                        _buildCartItem(
                          imageUrl: '/assets/images/Đừng làm trái tim anh đau.jpg', // Thay link ảnh thực tế của bạn vào đây
                          title: 'Đừng làm trái tim anh đau',
                          pricePerUnit: '\$5.99 / lb',
                          weight: '1 lb',
                          totalPrice: '\$5.99',
                        ),
                        const SizedBox(height: 20),
                        _buildCartItem(
                          imageUrl: '/assets/images/Mượn rượu tỏ tình_Emily_Bigdaddy.jpg', // Thay link ảnh thực tế của bạn vào đây
                          title: 'Mượn rượu tỏ tình',
                          pricePerUnit: '\$12.99 / lb',
                          weight: '1 lb',
                          totalPrice: '\$12.99',
                        ),
                        const SizedBox(height: 20),
                        _buildCartItem(
                          imageUrl: '/assets/images/Thích quá rùi nà_Tlinh.jpg', // Thay link ảnh thực tế của bạn vào đây
                          title: 'Thích quá rùi nà',
                          pricePerUnit: '\$2.99 / lb',
                          weight: '5 lb',
                          totalPrice: '\$14.95',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 40),
                  // Cột phải: Order Summary
                  Expanded(
                    flex: 3,
                    child: _buildOrderSummary(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Các Widget thành phần bên dưới ---

  Widget _buildCartItem({
    required String imageUrl, // Đã thêm biến nhận link ảnh
    required String title,
    required String pricePerUnit,
    required String weight,
    required String totalPrice,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA), // Màu nền xám nhạt
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          // Khung ảnh sản phẩm đã tích hợp Image.network
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              // Phòng trường hợp link ảnh lỗi hoặc đang load chậm
              errorBuilder: (context, error, stackTrace) => Container(
                width: 100,
                height: 100,
                color: Colors.grey[300],
                child: const Icon(Icons.image_not_supported, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(width: 20),
          
          // Thông tin sản phẩm
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  pricePerUnit,
                  style: TextStyle(fontSize: 16, color: primaryGreen, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                
                // Nút chọn khối lượng
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(weight, style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(width: 8),
                      Icon(Icons.edit_outlined, size: 16, color: Colors.grey[600]),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Tổng giá của item
          Text(
            totalPrice,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order summary',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          _buildSummaryRow('Subtotal', '\$33.93'),
          const SizedBox(height: 16),
          _buildSummaryRow('Shipping', '\$3.99'),
          const SizedBox(height: 16),
          _buildSummaryRow('Tax', '\$2.00'),
          const SizedBox(height: 24),
          
          // Total Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '\$39.92',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 30),
          
          // Nút thanh toán
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryGreen,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Continue to payment',
                    style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, color: Colors.grey[800]),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}