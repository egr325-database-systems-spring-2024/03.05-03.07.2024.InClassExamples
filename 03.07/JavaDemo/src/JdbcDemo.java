import java.sql.*;
import java.util.Scanner;

public class JdbcDemo {

    public static void main(String[] args) throws SQLException {
        Connection ap = DriverManager.getConnection("jdbc:mysql://localhost:3306/ap", "root", "password");

        CallableStatement invoiceSummaryCall = ap.prepareCall("{ CALL InvoiceSummaryForVendorID(?, ?, ?, ?, ?) }");
        System.out.print("Enter vendor id: ");
        Scanner scnr = new Scanner(System.in);
        int vendorID = scnr.nextInt();

        invoiceSummaryCall.setInt("vendor_id_param",vendorID);
        invoiceSummaryCall.registerOutParameter("max_invoice_total", Types.DECIMAL);
        invoiceSummaryCall.registerOutParameter("min_invoice_total", Types.DECIMAL);
        invoiceSummaryCall.registerOutParameter("percent_difference", Types.DECIMAL);
        invoiceSummaryCall.registerOutParameter("count_invoice_id", Types.INTEGER);
        invoiceSummaryCall.executeQuery();

        double maxInvoiceAmount = invoiceSummaryCall.getDouble("max_invoice_total");
        double minInvoiceAmount = invoiceSummaryCall.getDouble("min_invoice_total");
        double percentDifference = invoiceSummaryCall.getDouble("percent_difference");
        int invoiceCount = invoiceSummaryCall.getInt("count_invoice_id");

        System.out.println("VendorID: " + vendorID +
                " \nInvoice Count: " + invoiceCount +
                " \nMax Invoice Amount: $" + maxInvoiceAmount +
                " \nMin Invoice Amount: $" + minInvoiceAmount +
                " \nPercent Difference: %" + percentDifference
                );
        ap.close();
    }
}