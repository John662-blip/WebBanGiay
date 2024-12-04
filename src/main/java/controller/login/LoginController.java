package controller.login;

import Authentication.FacebookAuth;
import Authentication.GoogleAuth;
import dto.AccountDTO;
import dto.UserDTO;
import enums.RoleType;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.json.JSONObject;
import service.IAccountService;
import service.IUserService;
import service.Impl.AccountServiceImpl;
import service.Impl.UserServiceImpl;

import javax.net.ssl.HttpsURLConnection;
import java.io.*;
import java.net.URL;

@WebServlet(urlPatterns = { "/view/loginEmail"})
public class LoginController extends HttpServlet {
    private  IAccountService accountService = new AccountServiceImpl();
    private IUserService userService = new UserServiceImpl();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        AccountDTO accountDTO = new AccountDTO();
        String path = req.getServletPath();
        if("/view/loginEmail".equals(path)) { //Login Email/Password
            String email = req.getParameter("email");
            String password = req.getParameter("password");

            accountDTO.setEmail(email);
            accountDTO.setPassword(password);
            accountDTO = accountService.findAccountForLogin(accountDTO);
            if(accountDTO != null) {
                UserDTO userDTO = userService.findUserByAccoutId(accountDTO.getAccountID());
                //Tao mot session moi hoac lay session hien co
                HttpSession session = req.getSession();
                //Luu thong tin nguoi dung vao session
                session.setAttribute("user", userDTO);
                req.setAttribute("errorMessage", "Đăng nhập thanhh công");
                if(userDTO.getAccount().getRole().equals(RoleType.ADMIN)){
                    resp.sendRedirect("/Admin");
                    return;
                } else {
                    resp.sendRedirect("/home");
                    return;
                }

            } else {
                req.setAttribute("errorMessage", "Email hoặc mật khẩu không chính xác.");
                req.getRequestDispatcher("/view/login.jsp").forward(req, resp);
            }
       }
    }
}