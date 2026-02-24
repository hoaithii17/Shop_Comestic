package service;

import java.text.Normalizer;
import java.util.regex.Pattern;

public class ChatBotService {

    // Hàm chính để phản hồi tin nhắn
    public static String reply(String message) {
        // 1. Kiểm tra tin nhắn rỗng
        if (message == null || message.trim().isEmpty()) {
            return "Beauty Shop chưa nghe rõ ạ, bạn nói lại giúp mình với nha 💕";
        }

        // 2. CHUẨN HÓA: Chuyển về chữ thường + Xóa dấu tiếng Việt + Xóa ký tự đặc biệt thừa
        // Ví dụ: "Sữa rữa măt..." -> "sua rua mat"
        String text = removeAccent(message.trim().toLowerCase());

        // ==================================================================
        // NHÓM 1: CHÀO HỎI & XÃ GIAO
        // ==================================================================
        if (check(text, "hi", "hello", "chao", "he lo", "hi shop", "ad oi")) {
            return "Chào bạn yêu 💕! Beauty Shop đây ạ. Bạn cần tư vấn về:\n"
                 + "🌿 **Chăm sóc da** (Mụn, Trắng da, Lỗ chân lông...)\n"
                 + "💄 **Trang điểm** (Son, Phấn, Kẻ mắt...)\n"
                 + "💆‍♀️ **Tóc & Cơ thể**\n"
                 + "Hay cần tìm sản phẩm cụ thể nào ạ?";
        }

        if (check(text, "cam on", "thank", "iu shop", "ok shop")) {
            return "Cảm ơn bạn đã tin tưởng Beauty Shop 💕. Chúc bạn luôn xinh đẹp! Cần gì cứ nhắn mình nha.";
        }

        // ==================================================================
        // NHÓM 2: LÀM SẠCH DA (CLEANSING)
        // ==================================================================
        
        // Sữa rửa mặt
        if (check(text, "sua rua mat", "rua mat", "gel rua mat", "srm")) {
            return "🧴 **Sữa rửa mặt** là bước không thể thiếu! Shop gợi ý:\n"
                 + "• **Cetaphil**: Dịu nhẹ cho da nhạy cảm/khô.\n"
                 + "• **Cerave**: Phục hồi màng bảo vệ da.\n"
                 + "• **Cosrx/SVR**: Dành riêng cho da dầu mụn.\n"
                 + "Bạn thuộc loại da nào (Dầu/Khô/Hỗn hợp)?";
        }

        // Tẩy trang
        if (check(text, "tay trang", "nuoc tay trang", "dau tay trang")) {
             return "✨ Làm sạch sâu (Double Cleansing) cần tẩy trang ạ:\n"
                  + "• **Bioderma Hồng**: Da nhạy cảm.\n"
                  + "• **Bioderma Xanh**: Da dầu.\n"
                  + "• **L'Oreal**: Ngon - Bổ - Rẻ.\n"
                  + "Bạn hay trang điểm đậm hay chỉ dùng kem chống nắng?";
        }

        // Toner
        if (check(text, "toner", "nuoc hoa hong", "can bang da")) {
             return "💧 **Toner** giúp cân bằng pH và cấp ẩm:\n"
                  + "• **Klairs**: Dưỡng ẩm, làm dịu.\n"
                  + "• **Some By Mi**: Có AHA-BHA trị mụn.\n"
                  + "Bạn thích loại dưỡng ẩm hay làm sạch sâu?";
        }

        // ==================================================================
        // NHÓM 3: ĐẶC TRỊ & DƯỠNG DA (TREATMENT)
        // ==================================================================

        // Trị mụn
        if (check(text, "mun", "tri mun", "day mun", "mun an", "mun viem")) {
            return "🆘 Bộ 3 **Diệt Mụn** best-seller của Shop:\n"
                 + "1️⃣ **Chấm mụn La Roche-Posay Duo+**: Gom cồi sau 24h.\n"
                 + "2️⃣ **Toner Some By Mi**: Đẩy mụn ẩn.\n"
                 + "3️⃣ **Serum The Ordinary Zinc**: Kiềm dầu, kháng viêm.\n"
                 + "👉 Bạn muốn xem giá sản phẩm nào?";
        }

        // Trắng da / Trị thâm
        if (check(text, "tham", "trang da", "sang da", "nam", "tan nhang", "trang")) {
             return "✨ Muốn mờ thâm sáng da thì dùng **Vitamin C** hoặc **Niacinamide** là chuẩn nhất:\n"
                  + "🍊 **Serum Klairs Vitamin C**: Mờ thâm mới, sáng da.\n"
                  + "💊 **The Ordinary Niacinamide**: Sáng da, se lỗ chân lông.\n"
                  + "Lưu ý: Dùng mấy món này nhớ chống nắng kỹ nha!";
        }

        // Chống lão hóa / Retinol
        if (check(text, "lao hoa", "nep nhan", "retinol", "chay xe")) {
             return "⏳ Chống lão hóa 'hack tuổi' với:\n"
                  + "• **Retinol Obagi/Kiehl's**: Tái tạo bề mặt da.\n"
                  + "• **Serum Estee Lauder ANR**: Phục hồi ban đêm.\n"
                  + "• **Kem mắt AHC**: Xóa nhăn vùng mắt.";
        }

        // Dưỡng ẩm / Da khô
        if (check(text, "kho", "bong troc", "cap am", "duong am", "cap nuoc")) {
            return "💧 Da thiếu nước cần cấp cứu ngay:\n"
                 + "🌊 **Serum HA Timeless/L'Oreal**.\n"
                 + "🧴 **Kem dưỡng Neutrogena Aqua Gel**.\n"
                 + "🌿 **Mặt nạ Banobagi**.\n"
                 + "Da đủ ẩm mới căng bóng được đó ạ!";
        }

        // ==================================================================
        // NHÓM 4: BẢO VỆ DA (SUNSCREEN)
        // ==================================================================
        if (check(text, "chong nang", "kcn", "kem chong nang", "uv")) {
            return "☀️ Kem chống nắng là vật bất ly thân nha! Shop có:\n"
                 + "💛 **Anessa**: Kiềm dầu đỉnh, chống nước.\n"
                 + "🤍 **Skin1004 Rau Má**: Dịu nhẹ cho da mụn.\n"
                 + "🧡 **La Roche-Posay**: Bảo vệ phổ rộng.\n"
                 + "Bạn thích dạng sữa lỏng hay dạng kem?";
        }

        // ==================================================================
        // NHÓM 5: TRANG ĐIỂM (MAKEUP)
        // ==================================================================
        
        // Son môi
        if (check(text, "son", "moi", "lip", "3ce", "black rouge", "mac", "romand")) {
            return "💄 Shop cập nhật đủ các dòng son Hot Hit:\n"
                 + "💋 **3CE Cloud Lip Tint**: Lì mịn như mây.\n"
                 + "💋 **Black Rouge**: Bảng màu siêu tôn da.\n"
                 + "💋 **Romand**: Son bóng căng mọng.\n"
                 + "👉 Bạn thích tông **Đỏ**, **Cam** hay **Hồng**?";
        }

        // Nền / Phấn
        if (check(text, "kem nen", "phan phu", "cushion", "che khuyet diem")) {
             return "✨ Lớp nền hoàn hảo với:\n"
                  + "• **Cushion Missha/Clio**: Nhanh gọn, che phủ tốt.\n"
                  + "• **Kem nền Maybelline Fit Me**: Kiềm dầu.\n"
                  + "• **Phấn phủ Innisfree**: Giữ nền lâu trôi.";
        }

        // Mắt
        if (check(text, "ke mat", "eyeliner", "mascara", "long may")) {
             return "👁️ Đôi mắt hút hồn với **Mascara Maybelline** (cong vút) và **Kẻ mắt Kissme** (không trôi) nha!";
        }

        // ==================================================================
        // NHÓM 6: TÓC & CƠ THỂ (HAIR & BODY)
        // ==================================================================
        if (check(text, "toc", "goi", "xa", "rung toc", "duong toc")) {
             return "💆‍♀️ Chăm sóc tóc chuẩn Salon:\n"
                  + "• **Dầu gội Bưởi Cocoon**: Giảm rụng, kích mọc tóc.\n"
                  + "• **Dầu dưỡng Argan**: Mềm mượt tức thì.\n"
                  + "• **Tẩy tế bào chết da đầu**: Giảm gàu, bết.";
        }
        
        if (check(text, "sua tam", "body", "duong the", "tay da chet body")) {
             return "🛁 Chăm sóc body:\n"
                  + "• **Tẩy da chết Dove**: Mịn màng, thơm lâu.\n"
                  + "• **Sữa dưỡng thể Vaseline**: Trắng da an toàn.\n"
                  + "• **Sữa tắm Tesori**: Hương nước hoa quyến rũ.";
        }

        // ==================================================================
        // NHÓM 7: XỬ LÝ MÀU SẮC & LOẠI DA (CONTEXT)
        // ==================================================================
        if (check(text, "do", "do dat", "do gach", "do cam")) {
             return "🍒 Tông **ĐỎ** siêu tôn da và trắng răng!\n"
                  + "Gợi ý: **Black Rouge A12** (Đỏ nâu) hoặc **3CE Macaron Red** (Đỏ tươi).\n"
                  + "Bạn chốt thỏi nào không nè?";
        }
        
        if (check(text, "cam", "cam dat", "cam chay")) {
             return "🍊 Tông **CAM** trẻ trung năng động.\n"
                  + "Best seller: **3CE Needful** (Cam cháy) hoặc **Romand 02** (Cam đất).";
        }

        if (check(text, "da dau", "nhon", "lo chan long")) {
             return "🍃 Với **Da Dầu**, bạn nên chọn sản phẩm có chữ 'Oil Free' hoặc 'No Sebum'.\n"
                  + "Gợi ý: Sữa rửa mặt Cosrx + Toner hoa cúc + Kem dưỡng dạng Gel.";
        }

        if (check(text, "da kho", "kho", "nut ne")) {
             return "💧 Với **Da Khô**, ưu tiên cấp ẩm sâu (Hyaluronic Acid, Ceramide).\n"
                  + "Gợi ý: Sữa rửa mặt Cerave xanh lá + Serum B5 + Kem dưỡng khóa ẩm.";
        }

        // ==================================================================
        // NHÓM 8: CHỐT ĐƠN / GIÁ / SHIP
        // ==================================================================
        if (check(text, "gia", "bao nhieu", "mua", "co", "oke", "uk", "muon", "xem", "chot")) {
            return "🎉 Dạ, bạn xem giá chi tiết và thêm vào giỏ hàng tại mục **SẢN PHẨM** trên thanh menu nha.\n"
                 + "🚚 Đang có mã **FREESHIP** cho đơn từ 500k đó ạ! Chốt đơn ngay kẻo hết hàng hot nè 🛒";
        }

        if (check(text, "dia chi", "o dau", "shop", "cua hang")) {
            return "🏡 Beauty Shop đón bạn tại: **123 Đường ABC, Quận 1, TP.HCM**.\n"
                 + "⏰ Mở cửa: 8h00 - 22h00 hàng ngày.\n"
                 + "🚀 Hoặc đặt Online ship hỏa tốc trong 2h ạ!";
        }

        // ==================================================================
        // MẶC ĐỊNH (FALLBACK)
        // ==================================================================
        return "Hic, Beauty Shop chưa hiểu ý bạn lắm 🥺.\n"
             + "Bạn thử nhắn từ khóa ngắn gọn như: **'trị mụn'**, **'son 3ce'**, **'sữa rửa mặt'**... để mình tư vấn lại nha! 💕";
    }

