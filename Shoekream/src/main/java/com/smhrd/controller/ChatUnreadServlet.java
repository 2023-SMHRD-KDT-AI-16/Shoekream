package com.smhrd.controller;


import java.io.IOException;
import java.net.URLDecoder;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.smhrd.model.ChatDAO;

@WebServlet("/ChatUnreadServlet")
public class ChatUnreadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String userID = request.getParameter("userID");
        if(userID == null || userID.equals("")) {
            response.getWriter().write("0");
        } else {
            HttpSession session = request.getSession();
            if(!userID.equals(session.getAttribute("userID"))) {
                response.getWriter().write("");
                return;
            }
            userID = URLDecoder.decode(userID, "UTF-8");
            ChatDAO chatDAO = new ChatDAO();
            int count = chatDAO.getAllUnreadChat(userID);
            response.getWriter().write(count + "");
        }
    }
}