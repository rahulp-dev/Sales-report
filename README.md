### Overview
This Senior Rails Developer Assessment is designed to evaluate your technical mastery of Rails, background job processing, database optimization, and test-driven development.

### Assessment Tasks

1. **Implement the GenerateSalesReportJob**
   - Add a page at the root path with a form
   - The root page will show a form with these inputs:
      - start_date
      - end_date
      - customer_name (optional - if no customer name is selected, default to all customers)
   - When the form is submitted, trigger a background job that runs asynchronously using Sidekiq or ActiveJob.
   - The job will Generate a CSV report from sales data from the database for the selected date range.
   - The CSV report will be emailed to `admin@clientfirstlabs.io` upon successful completion.
   - Implement error handling and retry logic, especially for email delivery failures.
   - Optimize database queries for performance and efficiency.

2. **Sales Report Structure**
   The generated sales report will have the following structure:
   ```csv
   Sales Report from START_DATE to END_DATE

   Total Sales Amount: TOTAL_SALES_AMOUNT_FOR_DATE_RANGE

   ID, Amount, Created At, Customer Name
   1, 500.00, 2025-02-01 10:30:00, John Doe
   2, 300.50, 2025-02-02 14:15:00, Jane Smith
   3, 450.75, 2025-02-03 09:45:00, Alan Johnson
   ```
   - The first line will be a header indicating the report period.
   - The second line will be empty
   - The third ine will indicate the total amount for the report period
   - The fourth line will be blank
   - The fifth line will be column headers.
   - Each subsequent line will represent a sale record with its ID, amount, timestamp, and customer name.

3. **Testing Requirements**
   - Write RSpec tests to cover:
     - Job enqueuing.
     - Report generation and email delivery.
     - Handling large datasets efficiently.
     - Edge cases such as date ranges with no sales.
   - E2E tests are not required but you can do so. State your reason for having them. 

4. **Performance Expectations**
   - Demonstrate effective queries to optimize data fetching.
   - Ensure memory usage is efficient, even with large datasets.
   - Implement retry mechanisms for failed email deliveries.

5. **Submission Requirements**
   - Create logical commits for your work
   - Create a professional PR to be reviewed

6. **Additional Deliverables**
   - Include a detailed README with instructions on how to set up and run the project.
   - Provide a reflection on your architectural choices in a `ARCHITECTURE.md` file.

### Setup Instructions

1. **Install dependencies**:
   ```bash
   bundle install
   ```

2. **Set up the database**:
   ```bash
   rails db:create db:migrate db:seed
   ```

3. **Start Sidekiq**:
   ```bash
   bundle exec sidekiq
   ```

4. **Run the application**:
   ```bash
   rails server
   ```

5. **Run tests**:
   ```bash
   bundle exec rspec
   ```

### Evaluation Criteria

Please treat this project as you would a feature request from a client. This is intended to show how you normally work day to day and naturally communicate. 

You will be evaluated on these main criteria:
- Your code quality, clarity and alignment with Rails conventions.
- How you implement your tests and what you choose to cover and not cover. Please be prepared to talk about your decisions here.
- Demonstration of efficient database access and memory management.
- Error handling and user experience design.
- Your management of code, commits and pull requests.
- Your ability to communicate intent, share your knowledge, and make it easy to review your code.

Good luck!
