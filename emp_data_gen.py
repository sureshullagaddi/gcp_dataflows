import csv
import random
import string
from faker import Faker
from google.cloud import storage

# Initialize Faker
fake = Faker()

# Define Departments and Salary Range
departments = ["HR", "Engineering", "Marketing", "Finance", "Sales", "Operations"]
salary_range = {"HR": (40000, 80000), "Engineering": (60000, 150000), "Marketing": (50000, 100000),
                "Finance": (55000, 120000), "Sales": (45000, 90000), "Operations": (50000, 95000)}

# Function to generate a random password
def generate_password(length=12):
    characters = string.ascii_letters + string.digits + string.punctuation
    return ''.join(random.choice(characters) for _ in range(length))

# Generate Employee Data
def generate_employees(num_records=100):
    employees = []
    for emp_id in range(1, num_records + 1):
        name = fake.name()
        email = fake.email()
        department = random.choice(departments)
        salary = random.randint(*salary_range[department])
        joining_date = fake.date_between(start_date='-5y', end_date='today')
        password = generate_password()

        employees.append([emp_id, name, email, department, salary, joining_date, password])

    return employees

# Save to CSV File
def save_to_csv(data, filename="employees.csv"):
    headers = ["Employee_ID", "Name", "Email", "Department", "Salary", "Joining_Date", "Password"]

    with open(filename, mode='w', newline='', encoding='utf-8') as file:
        writer = csv.writer(file)
        writer.writerow(headers)
        writer.writerows(data)

    print(f"✅ Successfully generated {len(data)} employee records in {filename}")
    return filename

# Upload File to Google Cloud Storage
def upload_to_gcs(bucket_name, source_file, destination_blob):
    storage_client = storage.Client()
    bucket = storage_client.bucket(bucket_name)
    blob = bucket.blob(destination_blob)

    blob.upload_from_filename(source_file)
    print(f"📤 File {source_file} uploaded to gs://{bucket_name}/{destination_blob}")

# Run Script
if __name__ == "__main__":
    num_employees = 1000  # Change this number to generate more employees
    local_file = save_to_csv(generate_employees(num_employees))

    # GCS Bucket details
    GCS_BUCKET_NAME = "my_first_bucket_test01"  # Change this to your GCS bucket name
    GCS_FILE_PATH = "employee_data/employees.csv"  # Path inside the bucket

    # Upload CSV file to GCS
    upload_to_gcs(GCS_BUCKET_NAME, local_file, GCS_FILE_PATH)
