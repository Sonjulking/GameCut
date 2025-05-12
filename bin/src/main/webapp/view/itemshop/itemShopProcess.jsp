<%@page import="com.gamecut.dao.ItemDAO"%>
<%@page import="com.gamecut.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    UserVO user = (UserVO) session.getAttribute("user");
    if (user == null) {
        out.println("<script>alert('로그인이 필요합니다.'); location.href='login.jsp';</script>");
        return;
    }

    int userNo = user.getUserNo();
    int itemNo = Integer.parseInt(request.getParameter("itemNo"));

    ItemDAO dao = new ItemDAO();
    dao.purchaseItem(userNo, itemNo);

    out.println("<script>alert('구매 처리가 완료되었습니다.'); location.href='itemshop.jsp';</script>");
%>