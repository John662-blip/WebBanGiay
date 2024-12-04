
package service;

import dto.CartItemDTO;
import dto.OrderDTO;
import enums.OrderStatus;
import org.json.JSONObject;

import java.util.List;

public interface IOrderService {
    boolean CreateOrderTWP(String json,int idUser,int total,int discount,int feeship);
    boolean CreateOrder(String Json);
    boolean CanCreateOrder(List<CartItemDTO> cartItem);
    List<OrderDTO> findAllOrders();
    boolean updateOrderStatus(String orderId, OrderStatus newStatus);
    List<OrderDTO> getFilteredOrders(String searchKeyword, String orderStatus, String startDate, String endDate);
    List<OrderDTO> getOrdersByCustomerId(int customerId);
    OrderDTO getOrderById(int orderId);

}

