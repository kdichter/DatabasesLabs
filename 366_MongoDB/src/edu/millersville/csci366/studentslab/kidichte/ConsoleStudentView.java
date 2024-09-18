package edu.millersville.csci366.studentslab.kidichte;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Map;
import java.util.Scanner;
import java.util.TreeMap;

import edu.millersville.csci366.studentslab.startercode.Action;
import edu.millersville.csci366.studentslab.startercode.DataException;
import edu.millersville.csci366.studentslab.startercode.StudentView;

public class ConsoleStudentView implements StudentView{
	
	/** The protocol used to connect to the database server. */
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
	
	public static final String DELIMETER = ",";
	
	
	@Override
	public void showAllStudents(Map<String, Student> students) {
		System.out.format("%5s %20s %20s %3s", "   ID |", "   Name |", "   Department |", "Credits\n");
		for (Student s : students.values()) {
			String id = s.getId();
			String name = s.getName();
			String dept = s.getDeptName();
			int cred = s.getTotCredits();
			System.out.format("%5s %20s %20s %3s", id + " |", name + " |", dept + " |", cred + "\n");
		}
	}
	

	@Override
	public Student getNewStudentDetails() {
		Scanner console = new Scanner (System.in);
		System.out.print("ID: ");
		String id = console.nextLine();
		System.out.print("Name: ");
		String name = console.nextLine();
		System.out.print("Department Name: ");
		String dept = console.nextLine();
		System.out.print("Total Credits: ");
		int cred = console.nextInt();
		return new Student (id, name, dept, cred);
		
	}
	@Override
	public void notifyCreateFailure(Student failedCreation, String reason) {
		System.out.println("Could not create student " + failedCreation.getId() + " because " + reason);
		
	}
	@Override
	public String getIdToDelete() {
		Scanner console = new Scanner (System.in);
		System.out.print("Which ID to delete: ");
		String id = console.nextLine();
		return id;
	
	}
	@Override
	public void notifyDeletionFailure(String id, String reason) {
		System.out.println("Could not delete student " + id + " because " + reason);
		
	}
	@Override
	public String getIdToEdit() {
		Scanner console = new Scanner (System.in);
		System.out.print("Which ID to edit: ");
		String id = console.nextLine();
		return id;
		
	}
	@Override
	public void editStudent(Student student) {
		String tempName = student.getName();
		String tempDept = student.getDeptName();
		int tempCred = student.getTotCredits();

		Scanner console = new Scanner (System.in);
		while (true) {
			String editId = student.getId();
			String editName = student.getName();
			String editDept = student.getDeptName();
			int editCred = student.getTotCredits();
			System.out.format("%5s %20s %20s %3s", editId + " |", editName + " |", editDept + " |", editCred + "\n");
			
			System.out.println("Select to edit name, department, credits, save, or cancel: ");
			String reader = console.nextLine();
			
			if (reader.equals("name")) {
				System.out.println("New Name: ");
				String nameReader = console.nextLine();
				student.setName(nameReader);
			}
			else if (reader.equals("departent")) {
				System.out.println("New Department: ");
				String deptReader = console.nextLine();
				student.setDeptName(deptReader);
			}
			else if (reader.equals("credits")) {
				System.out.println("New Credits: ");
				int credReader = console.nextInt();
				student.setTotCredits(credReader);
			}
			else if (reader.equals("save")) {
				break;
			}
			else if (reader.equals("cancel")) {
				student.setName(tempName);
				student.setDeptName(tempDept);
				student.setTotCredits(tempCred);
				break;
			}
			else {
				System.out.println("Invalid input. Try again. ");
			}
		}
		
	}
	@Override
	public void notifyEditFailure(String id, String reason) {
		System.out.println("Could not edit student " + id + " because " + reason);
		
	}
	@Override
	public Action getNextAction() {
		System.out.println("Type and of \'new\', \'edit\', \'delete\', \'refresh\', or \'quit\': ");
		Scanner console = new Scanner(System.in);
		String reader = console.nextLine();
		
			if (reader.equals("new")) {
				return Action.NEW;
			}
			else if (reader.equals("edit")) {
				return Action.EDIT;
			}
			else if (reader.equals("delete")) {
				return Action.DELETE;
			}
			else if (reader.equals("refresh")) {
				return Action.REFRESH;
			}
			else if (reader.equals("quit")) {
				return Action.QUIT;
			}
			else {
				System.out.println("Invalid option. Try again.");
				return null;
			}
	}
	@Override
	public void notifyLoadFailure(String reason) {
		System.out.println("Could not load students because " + reason);
		
	}

}
