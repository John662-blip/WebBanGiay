<%-- Created by IntelliJ IDEA. User: b2h16 Date: 11/12/2024 Time: 9:22 AM To change this template use File | Settings |
    File Templates. --%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Shop</title>
  <script src="https://cdn.tailwindcss.com"> </script>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet" />
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&amp;display=swap" rel="stylesheet" />
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&amp;display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/filter-product.css">
  <link href="https://fonts.googleapis.com/css2?family=Calibri&display=swap" rel="stylesheet">

  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

  <script type="text/javascript"
          src="${pageContext.request.contextPath}/js/filter-product.js" defer></script>
</head>

<body class="bg-white text-gray-800">
<div id="categoryListJson" style="display: none;">${categoryListJson}</div>
<div id="jsonProductNames" style="display: none;">${jsonProductNames}</div>
<div id="soldQuantityMapJson" style="display: none;">${soldQuantityMapJson}</div>
<div id="jsonGetAvgReviewMap" style="display: none;">${jsonGetAvgReviewMap}</div>
<div id="contextPath" data-contextPath="${pageContext.request.contextPath}"></div>
<div id="selectedSize" selectedSize="${selectedSize}"></div>
<div id="selectedColor" selectedColor="${selectedColor}"></div>
<div id="selectedCategory" selectedCategory="${selectedCategory}"></div>
<div id="selectedPromotion" selectedPromotion="${selectedPromotion}"></div>
<div id="filterMinPrice" filterMinPrice="${filterMinPrice}"></div>
<div id="filterMaxPrice" filterMaxPrice="${filterMaxPrice}"></div>
<div id="sortOption" sortOption="${sortOption}"></div>
<div id="totalSize" totalSize="${totalSize}"></div>
<div id="searchName" searchName="${searchName}"></div>
<header>
    <%@ include file="/view/header.jsp" %>
