<%
    request.getSession().removeAttribute("admin");
    response.sendRedirect(request.getContextPath()+"/admin/login");
    %>