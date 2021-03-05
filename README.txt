Backend:
defining version to be supported for terraforma and S3 bucket for terraformstate file.

Varibales:
1. Master region = ap-south-1
2. Amazion Linux AMi = "ami-0eeb03e72075b9bcc"
3. Instance type = "t2-micro"

Providers:
Assigining alias to variables

Security Groups:
1.backend-sg to allow communication between public and private subnet.
2.frontend-sg to allow communication between public subnet and internet.

VPC:
1. VPC in master region with CIDR block 10.0.0.0/16
2. Consist of 2 Public subnets and 1 private

Instances:
1. Frontend server serving web appliccation with user data
2. Backend serevr for database.
3. Using SSH key 'mastercard11'

Appliccation Load Balancer:
1. attached to frontend-sg 

Autoscaling Launch Template:
1. Lauch configuration for Autoscailing Group 

DATA:

To get the latest ami for Autoscailing


Autoscailing Group:
1. Condition to scale-up and scale-down 
2. cloud watch alarm for CPU utilization.
