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
