package controller.admin;

import com.google.gson.Gson;
import dto.PromotionDTO;
import enums.DiscountType;
import enums.PromotionType;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.JSONObject;
import service.IProductPromotion;
import service.IProductService;
import service.IPromotionService;
import service.Impl.ProductPromotionImpl;
import service.Impl.ProductServiceImpl;
import service.Impl.PromotionServiceImpl;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Date;
import java.util.Arrays;
import java.util.Base64;
import java.util.List;

@WebServlet(urlPatterns = {"/Admin/promotions/insert","/Admin/promotions/delete"})
public class PromotionController  extends HttpServlet {
    IPromotionService promotionService = new PromotionServiceImpl();
    IProductService productService = new ProductServiceImpl();
    IProductPromotion promotionProductService = new ProductPromotionImpl();


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        if ("/Admin/promotions".equals(path)) {

            BufferedReader reader = req.getReader();
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
            // Chuyển đổi chuỗi JSON thành JSONObject
            JSONObject jsonObject = new JSONObject(sb.toString());
            int promotionId = Integer.parseInt(jsonObject.getString("promotionId"));
                List<String> listNameProduct = productService.getListNameProductForPromotion(promotionId);
                Gson gson = new Gson();
                String jsonRespone = gson.toJson(listNameProduct);
                String encodedBase64 = Base64.getEncoder().encodeToString(jsonRespone.getBytes());
            resp.setContentType("application/json");
            resp.getWriter().write(encodedBase64);
        }
        else if ("/Admin/promotions/delete".equals(path))
        {
            String ID=  req.getParameter("promotion-id");
            int promotionId = Integer.parseInt(ID);
            PromotionDTO promotionDTO = new PromotionDTO();
            promotionDTO.setPromotionId(promotionId);
            promotionDTO.setActive(false);
           boolean status= promotionService.updatePromotion(promotionDTO);
            if(!status)
            {
                req.getSession().setAttribute("message", "unsuccessful");
                req.getSession().setAttribute("messageType", "error");
            }
            else {
                req.getSession().setAttribute("message", "successful");
                req.getSession().setAttribute("messageType", "success");
            }
            resp.sendRedirect(req.getContextPath() + "/Admin");


        }
    }

    }

