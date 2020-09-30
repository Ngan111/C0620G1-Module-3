package DAO;

import Model.User;

import java.sql.SQLException;
import java.util.List;

public interface IUserDAO {
    //    Bước 4: Tạo interface IUserDAO:
    void insertUser(User user) throws SQLException;

    User selectUser(int id);

    List<User> selectAllUsers();

    boolean deleteUser(int id) throws SQLException;

    boolean updateUser(User user) throws SQLException;

    List<User> sortUsersByName();
    List<User> searchUsersByCountry(String countrySearch);
    public User getUserById(int id);
    public void insertUserStore(User user) throws SQLException;
}
