package controller.customer;
import dto.CategoryDTO;
import dto.UserDTO;
import enums.RoleType;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.ICategoryService;
import service.Impl.CategoryServiceImpl;

import java.io.IOException;
import java.util.*;

@WebServlet(urlPatterns = {"/customer/product/filter"})
public class FilterProductController extends HttpServlet {
    ICategoryService categoryService = new CategoryServiceImpl();
    List<CategoryDTO> categories = null;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pageParam = req.getParameter("page");
        HttpSession session = req.getSession();
        UserDTO userDTO = (UserDTO) session.getAttribute("user");
        try{
        if (userDTO.getAccount().getRole()== RoleType.ADMIN){
            req.setAttribute("error","Trang này không khả dụng");
            req.getRequestDispatcher("/view/errror.jsp").forward(req, resp);
            return;
        }} catch (Exception e) {
        }
        if (pageParam == null || pageParam.isEmpty()) {
            String contextPath = req.getContextPath(); // Lấy context path
            String redirectURL = contextPath + "/customer/product/filter?page=1";
            resp.sendRedirect(redirectURL);
            return;
        }

        categories = categoryService.findAllCategories();

        Map<String, Object> responseData = categoryService.getFilteredAndSortedProducts(
                categories,
                req.getParameter("selectedPromotion"),
                req.getParameter("selectedCategory"),
                req.getParameter("selectedSize"),
                req.getParameter("selectedColor"),
                req.getParameter("searchName"),
                req.getParameter("minPrice"),
                req.getParameter("maxPrice"),
                req.getParameter("sortOption"),
                pageParam
        );

        for (Map.Entry<String, Object> entry : responseData.entrySet()) {
            req.setAttribute(entry.getKey(), entry.getValue());
        }

        RequestDispatcher rq = req.getRequestDispatcher("/view/customer/filter-product.jsp");
        rq.forward(req, resp);
    }
}
