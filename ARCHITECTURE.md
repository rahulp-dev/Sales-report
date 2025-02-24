Component Breakdowns:

1. SalesReportService

  Responsible for:
    Fetching sales data efficiently.
    Generating the CSV report.
    Handling large datasets without memory bloat.

  Optimization Considerations:
    Used CSV streaming instead of loading large datasets into memory.

2. GenerateSalesReportJob

  Enqueues the report generation process asynchronously using Sidekiq.
  Implemented retry logic for email failures.

3. SalesReportMailer

  Attaches the CSV file and sends it to admin@clientfirstlabs.io.
  Uses File.read(file_path, mode: "rb") to ensure proper binary reading of the CSV.
  Deletes the file after sending to avoid unnecessary disk usage.

4. Frontend

  Uses Bootstrap 4 for styling.
  Submits form data via a standard POST request.

Error Handling & Resilience:

  Email Failures:

    Implemented retries with ActiveJob’s retry logic.

    Logged errors using Rails.logger.

  Large Datasets Handling:

    Used batching to process large sales records.

    Ensured CSV writing is done in a streaming manner to avoid memory spikes.

  File Management:

    Ensured CSV files are deleted after sending to prevent unnecessary disk usage.

Testing Strategy (RSpec)

  Implemented unit tests to validate functionality:

  SalesReportService Spec:

    Ensures correct data fetching.

    Validates CSV generation.

  GenerateSalesReportJob Spec:

    Confirms job execution.

    Tests retry behavior.

  SalesReportMailer Spec:

    Checks correct email delivery.
    Ensures attachment integrity.

  Edge Cases:

    Empty sales data.
    Large datasets.
    Invalid date range handling.

Performance Considerations:
  Optimized ActiveRecord queries to fetch only required data.
  Batch processing to prevent memory overload.
  Sidekiq background jobs ensure the main request flow is unaffected.

Conclusion:
  This architecture ensures scalability, robustness, and maintainability. By leveraging background jobs, optimized queries, and efficient file handling, we achieve a smooth user experience while processing large datasets effectively.
