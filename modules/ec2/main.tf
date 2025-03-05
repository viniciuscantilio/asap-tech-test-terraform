resource "aws_iam_role" "ssm_role" {
  name = "SSMRoleForEC2"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_policy" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ssm_profile" {
  name = "SSMInstanceProfileAsap"
  role = aws_iam_role.ssm_role.name
}

resource "aws_instance" "ssm_instance" {
  ami                    = "ami-05b10e08d247fb927"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["sg-0155206ac1d6afd98"]
  subnet_id              = "subnet-097622b2bded04bb9"



  iam_instance_profile = aws_iam_instance_profile.ssm_profile.name

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y amazon-ssm-agent
              sudo systemctl enable amazon-ssm-agent
              sudo systemctl start amazon-ssm-agent
              sudo yum install -y docker
              sudo service docker start
              sudo usermod -a -G docker ec2-user
              sudo yum install -y curl wget git
              curl -LO "https://dl.k8s.io/release/v1.25.0/bin/linux/amd64/kubectl"
              chmod +x ./kubectl
              sudo mv ./kubectl /usr/local/bin/kubectl
              curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
              curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.17.0/kind-linux-amd64
              chmod +x ./kind
              sudo mv ./kind /usr/local/bin/kind
              EOF

  tags = {
    Name = "AsapTechVinicius"
  }
}