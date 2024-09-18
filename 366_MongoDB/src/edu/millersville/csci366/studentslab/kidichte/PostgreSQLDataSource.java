package edu.millersville.csci366.studentslab.kidichte;

import java.util.Map;
import java.util.Scanner;
import java.util.TreeMap;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;

import edu.millersville.csci366.studentslab.startercode.DataException;
import edu.millersville.csci366.studentslab.startercode.DataSource;

public class PostgreSQLDataSource implements DataSource {
	
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

	private final Connection conn;

	public PostgreSQLDataSource(Connection c) {
		this.conn = c;
	}

	@Override
	public Map<String, Student> loadAllStudents() throws DataException{
		Map<String, Student> students = new TreeMap<>();
				try (Statement stmt = conn.createStatement();) {
					final String SQL = "SELECT id, name, dept_name, tot_cred FROM student;";
					try (ResultSet rslt = stmt.executeQuery(SQL);) {
						while(rslt.next()) {
							String id = rslt.getString(1);
							String name = rslt.getString(2);
							String dept_name = rslt.getString(3);
							int tot_cred = rslt.getInt(4);
							students.put(id, new Student (id, name, dept_name, tot_cred));
						}
					}
					
				}	
				
			//}
		catch (SQLException exception) {
			throw new DataException(exception);
		}
		return students;
	}

	@Override
	public void createStudent(Student student) throws DataException {
			Map<String, Student> students = loadAllStudents();
			
			if (students.containsKey(student.getId())) {
				throw new DataException("the file already contains a student with ID " + student.getId());
			}
			//try (conn) {
				try (Statement stmt = conn.createStatement();) {
					final String SQL = "INSERT INTO student VALUES (\'" + student.getId() + "\',\'" + student.getName() + "\',\'" 
				    + student.getDeptName() + "\'," + student.getTotCredits() + ");";
					stmt.executeUpdate(SQL);
				}
			//}
			catch (SQLException exception) {
				throw new DataException(exception);
			}
		}

	@Override
	public void updateStudent(Student student) throws DataException {
			Map<String, Student> students = loadAllStudents();
			
			if (!students.containsKey(student.getId())) {
				throw new DataException("the file does not contain a student with ID " + student.getId());
			}

			try (Statement stmt = conn.createStatement();) {
				final String SQL = "UPDATE student SET name = \'" + student.getName() + "\', dept_name = \'"
						+ student.getDeptName() + "\', tot_cred = " + student.getTotCredits() + " WHERE id = \'"
						+ student.getId() + "\';";
				stmt.executeUpdate(SQL);

			}
			catch (SQLException exception) {
				throw new DataException(exception);
			}
	}
	@Override
	public void deleteStudent(Student student) throws DataException {
			Map<String, Student> students = loadAllStudents();
			
			if (!students.containsKey(student.getId())) {
				throw new DataException("the file does not contain a student with ID " + student.getId());
			}

			try (Statement stmt = conn.createStatement();) {
				final String SQL = "DELETE FROM student WHERE id = \'" + student.getId() + "\';";
				stmt.executeUpdate(SQL);

			}
			catch (SQLException exception) {
				throw new DataException(exception);
			}
	}
}
