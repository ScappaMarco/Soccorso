package com.soccorso;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.stage.Stage;
import javafx.scene.*;

public class App extends Application {
    public static void main(String[] args) {
        Application.launch(args);
    }

    @Override
    public void start(Stage primaryStage) throws Exception {
        Parent root = FXMLLoader.load(getClass().getResource("/com/soccorso/ex.fxml"));
        primaryStage.setTitle("Title");
        primaryStage.setScene(new Scene(root));
        primaryStage.show();
    }
}