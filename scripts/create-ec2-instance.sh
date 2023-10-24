
# Create instance EC2 with AWS CLI
aws ec2 run-instances \
  --image-id ami-1a2b3c4d5e6f7g8h9 \
  --instance-type t2.micro \
  --key-name MySSHKeyPair \
  --security-group-ids sg-0123456789abcdef0 \
  --subnet-id subnet-0123456789abcdef1 \
  --associate-public-ip-address

# Wait instance run
aws ec2 wait instance-running --instance-ids i-0123456789abcdef0

# get public IP from the instance
public_ip=$(aws ec2 describe-instances --instance-ids i-0123456789abcdef0 --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)

# SSH in the instance and execute commands for install Node.js
ssh -i MySSHKeyPair.pem ec2-user@$public_ip <<EOF
  # update the system
  sudo yum update -y

  # install Node.js and npm
  curl -sL https://rpm.nodesource.com/setup_14.x | sudo bash -
  sudo yum install -y nodejs
EOF

# Scaling Rules
aws autoscaling create-auto-scaling-group \
  --auto-scaling-group-name RandomGroupAutoScaling \
  --launch-configuration-name SomeLaunchConfiguration \
  --availability-zones us-east-1a us-east-1b \
  --min-size 2 \
  --max-size 5 \
  --desired-capacity 3

# Config Rules
aws autoscaling put-scaling-policy \
  --policy-name MyPolicyName \
  --auto-scaling-group-name RandomGroupAutoScaling \
  --scaling-adjustment 2 \
  --adjustment-type ChangeInCapacity
