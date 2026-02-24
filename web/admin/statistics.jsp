<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thống kê & Báo cáo | Admin</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        :root {
            --primary-pink: #d63384;
            --light-pink: #fff0f6;
            --text-dark: #333;
            --card-shadow: 0 10px 30px rgba(0,0,0,0.08);
        }

        body {
            background-color: #f8f9fa;
            font-family: 'Nunito', sans-serif;
            color: var(--text-dark);
        }

        /* --- STAT CARDS (Gradient Style) --- */
        .stat-card {
            border: none;
            border-radius: 20px;
            padding: 30px 25px;
            color: white;
            box-shadow: var(--card-shadow);
            position: relative;
            overflow: hidden;
            transition: transform 0.3s ease;
            height: 100%;
        }

        .stat-card:hover { transform: translateY(-5px); }
        
        /* Hiệu ứng bóng mờ trang trí */
        .stat-card::after {
            content: '';
            position: absolute;
            top: -20px; right: -20px;
            width: 100px; height: 100px;
            background: rgba(255,255,255,0.2);
            border-radius: 50%;
            pointer-events: none;
        }

        .bg-gradient-pink { background: linear-gradient(135deg, #ff9eb5 0%, #d63384 100%); }
        .bg-gradient-blue { background: linear-gradient(135deg, #aecdff 0%, #0d6efd 100%); }
        .bg-gradient-orange { background: linear-gradient(135deg, #ffd6a5 0%, #fd7e14 100%); }

        .stat-label { font-size: 0.9rem; font-weight: 700; text-transform: uppercase; letter-spacing: 1px; opacity: 0.9; }
        .stat-value { font-size: 2.2rem; font-weight: 800; margin-top: 10px; margin-bottom: 0; }
        .stat-icon { font-size: 3.5rem; opacity: 0.2; position: absolute; bottom: 15px; right: 20px; }

        /* --- CHART CARDS --- */
        .chart-card {
            background: white;
            border-radius: 20px;
            padding: 30px;
            box-shadow: var(--card-shadow);
            height: 100%;
            border: 1px solid rgba(0,0,0,0.02);
        }

        .chart-header {
            display: flex; justify-content: space-between; align-items: center;
            margin-bottom: 25px;
            border-bottom: 1px dashed #eee;
            padding-bottom: 15px;
        }
        
        .chart-title {
            font-size: 1.2rem;
            font-weight: 800;
            color: #444;
            display: flex; align-items: center;
        }

        /* Chart container height fix */
        .chart-container { position: relative; height: 350px; width: 100%; }
    </style>
</head>
<body>

    <c:import url="/inc/admin_navbar.jsp"/>

    <div class="container py-5">
        
        <div class="d-flex align-items-center mb-5">
            <div class="bg-white p-3 rounded-circle shadow-sm me-3 text-pink">
                <i class="fas fa-chart-line fa-2x" style="color: var(--primary-pink);"></i>
            </div>
            <div>
                <h3 class="fw-bold mb-0">Báo cáo thống kê</h3>
                <p class="text-muted mb-0">Tổng quan tình hình kinh doanh của Beauty Shop</p>
            </div>
        </div>

        <div class="row g-4 mb-5">
            <div class="col-lg-4 col-md-6">
                <div class="stat-card bg-gradient-pink">
                    <div class="stat-label">Hôm nay</div>
                    <div class="stat-value">
                        <fmt:formatNumber value="${revDay}" pattern="#,###"/> <span class="fs-5">đ</span>
                    </div>
                    <i class="fas fa-calendar-day stat-icon"></i>
                </div>
            </div>

            <div class="col-lg-4 col-md-6">
                <div class="stat-card bg-gradient-blue">
                    <div class="stat-label">Tháng này</div>
                    <div class="stat-value">
                        <fmt:formatNumber value="${revMonth}" pattern="#,###"/> <span class="fs-5">đ</span>
                    </div>
                    <i class="fas fa-calendar-alt stat-icon"></i>
                </div>
            </div>

            <div class="col-lg-4 col-md-12">
                <div class="stat-card bg-gradient-orange">
                    <div class="stat-label">Năm nay</div>
                    <div class="stat-value">
                        <fmt:formatNumber value="${revYear}" pattern="#,###"/> <span class="fs-5">đ</span>
                    </div>
                    <i class="fas fa-chart-pie stat-icon"></i>
                </div>
            </div>
        </div>

        <div class="row g-4">
            
            <div class="col-lg-5">
                <div class="chart-card">
                    <div class="chart-header">
                        <div class="chart-title">
                            <i class="fas fa-box-open me-2 text-warning"></i> Tỷ lệ đơn hàng
                        </div>
                    </div>
                    <div class="chart-container d-flex justify-content-center">
                        <canvas id="orderStatusChart"></canvas>
                    </div>
                </div>
            </div>

            <div class="col-lg-7">
                <div class="chart-card">
                    <div class="chart-header">
                        <div class="chart-title">
                            <i class="fas fa-coins me-2 text-success"></i> Biểu đồ doanh thu
                        </div>
                        <span class="badge bg-light text-dark border">Năm 2024</span>
                    </div>
                    <div class="chart-container">
                        <canvas id="revenueChart"></canvas>
                    </div>
                </div>
            </div>

        </div>
                    <div class="alert alert-success fw-bold">
    💰 Tổng lợi nhuận:
    <fmt:formatNumber value="${totalProfit}" pattern="#,###"/> đ
</div>

                    <!-- ================= PROFIT REPORT ================= -->
<div class="row g-4 mt-4">
    <div class="col-12">
        <div class="chart-card">
            <div class="chart-header">
                <div class="chart-title">
                    <i class="fas fa-chart-line me-2 text-success"></i>
                    Báo cáo lợi nhuận theo sản phẩm
                </div>
            </div>

            <div class="table-responsive">
                <table class="table align-middle table-hover">
                    <thead class="table-light">
                        <tr>
                            <th>#</th>
                            <th>Sản phẩm</th>
                            <th>Đã bán</th>
                            <th>Doanh thu</th>
                            <th>Giá vốn TB</th>
                            <th>Lợi nhuận</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="r" items="${reports}" varStatus="i">
                            <tr>
                                <td>${i.count}</td>
                                <td>${r.productName}</td>
                                <td>${r.sold}</td>
                                <td>
                                    <fmt:formatNumber value="${r.revenue}" pattern="#,###"/> đ
                                </td>
                                <td>
                                   <fmt:formatNumber 
    value="${r.sold > 0 ? r.cost / r.sold : 0}" 
    pattern="#,###"/>

                                </td>
                                <td class="${r.profit >= 0 ? 'text-success fw-bold' : 'text-danger fw-bold'}">
                                    <fmt:formatNumber value="${r.profit}" pattern="#,###"/> đ
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

        </div>
    </div>
</div>

    </div>

    <script>
        // --- CẤU HÌNH DỮ LIỆU CHUNG ---
        Chart.defaults.font.family = "'Nunito', sans-serif";
        Chart.defaults.color = '#666';

        // 1. BIỂU ĐỒ TRÒN (DOUGHNUT)
        // 1. BIỂU ĐỒ TRÒN (DOUGHNUT) - Đã cập nhật đủ 5 trạng thái
        const ctxPie = document.getElementById('orderStatusChart').getContext('2d');
        new Chart(ctxPie, {
            type: 'doughnut',
            data: {
                // Thêm nhãn "Đang đóng gói"
                labels: ['Thành công', 'Đang đóng gói', 'Đang xử lý', 'Đang giao', 'Đã hủy'],
                datasets: [{
                    data: [
    ${successOrders},    // Thành công
    ${packingOrders},    // Đang đóng gói
    ${processingOrders}, // Đang xử lý
    ${shippingOrders},   // Đang giao
    ${canceledOrders}    // Đã hủy
],

                    backgroundColor: [
                        '#d1e7dd', // Success (Xanh lá)
                        '#cfe2ff', // Shipping (Xanh dương)
                        '#e0cffc', // Packing (Tím nhạt) -> MÀU MỚI
                        '#fff3cd', // Processing (Vàng)
                        '#f8d7da'  // Cancel (Đỏ)
                    ],
                    borderColor: [
                        '#198754', // Viền Xanh lá
                        '#0d6efd', // Viền Xanh dương
                        '#6f42c1', // Viền Tím -> VIỀN MỚI
                        '#ffc107', // Viền Vàng
                        '#dc3545'  // Viền Đỏ
                    ],
                    borderWidth: 1,
                    hoverOffset: 4
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom',
                        labels: {
                            usePointStyle: true,
                            padding: 20,
                            font: { size: 11, weight: 'bold' }
                        }
                    },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                let label = context.label || '';
                                let value = context.raw || 0;
                                // Tính phần trăm
                                let total = context.chart._metasets[context.datasetIndex].total;
                                let percentage = Math.round((value / total) * 100) + '%';
                                return label + ': ' + value + ' đơn (' + percentage + ')';
                            }
                        }
                    }
                },
                cutout: '65%', 
            }
        });

        // 2. BIỂU ĐỒ CỘT (BAR CHART) - DOANH THU
        // Lấy dữ liệu từ JSTL ra mảng JS
        const monthlyRevenue = [
    <c:forEach var="rev" items="${monthlyRevenue}" varStatus="loop">
        ${rev != null ? rev : 0}<c:if test="${!loop.last}">, </c:if>
    </c:forEach>
].map(Number);


        const ctxBar = document.getElementById('revenueChart').getContext('2d');
        new Chart(ctxBar, {
            type: 'bar',
            data: {
                labels: ['T1','T2','T3','T4','T5','T6','T7','T8','T9','T10','T11','T12'],
                datasets: [{
                    label: 'Doanh thu',
                    data: monthlyRevenue,
                    backgroundColor: '#ffb7c5', // Màu hồng phấn chủ đạo
                    hoverBackgroundColor: '#d63384', // Hover đậm hơn
                    borderRadius: 6,
                    barThickness: 'flex',
                    maxBarThickness: 35
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false }, // Ẩn chú thích vì đã có tiêu đề
                    tooltip: {
                        backgroundColor: 'rgba(0,0,0,0.8)',
                        padding: 12,
                        callbacks: {
                            // Format tiền tệ Việt Nam trong tooltip (Ví dụ: 5.000.000 đ)
                            label: function(context) {
                                let value = context.raw;
                                return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(value);
                            }
                        }
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        grid: { borderDash: [5, 5], color: '#f0f0f0' },
                        ticks: {
                            // Rút gọn số trên trục Y (ví dụ: 10 tr)
                            callback: function(value) {
                                if (value >= 1000000) return (value / 1000000) + ' tr';
                                return value;
                            },
                            font: { size: 11 }
                        }
                    },
                    x: {
                        grid: { display: false },
                        ticks: { font: { size: 12 } }
                    }
                }
            }
        });
    </script>

</body>
</html>