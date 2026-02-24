package data.dao;

import java.util.List;
import model.User;

public interface UserDao {
    User findUser(String emailphone, String password);
    User findUser(String emailphone);
    void insertUser(String name, String email, String phone, String password);
    void insertUser(User user);
    boolean updateUser(User user);
    User getUserById(int id);
    boolean updatePassword(int id, String newPassword);
    List<User> findAllUsers();
    void deleteUser(int id);
    User findById(int id);
}
