<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>Login Page</title>
  <link rel="stylesheet" href="https://unpkg.com/bootstrap@5.3.3/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://unpkg.com/bs-brain@2.0.4/components/logins/login-9/assets/css/login-9.css">
</head>
<style>
  * {
    font-size: 18px;
    font-weight: 500;
  }
  .error-message {
    color: red;
    margin-bottom: 15px;
  }

  input{
    text-transform: none;
  }

  .captcha-message {
    display: none;
    color: red;
  }

  .hero-right {
    background-image: url("../image/bannerLogo.jpg");
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    height: 100vh;
  }

  @media (max-width: 768px) {
    .hero-right {
      display: none;
    }

    .hero-left {
      margin: auto;
    }
  }
</style>
<body>
<jsp:include page="./header.jsp"></jsp:include>
<!-- Login 9 - Bootstrap Brain Component -->
<section class="py-md-5">
  <div class="container">
    <div class="row">
      <%-- Hero left --%>
      <div class="col-12 col-md-6 hero-left" style="display: flex; justify-content: center; align-items: center;">
        <div class="card border-0 rounded-4">
          <div class="card-body p-md-4" style="border: 3px solid">
            <div class="row">
              <div class="col-12">
                <div class="mb-3">
                  <h1 style="text-align: center">Đăng Nhập</h1>
                  <p>Bạn chưa có tài khoản? <a href="Register.jsp">Đăng Ký</a></p>
                </div>
              </div>
            </div>
            <form onsubmit="return validateForm()" action="loginEmail" method="post">
              <span class="error-message">${errorMessage}</span>
              <div class="row gy-3 overflow-hidden">
                <div class="col-12">
                  <div class="form-floating mb-2">
                    <input style="text-transform: none" type="email" class="form-control" name="email" id="email" placeholder="name@example.com" required>
                    <label for="email" class="form-label">Email</label>
                  </div>
                </div>
                <div class="col-12">
                  <div class="form-floating mb-2">
                    <input style="text-transform: none" type="password" class="form-control" name="password" id="password" placeholder="Mật khẩu" required>
                    <label for="password" class="form-label">Password</label>
                  </div>
                </div>
                <div class="col-12">
                  <div class="d-grid">
                    <button class="btn btn-primary btn-lg" type="submit">Đăng nhập</button>
                  </div>
                </div>
              </div>
            </form>
            <div class="row">
              <div class="col-12">
                <div class="d-flex gap-2 justify-content-end mt-2">
                  <a href="requestPassword">Quên mật khẩu</a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

        <%-- Hero Right   --%>
        <div class="col-12 col-md-6 hero-right">
          <div class="d-flex text-bg-primary">
            <div class="col-12 col-xl-9">
            </div>
          </div>
        </div>
    </div>
  </div>
</section>

<script src="https://www.google.com/recaptcha/api.js" async defer></script>
<script src="../js/login.js"></script>

</body>
</html>
