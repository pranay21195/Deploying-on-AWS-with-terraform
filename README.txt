Deploying on AWS with terraform

Backend:
defining version to be supported for terraform and S3 bucket for terraform state file.

Varibales:
1. Default Master region = ap-south-1
2. Amazion Linux AMi = "ami-0eeb03e72075b9bcc"
3. Instance type = "t2-micro"

Providers:
Specifying the Platform for deployment

Security Groups:
1.backend-sg to allow communication between public and private subnet.
2.frontend-sg to allow communication between public subnet and internet.

VPC:
1. VPC in the master region with CIDR block 10.0.0.0/16
2. Consist of 2 Public subnets and 1 private
3. NatGateway for the private subnet.

Instances:
1. Frontend server serving web application with user data
2. Backend server for database.
3. Using SSH key 'ecskp'

Appliccation Load Balancer:
1. attached to frontend-sg 

Autoscaling Launch Template:
1. Launch template for Autoscaling Group 

DATA:

To get the latest AMI for Autoscaling


Autoscaling Group:
1. Condition to scale-up and scale-down 
2. cloud watch alarm for CPU utilization.
