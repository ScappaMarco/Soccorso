package com.soccorso.business.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Connect_JDBC {
    
    private Connection connection;
    private String URL;
    private final String USERNAME;
    private String password;
    
    public Connect_JDBC(String url, String username, String password) {
        this.URL = url;
        this.USERNAME = username;
        this.password = password;
        this.connection = null;
    }

    private Connection connect() {
        try {
            if(this.USERNAME != null && this.password != null) {
                this.connection = DriverManager.getConnection(URL, USERNAME, password);
            } else {
                this.connection = DriverManager.getConnection(URL);
            }
            return this.connection;
        } catch(SQLException e) {
            System.out.println("Errore durante la connessione al Database");
            e.printStackTrace();
            return null;
        }
    }
    
    public Connection getConnection() {
        if(this.connection == null) {
            this.connection = connect();
        }
        return this.connection;
    }

    public Connection newConnection() {
        return connect();
    }

    public void disconnect() {
        try {
            if(this.connection != null && !(this.connection.isClosed())) {
                this.connection.close();
            }
        } catch(SQLException e) {
            System.out.println("Errore durante la chiusura della connessione al Database");
            e.printStackTrace();
        }
    }
}