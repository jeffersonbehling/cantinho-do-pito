package DAO;

import Model.Client;
import Model.Product;
import Model.Request;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ricardo
 */
public class RequestDAO {

    private Connection conn;

    public RequestDAO() {
        try {
            this.conn = ConnectionFactory.getConnection();

        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
    }

    public boolean add(Request request) throws SQLException {
        try {
            PreparedStatement pstmt = conn.prepareStatement("INSERT INTO requests (product_id, client_id) VALUES (?, ?)");

            pstmt.setString(1, String.valueOf(request.getProductId()));
            pstmt.setString(2, String.valueOf(request.getClientId()));
            pstmt.executeUpdate();
            pstmt.close();
            this.conn.close();

            return true;
        } catch (SQLException e) {
            this.conn.close();
            e.printStackTrace();
            return false;
        }
    }

    public Request view(int id) throws SQLException {
        try {
            PreparedStatement pstmt = conn.prepareStatement("SELECT re.*, pr.*, cli.* FROM requests re, products pr, clients cl WHERE re.product_id = pr.id AND re.client_id = cl.id AND re.id = ?");
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();

            Request request = new Request();
            Product product = new Product();
            Client client = new Client();

            while (rs.next()) {
                request.setId(rs.getInt("id"));
                request.setStatus(Boolean.parseBoolean(rs.getString("re.status")));
                request.setProductId(Integer.parseInt(rs.getString("re.product_id")));
                request.setClientId(Integer.parseInt(rs.getString("re.client_id")));

                product.setId(Integer.parseInt(rs.getString("pr.id")));
                product.setName(rs.getString("pr.name"));
                product.setImage(rs.getString("pr.image"));
                product.setPrice(Integer.parseInt(rs.getString("pr.price")));

                client.setId(Integer.parseInt(rs.getString("pr.id")));
                client.setName(rs.getString("pr.name"));
                client.setEmail(rs.getString("pr.email"));

                request.setProduct(product);
                request.setClient(client);
            }

            pstmt.close();
            rs.close();
            this.conn.close();

            return request;

        } catch (SQLException e) {
            this.conn.close();
            System.out.println("Error: " + e.getMessage());
            return null;
        }
    }

    public int getAllRequests() throws SQLException {
        try {
            PreparedStatement pstmt = conn.prepareStatement("SELECT COUNT(re.id) as requests FROM requests re WHERE re.status = FALSE");
            ResultSet rs = pstmt.executeQuery();
            int count = 0;
            while (rs.next()) {
                count = rs.getInt("requests");
            }
            this.conn.close();
            return count;
        } catch (SQLException e) {
            this.conn.close();
            System.out.println("Error: " + e.getMessage());
            return 0;
        }
    }

    public List<Request> getClientsRequests(int clientId) throws SQLException {
        try {
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM requests WHERE client_id = ?");
            pstmt.setInt(1, clientId);
            ResultSet rs = pstmt.executeQuery();

            ProductDAO productDAO = new ProductDAO();
            ClientDAO clientDAO = new ClientDAO();
            List<Request> listRequests = new ArrayList<Request>();

            while (rs.next()) {
                Request request = new Request();
                request.setId(rs.getInt("id"));
                request.setStatus(rs.getBoolean("status"));
                request.setProductId(rs.getInt("product_id"));
                request.setClientId(rs.getInt("client_id"));

                request.setProduct(productDAO.view(request.getProductId()));
                request.setClient(clientDAO.view(request.getClientId()));

                listRequests.add(request);
            }

            pstmt.close();
            rs.close();

            return listRequests;

        } catch (SQLException e) {
            this.conn.close();
            System.out.println("Error: " + e.getMessage());
            return null;
        }
    }
}
