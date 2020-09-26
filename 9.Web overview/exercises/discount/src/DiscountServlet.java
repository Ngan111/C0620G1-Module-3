import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "DiscountServlet", urlPatterns = "/discount")
public class DiscountServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        double price = Double.parseDouble(request.getParameter("price"));
        double percent = Double.parseDouble(request.getParameter("discount"));
        double amount = price-(price * percent * 0.01);

        request.setAttribute("money","Price before discount "+price+", Price after discount "+amount);

        request.getRequestDispatcher("result_amount.jsp").forward(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
