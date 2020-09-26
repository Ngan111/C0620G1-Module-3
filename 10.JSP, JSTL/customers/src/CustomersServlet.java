import object.customers;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "CustomersServlet",urlPatterns = {"", "/listCustomer"})
public class CustomersServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<customers> customersList = new ArrayList<>();
        customersList.add(new customers("A","01/11/1992","HV","cat1.png"));
        customersList.add(new customers("c","01/12/1993","DBP","cat2.jpg"));
        customersList.add(new customers("d","01/10/1994","DAD","cat3.jpg"));
        request.setAttribute("customer_list",customersList);
        request.getRequestDispatcher("List.jsp").forward(request,response);



    }
}
