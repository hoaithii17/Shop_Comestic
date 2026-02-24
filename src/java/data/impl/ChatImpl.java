/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package data.impl;


import data.dao.ChatDao;
import model.ChatMessage;
import data.driver.MySQLDriver;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ChatImpl implements ChatDao {

    @Override
    public void saveMessage(ChatMessage msg) {
        String sql = "INSERT INTO chat_history (user_id, sender, message) VALUES (?, ?, ?)";

        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, msg.getUserId());
            ps.setString(2, msg.getSender());
            ps.setString(3, msg.getMessage());
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<ChatMessage> getChatHistory(int userId) {
        List<ChatMessage> list = new ArrayList<>();
        String sql = "SELECT * FROM chat_history WHERE user_id = ? ORDER BY created_at ASC";

        try (Connection con = MySQLDriver.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new ChatMessage(
                        rs.getInt("id"),
                        rs.getInt("user_id"),
                        rs.getString("sender"),
                        rs.getString("message")
                ));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