    // ========================================================================
    // CÁC HÀM HỖ TRỢ THÔNG MINH (LOGIC CORE)
    // ========================================================================

    /**
     * Hàm kiểm tra từ khóa thông minh (Fuzzy Matching)
     * Cho phép sai số 1 ký tự (gõ sai chính tả vẫn hiểu)
     */
    private static boolean check(String input, String... keywords) {
        // 1. Kiểm tra chứa chính xác trước (Nhanh)
        for (String key : keywords) {
            if (input.contains(key)) return true;
        }

        // 2. Nếu không chứa, tách từng từ để so sánh sai số (Chậm hơn chút nhưng thông minh)
        // Chỉ áp dụng nếu input ngắn (dưới 50 ký tự) để tránh lag
        if (input.length() < 50) {
            String[] inputWords = input.split("\\s+");
            for (String key : keywords) {
                // Chỉ so sánh mờ với từ khóa dài > 3 ký tự (tránh nhầm từ ngắn như "co", "da")
                if (key.length() > 3) { 
                    for (String word : inputWords) {
                        if (calculateLevenshteinDistance(word, key) <= 1) {
                            return true;
                        }
                    }
                }
            }
        }
        return false;
    }

    /**
     * Thuật toán Levenshtein: Tính khoảng cách giữa 2 chuỗi
     * Dùng để bắt lỗi chính tả (VD: "mun" vs "mujn")
     */
    private static int calculateLevenshteinDistance(String x, String y) {
        int[][] dp = new int[x.length() + 1][y.length() + 1];
        for (int i = 0; i <= x.length(); i++) {
            for (int j = 0; j <= y.length(); j++) {
                if (i == 0) dp[i][j] = j;
                else if (j == 0) dp[i][j] = i;
                else {
                    dp[i][j] = min(dp[i - 1][j - 1] 
                                   + (x.charAt(i - 1) == y.charAt(j - 1) ? 0 : 1), 
                                   dp[i - 1][j] + 1, 
                                   dp[i][j - 1] + 1);
                }
            }
        }
        return dp[x.length()][y.length()];
    }

    private static int min(int... numbers) {
        int min = Integer.MAX_VALUE;
        for (int num : numbers) {
            if (num < min) min = num;
        }
        return min;
    }

    /**
     * Hàm xóa dấu Tiếng Việt
     * Input: "Sữa rữa măt" -> Output: "sua rua mat"
     */
    public static String removeAccent(String s) {
        String temp = Normalizer.normalize(s, Normalizer.Form.NFD);
        Pattern pattern = Pattern.compile("\\p{InCombiningDiacriticalMarks}+");
        return pattern.matcher(temp).replaceAll("").replaceAll("đ", "d").replaceAll("Đ", "D");
    }
}