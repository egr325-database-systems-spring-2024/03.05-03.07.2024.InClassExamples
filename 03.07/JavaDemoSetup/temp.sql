SELECT SUM(line_item_amount) FROM invoice_line_items WHERE invoice_id = 100;

UPDATE invoices
SET invoice_total = 67.92
WHERE invoice_id = 100;