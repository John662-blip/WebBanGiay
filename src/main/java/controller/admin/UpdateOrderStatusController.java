package controller.admin;

import dto.OrderDTO;
import dto.UserDTO;
import enums.OrderStatus;
import enums.RoleType;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.IOrderService;
import service.Impl.OrderServiceImpl;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/orders/update-status"})
public class UpdateOrderStatusController extends HttpServlet {
    private IOrderService orderService = new OrderServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        UserDTO userDTO1 = (UserDTO) session.getAttribute("user");
        if (userDTO1==null ||!userDTO1.isActive()){
            // Xóa session
            session.invalidate();
            resp.sendRedirect("/view/login.jsp");
            return;
        }
        if (userDTO1.getAccount().getRole()== RoleType.CUSTOMER){
            req.setAttribute("error","Trang này không khả dụng");
            req.getRequestDispatcher("/view/errror.jsp").forward(req, resp);
            return;
        }
        String orderId = req.getParameter("orderId");  // Lấy orderId từ request
        String newStatus = req.getParameter("newStatus");  // Lấy newStatus từ request

        // Xử lý cập nhật trạng thái đơn hàng
        boolean success = orderService.updateOrderStatus(orderId, OrderStatus.valueOf(newStatus));
        session.setAttribute("form","2");
        if (success) {
            // Làm mới danh sách fullOrderList trong ServletContext
            synchronized (getServletContext()) {
                List<OrderDTO> updatedOrderList = orderService.findAllOrders();
                getServletContext().setAttribute("fullOrderList", updatedOrderList);
            }
            // Chuyển hướng về danh sách đơn hàng sau khi cập nhật
            resp.sendRedirect(req.getContextPath() + "/Admin");
        } else {
            resp.sendRedirect(req.getContextPath() + "/Admin");
        }
    }
}
