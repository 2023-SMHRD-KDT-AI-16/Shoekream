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

@WebServlet("/ChatSubmitServlet")
public class ChatSubmitServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String fromID = request.getParameter("fromID");
        String toID = request.getParameter("toID");
        String chatContent = request.getParameter("chatContent");

        if(fromID == null || fromID.equals("") || toID == null || toID.equals("")
                || chatContent == null || chatContent.equals("")) {
            response.getWriter().write("0");
        } else if (fromID.equals(toID)) {
            response.getWriter().write("-1");
        } else {
            fromID = URLDecoder.decode(fromID, "UTF-8");
            toID = URLDecoder.decode(toID, "UTF-8");
            chatContent = URLDecoder.decode(chatContent, "UTF-8");
            
            HttpSession session = request.getSession();
            if(!fromID.equals((String) session.getAttribute("userID"))){
                response.getWriter().write("");
                return;
            }
            
            ChatDAO chatDAO = new ChatDAO();
            int result = chatDAO.submit(fromID, toID, chatContent);
            response.getWriter().write(String.valueOf(result));
        }
    }
}