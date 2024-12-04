<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Danh sách đơn hàng</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f4f4f4;
            font-family: Arial, sans-serif;
        }

        .container {
            max-width: 100%;
        }

        h1 {
            color: #000;
            font-size: 28px;
            font-weight: bold;
        }

        .table {
            border-radius: 8px;
            overflow: hidden;
            background-color: #fff;
        }

        .table thead {
            background-color: #000;
            color: #fff;
        }

        .table tbody tr:hover {
            background-color: #f9f9f9;
        }

        .btn-primary {
            background-color: #000;
            border: none;
        }

        .btn-primary:hover {
            background-color: #333;
        }

        .search-bar input {
            border: 1px solid #ddd;
            border-radius: 20px;
            padding: 10px;
        }

        .search-bar button {
            border: none;
            border-radius: 20px;
            background-color: #000;
            color: #fff;
            padding: 10px 20px;
        }
    </style>
</head>
<body>

<div style="padding-top: 0 !important;" class="container py-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1>Danh sách đơn hàng</h1>
    </div>

    <!-- Thông báo -->
    <c:if test="${not empty message}">
        <div class="alert alert-success" role="alert">
                ${message}
        </div>
    </c:if>

    <!-- Bảng danh sách đơn hàng -->
    <div class="table-responsive">
        <table class="table table-striped">
            <thead>
            <tr>
                <th>Mã</th>
                <th>Ngày tạo</th>
                <th>Khách hàng</th>
                <th>Trạng thái đơn hàng</th>
                <th>Thanh toán</th>
                <th>Trạng thái</th>
                <th>Tổng tiền</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="order" items="${orderDTOList}">
                <tr>
                    <td>${order.orderId}</td>
                    <td>${order.orderDate}</td>
                    <td>${order.customer.fullName}</td>
                    <td>${order.orderStatus}</td>
                    <td>${order.payment.paymentMethod}</td>
                    <td>
                        <form action="${pageContext.request.contextPath}/admin/orders/update-status" method="POST">
                            <input type="hidden" name="orderId" value="${order.orderId}"/>
                            <select name="newStatus" class="form-select">
                                <option value="WAITING_CONFIRMATION"
                                    ${order.orderStatus == 'WAITING_CONFIRMATION' ? 'selected' : ''}>WAITING_CONFIRMATION</option>
                                <option value="CONFIRMED"
                                    ${order.orderStatus == 'CONFIRMED' ? 'selected' : ''}>CONFIRMED</option>
                                <option value="SHIPPED"
                                    ${order.orderStatus == 'SHIPPED' ? 'selected' : ''}>SHIPPED</option>
                                <option value="COMPLETED"
                                    ${order.orderStatus == 'COMPLETED' ? 'selected' : ''}>COMPLETED</option>
                                <option value="CANCELLED"
                                    ${order.orderStatus == 'CANCELLED' ? 'selected' : ''}>CANCELLED</option>
                            </select>
                            <button type="submit" class="btn btn-primary btn-sm mt-2">Cập nhật</button>
                        </form>
                    </td>
                    <td><fmt:formatNumber value="${order.payment.amount}" groupingUsed="true"/></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>


</html>
