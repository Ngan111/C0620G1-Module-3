package dao;

import model.Product;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

public class ProductDAOImpl implements ProductDAO {
    static Map<Integer,Product> productMap = new TreeMap<>();
    static {
        productMap.put(1,new Product(1,"a",12,"aaa","VN"));
        productMap.put(2,new Product(2,"bbb",11,"BBB","CN"));
        productMap.put(3,new Product(3,"cde",15,"CDE","FR"));
        productMap.put(4,new Product(4,"fgh",25,"FGH","USA"));
        productMap.put(5,new Product(5,"qwerty",45,"QWERTY","EU"));

    }

    @Override
    public List<Product> findAll() {
        return new ArrayList<>(productMap.values());
    }

    @Override
    public String save(Product product) {
        productMap.put(product.getId(),product);
        return "Succeeded";
    }
}
