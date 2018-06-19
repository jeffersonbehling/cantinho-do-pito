<%@page import="Model.Client"%>
<%@page import="Model.Category"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="Model.BuyProduct"%>
<%@page import="Model.BuyProduct"%>
<nav class="nav-extended">
    <div class="nav-wrapper black">
        <a href="" class="brand-logo left"><img class="circle logo" src="/cantinho-do-pito/resources/img/logo.png"></a>
        <ul>
            <% if (request.getSession().getAttribute("client") != null) { %>
                <% Client client = (Client) request.getSession().getAttribute("client"); %>
                <a class='dropdown-trigger right' href='#' data-target='actions'><%= client.getName() %></a>
                    <ul id='actions' class='dropdown-content'>
                        <% if (client.isIsAdmin()) { %>
                            <li><a href="dashboard" class="black-text"><i class="material-icons">dashboard</i>Dashboard</a></li>
                        <% } %>
                      <li><a href="requests?action=my-requests" class="black-text"><i class="material-icons">view_module</i>Meus pedidos</a></li>
                      <li><a href="access?action=logout" class="black-text"><i class="material-icons">exit_to_app</i>Sair</a></li>
                    </ul>
            <% } else { %>
                <li class="right"><a href="clients?action=request-login">Entrar</a></li>
            <% } %>
        </ul>
        <form class="brand-logo center hide-on-small-and-down" method="post" action="home">
            <div class="input-field">
                <% if (request.getParameter("search") != null) { %>
                <input id="search" type="search" name="search" value="<%= request.getParameter("search") %>" placeholder="Pelo que voc� procura?">
                <% } else { %>
                <input id="search" type="search" name="search" placeholder="Pelo que voc� procura?">
                <% } %>
                <label class="label-icon" for="search"><i class="material-icons">search</i></label>
                <i class="material-icons">close</i>
                <input type="submit" class="hide"/>
            </div>
        </form>
        <ul class="right">
            <% int totalProductCart = 0; %>
            <% if (request.getSession().getAttribute("cart") != null) { %>
            <% List<BuyProduct> cart = (List<BuyProduct>) request.getSession().getAttribute("cart"); %>
            <% Iterator<BuyProduct> iterator = cart.iterator(); %>
            <%  
                while (iterator.hasNext()) {
                    BuyProduct buyProduct = iterator.next();
                    totalProductCart += buyProduct.getAmount();
                }
            }
            %>
            <li><span class="circle badge white-text"><%= totalProductCart %></span><a href="buy?action=request-checkout"><i class="material-icons">shopping_cart</i></a></li>
        </ul>
    </div>
    <div class="nav-content black">
        <ul class="tabs tabs-transparent hide-on-small-and-down">
            <li class="tab"><a href="home">P�gina Inicial</a></li>
            <% List<Category> listCategories = (List<Category>) request.getAttribute("listCategories"); %>
            <% Iterator i = listCategories.iterator(); %>
            <% while (i.hasNext()) { %>
                <% Category category = (Category) i.next(); %>
            <li class="tab"><a href="home?category_id=<%= category.getId() %>"><%= category.getName() %></a></li>
            <% } %>
        </ul>
        
    </div>
</nav>
<script>
    $('.dropdown-trigger').dropdown();
</script>