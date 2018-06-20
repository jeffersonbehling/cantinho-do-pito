<%-- 
    Document   : index
    Created on : 09/06/2018, 14:20:32
    Author     : ricardo
--%>
<%@page import="Controller.AccessController"%>
<%@ page import="Model.Category" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page contentType="text/html;charset=ISO-8859-1" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Categorias</title>
        <jsp:include page="../Layout/default.jsp"/>
        <jsp:include page="../Layout/timeout.jsp"/>
    </head>
    <body>
        <%--<jsp:include page="../Layout/timeout.jsp"/>--%>
        <jsp:include page="../Layout/navbar.jsp"/>
        <main>
            <jsp:include page="../Layout/sidenav.jsp"/>
            <div class="row">
                <jsp:include page="../Layout/flash.jsp"/>
                <div class="col s12 m6 offset-s3 l6 offset-l3">
                    <div class="card">
                        <div class="card-content">
                            <span class="card-title">Categorias</span>
                            <table class="striped responsive-table">
                                <thead>
                                    <tr>
                                        <th>Nome</th>
                                        <th>Descri��o</th>
                                        <th>A��es</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        if (request.getAttribute("listCategories") != null) {
                                            List<Category> listCategories = (List<Category>) request.getAttribute("listCategories");
                                            Iterator i = listCategories.iterator();
                                            while (i.hasNext()) {
                                                Category category = (Category) i.next();
                                    %>
                                    <tr>
                                        <td><%= category.getName()%></td>
                                        <td><%= category.getDescription()%></td>
                                        <td>
                                            <a href="categories?action=request-edit&id=<%= category.getId()%>">
                                                <i class="material-icons" title="Excluir">edit</i>
                                            </a>&nbsp
                                            <a href="categories?action=delete&id=<%= category.getId()%>"  onclick="return confirm('Deseja excluir a categoria <%= category.getName()%>?')">
                                                <i class="material-icons" title="Excluir">delete</i>
                                            </a>&nbsp
                                        </td>
                                    </tr>
                                    <% }
                                        } else {
                                            AccessController accessController = new AccessController();
                                            accessController.directoryControl(request, response);
                                        }
                                    %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <jsp:include page="../Layout/footer.jsp"/>
    </body>
</html>