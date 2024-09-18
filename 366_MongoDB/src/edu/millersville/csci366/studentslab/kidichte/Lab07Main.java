package edu.millersville.csci366.studentslab.kidichte;

import edu.millersville.csci366.studentslab.startercode.CSVFileDataSource;
import edu.millersville.csci366.studentslab.startercode.DataException;
import edu.millersville.csci366.studentslab.startercode.StudentModel;
import edu.millersville.csci366.studentslab.startercode.SwingStudentView;
import edu.millersville.csci366.studentslab.startercode.StudentController;
import edu.millersville.csci366.studentslab.startercode.Action;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Map;
import java.util.Scanner;

public class Lab07Main {

	public static final String PROTOCOL = "jdbc:postgresql";
	/** The name of the server that hosts the database. */
	public static final String HOSTNAME = "csci366.millersville.edu";
	/** The name of the database we want to interact with. */
	public static final String DATABASE = "a07students_kidichte";
	/** The connection URL. */
	public static final String URL = PROTOCOL + "://" + HOSTNAME + "/" + DATABASE;
	/** The username we use for connecting to the database. */
	public static final String USERNAME = "kidichte";
	/** The password we use for connecting to the database. */ 
	public static final String PASSWORD = "Myjdbckid24!";
	
	public static void main(String[] args) throws DataException, SQLException{
		//Class.forName("org.postgresql.Driver");
		Scanner console = new Scanner (System.in);
		StudentController controller;
		StudentModel model = null;
		
		while (true) {
			System.out.print("Enter \'d\' for database or \'f\' for file: ");
			String dfReader = console.nextLine();
				if (dfReader.equals("f")) {
					CSVFileDataSource csv = new CSVFileDataSource("data/students.csv");
					model = new StudentModel (csv);
					break;
				}
				else if (dfReader.equals("d")) {
					Connection conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
					PostgreSQLDataSource database = new PostgreSQLDataSource (conn);
					model = new StudentModel (database);
					break;
				}
				else {
					System.out.println("Invalid input. Try again.");
				}
		}
		while (true) {
			System.out.print("Enter \'s\' for swing view or \'c\' for console view: ");
			String scReader = console.nextLine();
				if (scReader.equals("s")) {
					SwingStudentView view = new SwingStudentView();
					controller = new StudentController(model, view);
					break;
				}
				else if (scReader.equals("c")){
					ConsoleStudentView view = new ConsoleStudentView ();
					controller = new StudentController(model, view);
					break;
				}
				else {
					System.out.println("Invalid input. Try again.");
				}
			}
		controller.run();
	}
}