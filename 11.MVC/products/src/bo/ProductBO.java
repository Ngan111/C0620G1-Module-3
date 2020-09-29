package bo;

import model.Product;

import java.util.List;

public interface ProductBO {
    List<Product> findAll();
    String save(Product product);

}
