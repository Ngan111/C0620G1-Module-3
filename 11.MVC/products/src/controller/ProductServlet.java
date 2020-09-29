package controller;

import bo.ProductBO;
import bo.ProductBOImpl;
import model.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProductServlet", urlPatterns = {"","/productList"})
public class ProductServlet extends HttpServlet {
    ProductBO productBO = new ProductBOImpl();
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String actionUser = request.getParameter("actionUser");
    if (actionUser == null) {
        response.sendRedirect("");
    }else {
        String name = request.getParameter("productName");
        String price = request.getParameter("price");
        String description = request.getParameter("description");
        String manufacturer = request.getParameter("manufacturer");
        int idRandom =(int)(Math.random()*1000);
        Product product = new Product(idRandom,name,Double.parseDouble(price),description,manufacturer);
        String message = this.productBO.save(product);
        request.setAttribute("message",message);
        request.getRequestDispatcher("create.jsp").forward(request,response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String actionUser = request.getParameter("actionUser");
        if (actionUser == null) {
            List<Product> productList = this.productBO.findAll();
            request.setAttribute("abcList",productList);
            request.getRequestDispatcher("list.jsp").forward(request,response);
        }else if(actionUser.equals("create")) {
            response.sendRedirect("create.jsp");
        }

    }
}
