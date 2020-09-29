package bo;

import dao.ProductDAO;
import dao.ProductDAOImpl;
import model.Product;

import java.util.ArrayList;
import java.util.List;

public class ProductBOImpl implements ProductBO {
    ProductDAO productDAO = new ProductDAOImpl();


    @Override
    public List<Product> findAll() {
        return productDAO.findAll();
    }

    @Override
    public String save(Product product) {
        String message = "";
        if(product.getName()==null || product.getName().equals("")) {
            message ="Please input information";
        } else {
            message = productDAO.save(product);
        }
        return message;
    }
}