</header>
<main class="container mx-auto px-4 py-0" style="margin-top: 70px; margin-bottom: 10px; font-family: 'Calibri', sans-serif !important;">
  <div style="display: flex; justify-content: flex-end; padding: 8px 0;">
    <div class="relative">
      <input class="border rounded-full px-4 py-2 w-64 pl-10" placeholder="Tìm kiếm sản phẩm..." type="text" />
      <i class="fas fa-search absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-500 cursor-pointer"></i>
      <ul id="suggestionsList" class="suggestions-list"></ul>
    </div>
  </div>
  <div class="flex">
    <aside class="w-1/4 pr-8">
      <div class="bg-white p-4 rounded-lg shadow-sm mb-6 border border-gray-200">
        <div class="mb-6">
          <h3 class="font-medium mb-2 flex justify-between items-center">
            Thể loại
            <!-- Nút để toggle danh sách thể loại -->
            <button id="toggleCategories" class="text-blue-500 text-xs font-semibold hover:text-blue-700 transition-all duration-300 flex items-center space-x-1 border border-blue-300 hover:border-blue-500 rounded-full px-2 py-1 focus:outline-none focus:ring-2 focus:ring-blue-300">
              <span id="toggleIcon" class="text-sm">↓</span> <!-- Biểu tượng mũi tên xuống -->
              <span id="toggleText">Xem tất cả</span>
            </button>
          </h3>
          <!-- Danh sách thể loại -->
          <ul class="space-y-2 hidden" id="category-list">
            <c:forEach var="category" items="${categories}">
              <li class="category-item">
                <a class="text-gray-700 category-btn" href="#"
                   onclick="selectCategoryAndLoadPage(this)"
                   data-category="${category}">
                    ${category}
                </a>
              </li>
            </c:forEach>
          </ul>
        </div>
      </div>
      <div class="bg-white p-4 rounded-lg shadow-sm mb-6 border border-gray-200">
        <div class="mb-6">
          <h3 class="font-medium mb-2">Giá tiền</h3>
          <div class="custom-slider___1" data-min="${minPrice}" data-max="${maxPrice}">
            <div class="slide">
              <div class="line" id="line" style="left: 0%; right: 0%;"></div>
              <span class="thumb" id="thumbMin" style="left: 0%;"></span>
              <span class="thumb" id="thumbMax" style="left: 100%;"></span>
            </div>
            <input
                    id="rangeMin"
                    class="custom-slider___1-input"
                    type="range"
                    max="${maxPrice}"
                    min="${minPrice}"
                    step="${minPrice < 50000 ? minPrice : 50000}"
                    value="${minPrice}">
            <input
                    id="rangeMax"
                    class="custom-slider___1-input"
                    type="range"
                    max="${maxPrice}"
                    min="${minPrice}"
                    step="${minPrice < 50000 ? minPrice : 50000}"
                    value="${maxPrice}">
          </div>
          <div class="flex justify-between text-sm text-gray-500 mt-2">
            <span id="min">${minPrice}</span>
            <span id="max">${maxPrice}</span>
          </div>
        </div>
        <div style="display: none" class="mb-6">
          <h3 class="font-medium mb-2">Màu sắc</h3>
          <div class="flex flex-wrap gap-2">
            <c:forEach var="color" items="${colorList}">
              <button
                      class="color-btn w-6 h-6 rounded-full cursor-pointer border-2 border-gray-300"
                      style="background-color: ${color};"
                      onclick="selectColor(this)">
              </button>
            </c:forEach>
          </div>
        </div>
        <div style="display: none" class="mb-6">
          <h3 class="font-medium mb-2">Kích thước</h3>
          <div class="flex flex-wrap gap-2">
            <c:forEach var="size" items="${sizeList}">
              <button class="border px-2 py-2 text-sm size-btn"
                      style="border-radius: 50%; width: 40px; height: 40px; display: flex; align-items: center; justify-content: center;"
                      data-size="${size}" onclick="selectSize(this)">
                  ${size}
              </button>
            </c:forEach>
          </div>
        </div>
        <button class="w-full bg-black text-white py-2 rounded-full"
                onclick="apply()">Áp dụng</button>
      </div>
    </aside>
    <section class="w-3/4">
      <div class="flex justify-between items-center mb-6">
        <div class="flex items-center space-x-4">
          <span class="text-gray-500" id="dynamicSpan"></span>
        </div>
        <div class="relative">
          <button id="dropdownButton"
                  class="border rounded-full px-4 py-2 text-sm flex items-center"
                  onclick="toggleDropdown()"
          ${totalPages == 0 ? 'style="display: none;"' : ''}>
            Phổ biến nhất <i class="fas fa-chevron-down ml-2"></i>
          </button>
          <ul id="dropdownMenu"
              class="absolute bg-white border rounded-lg shadow-lg mt-2 hidden"
          ${totalPages == 0 ? 'style="display: none;"' : ''}>
          </ul>
        </div>

      </div>
      <div class="grid grid-cols-3 gap-6" id="product-container"></div>

      <div class="flex justify-between items-center mt-8">
        <!-- Nút Previous -->
        <button
                class="border rounded-full px-4 py-2 text-sm flex items-center"
        ${totalPages <= 1 ? 'style="display: none;"' : ''}
                onclick="apply(${currentPage - 1 == 0 ? totalPages : currentPage - 1})">
          <i class="fas fa-chevron-left mr-2"></i> Trước
        </button>
        <span class="px-4 text-sm flex-1 text-center"
        ${totalPages == 0 ? 'style="display: none;"' : ''}
        > Trang ${currentPage} / ${totalPages} </span>
        <button
                class="border rounded-full px-4 py-2 text-sm flex items-center"
        ${totalPages <= 1 ? 'style="display: none;"' : ''}
                onclick="apply(${currentPage + 1 > totalPages ? 1 : currentPage + 1})">
          Sau <i class="fas fa-chevron-right ml-2"></i>
        </button>
      </div>
    </section>
  </div>
</main>
<footer>
  <jsp:include page="/view/footer.jsp"></jsp:include>
</footer>
</body>

</html>