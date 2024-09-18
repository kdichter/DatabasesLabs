package edu.millersville.csci366.studentslab.kidichte;

public class Student {
	private String id;
	private String name;
	private String departmentName;
	private int totalCredits;

	public Student (String id, String name, String departmentName, int totalCredits) {
		this.id = id;
		this.name = name;
		this.departmentName = departmentName;
		this.totalCredits = totalCredits;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getId() {
		return id;
	}

	public String getDeptName() {
		return departmentName;
	}

	public void setDeptName(String departmentName) {
		this.departmentName = departmentName;
	}

	public int getTotCredits() {
		return totalCredits;
	}

	public void setTotCredits(int totalCredits) {
		this.totalCredits = totalCredits;
	}
	
	
}
