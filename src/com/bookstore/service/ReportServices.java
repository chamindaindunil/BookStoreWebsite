package com.bookstore.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;

public class ReportServices {
	private HttpServletRequest request;
	private HttpServletResponse response;
	
	public ReportServices(HttpServletRequest request, HttpServletResponse response) {
		super();
		this.request = request;
		this.response = response;
	}

	public void viewReportGenerateForm() throws ServletException, IOException {
		String reportPage = "report_generate.jsp";
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(reportPage);
		requestDispatcher.forward(request, response);
	}
	
	public void reportGeneratePDF() throws JRException, SQLException, IOException {
		int reportType = Integer.parseInt(request.getParameter("reportType"));
		
		if (reportType == 1) {
			orderReportCompile();
		} else if (reportType == 2) {
			customerReportCompile();
		} else {
			System.out.println("userReport");
		}
	}
	
	// Generate Customer Report
	private void customerReportCompile() throws JRException, SQLException, IOException {
		// Compiling Report
		String jrxmlPath = request.getServletContext().getRealPath("/report/Customer.jrxml");
		InputStream input = new FileInputStream(new File(jrxmlPath));
		JasperDesign jasperDesign = JRXmlLoader.load(input);
		JasperReport jasperReport = JasperCompileManager.compileReport(jasperDesign);
		
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		// DB Connection
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstoredb", "root", "Tanasha@1987");
		
		// Fill the report
		JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parameters, conn);
		
		// Export as PDF file
		response.setContentType("application/x-download");
		response.addHeader("Content-disposition", "attachment; filename=CustomerReport.pdf");
		OutputStream out = response.getOutputStream();
		JasperExportManager.exportReportToPdfStream(jasperPrint, out);
	}
	
	// Generate Order Report
	private void orderReportCompile() throws JRException, SQLException, IOException {
		// Compiling Report
		String jrxmlPath = request.getServletContext().getRealPath("/report/Purchase.jrxml");
		InputStream input = new FileInputStream(new File(jrxmlPath));
		JasperDesign jasperDesign = JRXmlLoader.load(input);
		JasperReport jasperReport = JasperCompileManager.compileReport(jasperDesign);
		
		Map<String, Object> parameters = new HashMap<String, Object>();
		
		// DB Connection
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstoredb", "root", "Tanasha@1987");
		
		// Fill the report
		JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parameters, conn);
		
		// Export as PDF file
		response.setContentType("application/x-download");
		response.addHeader("Content-disposition", "attachment; filename=PurchaseReport.pdf");
		OutputStream out = response.getOutputStream();
		JasperExportManager.exportReportToPdfStream(jasperPrint, out);
	}
}


