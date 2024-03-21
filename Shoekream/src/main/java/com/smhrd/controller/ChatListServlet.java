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

@WebServlet("/ChatListServlet")
public class ChatListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String fromID = request.getParameter("fromID");
        String toID = request.getParameter("toID");
        String listType = request.getParameter("listType");
        ChatDAO chatDAO = new ChatDAO();

        if(fromID == null || fromID.equals("") || toID == null || toID.equals("") || listType == null || listType.equals("")) {
            response.getWriter().write("");
        } else if (listType.equals("ten")) {
            String result = chatDAO.getTen(URLDecoder.decode(fromID, "UTF-8"), URLDecoder.decode(toID, "UTF-8"));
            response.getWriter().write(result);
        } else {
            HttpSession session = request.getSession();
            if(!URLDecoder.decode(fromID, "UTF-8").equals((String) session.getAttribute("userID"))){
                response.getWriter().write("");
                return;
            }
            // getID 메서드 호출 로직 (생략)
        }
    }
}